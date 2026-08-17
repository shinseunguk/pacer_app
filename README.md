# pacer_app

> 페이서(Pacer) — 면접의 페이스를 잡아주는 AI 코치. Flutter 모바일 앱 (iOS / Android).

채용 공고·직무를 입력하면 AI가 맞춤 면접 질문을 생성하고, 텍스트 채팅으로 모의 면접을 진행한 뒤 정량 피드백과 성장 추적을 제공하는 앱의 클라이언트입니다.

## 기술 스택

| 영역 | 스택 |
|------|------|
| 프레임워크 | Flutter |
| 상태관리 / DI | Riverpod (`Notifier` / `AsyncNotifier`) |
| 아키텍처 | Clean Architecture (`core` / `data` / `domain` / `presentation`) |
| 라우팅 | go_router (로그인 가드 리다이렉트) |
| 네트워크 | dio (+ 토큰 인터셉터, 면접 응답은 SSE 스트리밍) |
| 모델 | freezed + json_serializable |
| 저장소 | flutter_secure_storage(토큰) · shared_preferences(설정) |
| 국제화 | ARB (`lib/l10n/app_ko.arb`, `app_en.arb`) |

> 백엔드는 별도 저장소 `pacer_server` (NestJS) 를 사용합니다. API 계약은 `pacer_server/docs/Pacer_API명세_v1.md`.

## 실행

```bash
# 1) 백엔드 (별도 터미널)
cd ../pacer_server && docker compose up -d && npm run start:dev

# 2) 환경 파일 준비 (env/*.json 은 gitignore 대상)
cp env/dev.example.json env/dev.json

# 3) 앱 실행
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # freezed/json 코드 생성
flutter run --dart-define-from-file=env/dev.json
```

- iOS 시뮬레이터는 `http://localhost:3000/v1`, Android 에뮬레이터는 `http://10.0.2.2:3000/v1` 을 사용합니다.
- **dev 빌드의 로그인**은 서버의 MockSocialVerifier와 짝을 이루는 목 소셜 로그인을 사용합니다.
  실제 카카오/애플 SDK 연동은 네이티브 키 발급 후 붙입니다.

## 빌드 플레이버 · 브랜드 자산

- **Android**: `dev` / `prod` 플레이버. dev는 `com.pacer.pacer_app.dev` 로 패키지명이 갈려 한 기기에 함께 설치됩니다.
  ```bash
  flutter run   --flavor dev  --dart-define-from-file=env/dev.json
  flutter build appbundle --flavor prod --dart-define-from-file=env/prod.json
  ```
- **iOS**: 번들 ID 분리는 Xcode 스킴·빌드 구성 추가가 필요해 아직 적용하지 않았습니다(단일 번들로 베타 배포).
  서버 주소는 `--dart-define-from-file` 로 분리됩니다.
- **아이콘·스플래시**: 원본은 `assets/brand/`, 생성 스크립트는 `tool/generate_brand_assets.py`.
  ```bash
  python3 tool/generate_brand_assets.py     # 원본 PNG 재생성 (pillow 필요)
  dart run flutter_launcher_icons            # 앱 아이콘
  dart run flutter_native_splash:create      # 네이티브 스플래시
  ```

## 검증

```bash
flutter analyze     # 정적 분석 (경고 0 유지)
flutter test        # 단위·위젯 테스트

# 실서버 계약 테스트 (서버가 떠 있어야 함)
PACER_SERVER_E2E=1 flutter test test/contract
```

CI(`.github/workflows/ci.yml`)는 push·PR마다 코드 생성 최신 여부 → `flutter analyze` → `flutter test` 를 실행합니다.
계약 테스트는 서버가 없으면 자동으로 건너뜁니다.

## 구현 현황 (Phase A)

| 화면 | 상태 |
|------|------|
| S00 스플래시 · S01 로그인 | 완료 |
| S02 닉네임 · S03 동의 | 완료 |
| S10 홈(잔여 한도·최근 면접) | 완료 |
| S11 공고 입력 · S11a 직무 선택 · S12 지원자 정보 · S13 설정 | 완료 |
| S20 면접 진행 (SSE 스트리밍 · 스킵 · 일시정지/이어하기) | 완료 |
| S30 최종 리포트 | 완료 |
| S40 히스토리 · S41 대화 전문 | 완료 |
| S42 성장 추이 · S50 페이월 · S60 설정 | P1 / Phase B |
