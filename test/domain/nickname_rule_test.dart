import 'package:flutter_test/flutter_test.dart';
import 'package:pacer_app/domain/validation/nickname_rule.dart';

void main() {
  group('허용', () {
    for (final value in ['승욱', '재민', 'Pacer', 'pacer2026', 'a1', '개발자123']) {
      test('한글·영문·숫자 "$value"', () {
        expect(isValidNickname(value), isTrue);
      });
    }

    for (final value in ['승욱🔥', '🔥🔥', '👨‍👩‍👧‍👦2', '👍🏽승욱', '🇰🇷대표']) {
      test('이모지 포함 "$value"', () {
        expect(isValidNickname(value), isTrue);
      });
    }

    test('앞뒤 공백은 잘라내고 판정한다', () {
      expect(isValidNickname('  승욱  '), isTrue);
      expect(normalizeNickname('  승욱  '), '승욱');
    });
  });

  group('길이 위반', () {
    for (final value in ['김', '', '   ']) {
      test('"$value"', () {
        expect(findNicknameViolation(value), NicknameViolation.length);
      });
    }

    test('12자는 되고 13자는 안 된다', () {
      expect(findNicknameViolation('가' * 12), isNull);
      expect(findNicknameViolation('가' * 13), NicknameViolation.length);
    });
  });

  group('문자 위반', () {
    for (final entry in {
      '자음 단독': 'ㅋㅋ',
      '모음 단독': 'ㅜㅜ',
      '중간 공백': '신 승욱',
      '특수문자': '승욱!',
      '하이픈': '승-욱',
      '밑줄': 'pacer_dev',
    }.entries) {
      test('${entry.key} "${entry.value}"', () {
        expect(findNicknameViolation(entry.value), NicknameViolation.charset);
      });
    }
  });

  group('이모지 길이 계산', () {
    test('결합 이모지는 1자로 센다', () {
      // 가족(ZWJ) · 피부톤 · 국기 — 코드포인트는 여러 개지만 사람 눈에는 한 글자.
      expect(nicknameLength('👨‍👩‍👧‍👦'), 1);
      expect(nicknameLength('👍🏽'), 1);
      expect(nicknameLength('🇰🇷'), 1);
    });

    test('이모지 12개는 되고 13개는 안 된다', () {
      expect(isValidNickname('🔥' * 12), isTrue);
      expect(isValidNickname('🔥' * 13), isFalse);
    });

    test('한글+이모지 혼합 길이도 grapheme 기준이다', () {
      expect(nicknameLength('승욱🔥'), 3);
      expect(nicknameLength('승욱👨‍👩‍👧‍👦'), 3);
    });
  });
}
