/// 닉네임 규칙 — 서버(`pacer_server/src/users/nickname.rule.ts`)와 판정이 같아야 한다.
///
/// - 허용: 한글 완성형 · 영문 · 숫자 · 이모지
/// - 길이: 2~12자. 이모지는 여러 코드포인트가 합쳐지므로 **grapheme cluster** 기준
///   (가족 👨‍👩‍👧‍👦, 피부톤 👍🏽, 국기 🇰🇷 모두 1자)
/// - 불가: 공백, 특수문자, 자음/모음 단독(ㅋㅋ·ㅜㅜ)
library;

import 'package:characters/characters.dart';

const nicknameMinLength = 2;
const nicknameMaxLength = 12;

/// 한글 완성형 · 영문 · 숫자 (자음/모음 단독 제외)
final _plainCharacter = RegExp(r'^[가-힣a-zA-Z0-9]$');

/// 이모지 본체 — 유니코드 속성 이스케이프는 `unicode: true`에서만 유효하다.
// ignore: valid_regexps
final _pictographic = RegExp(r'\p{Extended_Pictographic}', unicode: true);

/// 국기(지역 표시 문자) — Extended_Pictographic에 없어 따로 본다.
final _regionalIndicator = RegExp(r'[\u{1F1E6}-\u{1F1FF}]', unicode: true);

enum NicknameViolation {
  /// 2~12자 범위를 벗어남
  length,

  /// 허용하지 않는 문자가 섞임
  charset,
}

/// 저장·비교에 쓰는 정본 형태 (앞뒤 공백 제거).
///
/// 유니코드 정규화(NFC)는 서버가 담당한다 — Dart 코어에 정규화 API가 없고,
/// 한국어 IME는 조합 완료된(NFC) 문자열을 주므로 실사용에서 문제되지 않는다.
String normalizeNickname(String value) => value.trim();

bool _isEmoji(String grapheme) =>
    _pictographic.hasMatch(grapheme) || _regionalIndicator.hasMatch(grapheme);

bool _isAllowed(String grapheme) =>
    _plainCharacter.hasMatch(grapheme) || _isEmoji(grapheme);

/// 사람이 세는 단위로 쪼갠 길이.
int nicknameLength(String value) => normalizeNickname(value).characters.length;

/// 규칙 위반 사유. 통과하면 null.
NicknameViolation? findNicknameViolation(String value) {
  final graphemes = normalizeNickname(value).characters;

  if (graphemes.length < nicknameMinLength ||
      graphemes.length > nicknameMaxLength) {
    return NicknameViolation.length;
  }
  return graphemes.every(_isAllowed) ? null : NicknameViolation.charset;
}

bool isValidNickname(String value) => findNicknameViolation(value) == null;
