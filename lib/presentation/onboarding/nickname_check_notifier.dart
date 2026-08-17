import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/error/failure.dart';
import '../../domain/usecases/check_nickname.dart';
import '../../domain/validation/nickname_rule.dart';
import '../providers/app_providers.dart';

/// 닉네임 입력 상태 (S02).
enum NicknameStatus {
  /// 아직 입력 전 — 안내도 오류도 표시하지 않는다.
  idle,

  /// 규칙 위반 — 서버에 묻지 않고 즉시 표시
  invalid,

  /// 서버에 중복 확인 중
  checking,

  /// 사용 가능
  available,

  /// 이미 쓰는 닉네임
  taken,

  /// 확인 실패(네트워크 등) — 제출은 막지 않고 서버 판정에 맡긴다.
  checkFailed,
}

class NicknameCheckState {
  const NicknameCheckState({this.status = NicknameStatus.idle, this.message});

  final NicknameStatus status;

  /// 사용자에게 보여줄 문구 (없으면 표시 안 함).
  final String? message;

  /// "다음"으로 넘어갈 수 있는 상태인가.
  bool get canSubmit =>
      status == NicknameStatus.available || status == NicknameStatus.checkFailed;

  bool get isError =>
      status == NicknameStatus.invalid || status == NicknameStatus.taken;
}

/// 타이핑이 멈춘 뒤 확인해 불필요한 호출을 줄인다.
const _debounce = Duration(milliseconds: 400);

final nicknameCheckProvider =
    NotifierProvider.autoDispose<NicknameCheckNotifier, NicknameCheckState>(
      NicknameCheckNotifier.new,
    );

class NicknameCheckNotifier extends AutoDisposeNotifier<NicknameCheckState> {
  Timer? _timer;

  /// 응답이 늦게 도착했을 때 최신 입력만 반영하기 위한 순번.
  int _requestId = 0;

  @override
  NicknameCheckState build() {
    ref.onDispose(() => _timer?.cancel());
    return const NicknameCheckState();
  }

  void onChanged(String value) {
    _timer?.cancel();
    _requestId += 1;

    if (normalizeNickname(value).isEmpty) {
      state = const NicknameCheckState();
      return;
    }

    final violation = findNicknameViolation(value);
    if (violation != null) {
      state = NicknameCheckState(
        status: NicknameStatus.invalid,
        message: nicknameViolationFailure(violation).message,
      );
      return;
    }

    state = const NicknameCheckState(status: NicknameStatus.checking);
    _timer = Timer(_debounce, () => _check(value, _requestId));
  }

  Future<void> _check(String value, int requestId) async {
    try {
      final available = await ref.read(checkNicknameProvider)(value);
      if (requestId != _requestId) return; // 그사이 입력이 바뀌었다.

      state = available
          ? const NicknameCheckState(
              status: NicknameStatus.available,
              message: '사용할 수 있는 닉네임이에요.',
            )
          : const NicknameCheckState(
              status: NicknameStatus.taken,
              message: '이미 사용 중인 닉네임이에요.',
            );
    } on Object catch (error) {
      if (requestId != _requestId) return;

      // 확인에 실패해도 진행은 막지 않는다 — 최종 판정은 서버가 한다.
      state = NicknameCheckState(
        status: NicknameStatus.checkFailed,
        message: error is Failure ? error.message : null,
      );
    }
  }
}
