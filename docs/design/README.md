# design — 디자인 시안

`Pacer_디자인시안_v1.html`은 **브라우저에서 바로 열리는 단일 파일 인터랙티브 프로토타입**이다.
빌드·서버 없이 파일을 더블클릭하면 iOS 디바이스 프레임 안에서 전 화면을 눌러볼 수 있다.

> 이 시안은 **참고 자료**다. 화면의 정본 스펙은 `../Pacer_화면정의서_v1.md`이며,
> 둘이 어긋나면 **화면정의서가 우선**한다. 시안이 더 맞다고 판단되면 화면정의서를 먼저 갱신한다.

## 화면 매핑 (화면정의서 ↔ 시안 컴포넌트)

| 화면 ID | 화면 | 시안 컴포넌트 |
|---------|------|---------------|
| S00 | 스플래시/진입 | `SplashScreen` |
| S01 | 로그인 | `LoginScreen`, `BrandMark` |
| S02 | 온보딩·닉네임 | `NicknameScreen`, `Onboarding`, `OnboardArt` |
| S03 | 온보딩·동의 | `ConsentScreen`, `CheckBox` |
| S10 | 홈/허브 | `HomeScreen`, `QuotaBadge` |
| S11 | 면접 준비·입력 | `JobInputScreen` |
| S11a | 직무 카테고리 선택 | `TargetJobScreen` |
| S12 | 지원자 정보 입력 | `ApplicantScreen` |
| S13 | 면접 설정 | `JobInputScreen` (설정 단계) |
| S20 | 면접 진행 | `InterviewScreen`, `ChatTurn`, `CoachBubble`, `UserBubble`, `RealtimeFeedback`, `TypingDots`, `SkipNote`, `DoneCard` |
| S30 | 최종 리포트 | `ReportScreen`, `ScoreRing`, `RadarChart`, `ShareCard` |
| S40 | 히스토리 목록 | `HistoryScreen` |
| S41 | 대화 전문 재열람 | `TranscriptScreen` |
| S42 | 성장 추이 (P1) | `GrowthChart`, `MiniBars` |
| S50 | 페이월 | `Paywall` |
| S60 | 설정 (P1) | `SettingsScreen`, `AppSettingsScreen`, `NotifyScreen`, `PrivacyScreen`, `EditProfileScreen`, `ProfileScreen` |
| S61 | 구독 관리 | `SubscribeScreen` |
| — | 알림함 | `InboxScreen`, `NotifRow` |
| — | 공통 UI | `Btn`, `Card`, `Chip`, `Pill`, `Sheet`, `Segmented`, `ProgressBar`, `Avatar`, `BottomTab`, `NavHeader`, `IOSDevice`, `IOSNavBar`, `IOSKeyboard` |

## 주의

- 시안 HTML은 프로토타입 번들(약 4MB, 폰트·JS 인라인)이다. **재추출 시 파일을 덮어쓰고 커밋**한다
  (버전을 늘려 파일을 쌓으면 레포 용량이 매 회 4MB씩 누적된다).
- 이 폴더는 문서다. `assets/`에 두거나 `pubspec.yaml`에 등록하지 않는다 — 앱 번들에 포함되면 안 된다.
