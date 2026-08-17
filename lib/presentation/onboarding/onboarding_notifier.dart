import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/agreements.dart';

/// Draft collected across S02(닉네임) → S03(동의) before it is submitted once.
class OnboardingDraft {
  const OnboardingDraft({
    this.nickname = '',
    this.agreements = const Agreements(),
  });

  final String nickname;
  final Agreements agreements;

  OnboardingDraft copyWith({String? nickname, Agreements? agreements}) {
    return OnboardingDraft(
      nickname: nickname ?? this.nickname,
      agreements: agreements ?? this.agreements,
    );
  }
}

final onboardingDraftProvider =
    NotifierProvider<OnboardingDraftNotifier, OnboardingDraft>(
      OnboardingDraftNotifier.new,
    );

class OnboardingDraftNotifier extends Notifier<OnboardingDraft> {
  @override
  OnboardingDraft build() => const OnboardingDraft();

  void setNickname(String nickname) {
    state = state.copyWith(nickname: nickname);
  }

  void toggleTerms(bool value) {
    state = state.copyWith(agreements: state.agreements.copyWith(terms: value));
  }

  void togglePrivacy(bool value) {
    state = state.copyWith(
      agreements: state.agreements.copyWith(privacy: value),
    );
  }

  void toggleLlmConsent(bool value) {
    state = state.copyWith(
      agreements: state.agreements.copyWith(llmConsent: value),
    );
  }

  void toggleMarketing(bool value) {
    state = state.copyWith(
      agreements: state.agreements.copyWith(marketing: value),
    );
  }

  void toggleAll(bool value) {
    state = state.copyWith(agreements: state.agreements.copyWithAll(value));
  }
}
