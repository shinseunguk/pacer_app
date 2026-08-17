import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import '../../core/error/failure.dart';
import '../../domain/entities/social_provider.dart';
import 'social_auth_service.dart';

/// 카카오 로그인 — SDK로 받은 **액세스 토큰**을 서버에 넘긴다.
///
/// 서버(`KakaoSocialVerifier`)가 그 토큰으로 `kapi.kakao.com/v2/user/me` 를 호출해
/// 검증하므로, 앱은 토큰만 전달하고 사용자 정보를 직접 다루지 않는다.
class KakaoSocialAuthService implements SocialAuthService {
  const KakaoSocialAuthService();

  @override
  Future<SocialCredential> authenticate(SocialProvider provider) async {
    if (provider != SocialProvider.kakao) {
      throw const ServerFailure('아직 준비 중인 로그인 방식이에요.');
    }

    try {
      final token = await _issueToken();
      return SocialCredential(idToken: token.accessToken);
    } on PlatformException catch (error) {
      // 사용자가 로그인 창을 닫은 것은 오류가 아니다 — 조용히 되돌린다.
      if (error.code == 'CANCELED') throw const SignInCancelled();
      throw ServerFailure(error.message ?? '카카오 로그인에 실패했어요.');
    } on KakaoException catch (error) {
      throw ServerFailure(error.message ?? '카카오 로그인에 실패했어요.');
    }
  }

  /// 카카오톡이 깔려 있으면 앱으로, 없으면 카카오계정(웹)으로 로그인한다.
  Future<OAuthToken> _issueToken() async {
    if (!await isKakaoTalkInstalled()) {
      return UserApi.instance.loginWithKakaoAccount();
    }

    try {
      return await UserApi.instance.loginWithKakaoTalk();
    } on PlatformException catch (error) {
      // 톡 로그인을 사용자가 취소한 경우는 그대로 알린다.
      if (error.code == 'CANCELED') rethrow;
      // 톡 로그인이 불가능한 상황(구버전 등)이면 계정 로그인으로 넘어간다.
      return UserApi.instance.loginWithKakaoAccount();
    }
  }
}
