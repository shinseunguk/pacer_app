/// Onboarding consents (S03). The first three are required by the server.
class Agreements {
  const Agreements({
    this.terms = false,
    this.privacy = false,
    this.llmConsent = false,
    this.marketing = false,
  });

  final bool terms;
  final bool privacy;
  final bool llmConsent;
  final bool marketing;

  bool get allRequiredAccepted => terms && privacy && llmConsent;

  bool get allAccepted => allRequiredAccepted && marketing;

  Agreements copyWith({
    bool? terms,
    bool? privacy,
    bool? llmConsent,
    bool? marketing,
  }) {
    return Agreements(
      terms: terms ?? this.terms,
      privacy: privacy ?? this.privacy,
      llmConsent: llmConsent ?? this.llmConsent,
      marketing: marketing ?? this.marketing,
    );
  }

  Agreements copyWithAll(bool value) {
    return Agreements(
      terms: value,
      privacy: value,
      llmConsent: value,
      marketing: value,
    );
  }
}
