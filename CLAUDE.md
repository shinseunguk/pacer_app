# pacer_app — Flutter 앱 가이드

> 페이서(Pacer) 모바일 앱. 공통 개발 워크플로우는 상위 `Pacer/CLAUDE.md`를 따른다.
> 백엔드는 별도 레포 `pacer_server`(NestJS). 이 앱은 서버 API만 호출한다.

## 설계 문서 (docs/)
구현 전 반드시 참조한다.
- `docs/Pacer_기능명세_유저스토리_v1.md`
- `docs/Pacer_화면정의서_v1.md`
- **공유 문서(서버 레포가 정본)**: `pacer_server/docs/Pacer_기획서_v1.md`, `Pacer_MVP범위_v1.md` — 사본을 두지 않는다.
- **계약(서버 레포)**: `pacer_server/docs/Pacer_API명세_v1.md`, `Pacer_데이터모델_ERD_v1.md` — 앱은 이 API 명세대로 연동한다.

## 작업 가드레일 (Phase A)
- **범위**: **Phase A(클로즈드 베타, 결제 제외)만** 구현한다. **결제/페이월/IAP는 지금 구현하지 않는다.**
- **앱 마일스톤**: 온보딩 → 준비/설정 → 진행(SSE 스트리밍) → 리포트 → 히스토리 순으로.
- **계약 준수**: 서버 API 명세대로 연동한다. **서버 API 선개발 → 앱 연동** 순서(상위 `Pacer/CLAUDE.md` 참조).
- **plan 먼저**: 큰 작업은 plan을 제시·승인 후 진행한다.
- **시크릿**: LLM API 키·시크릿을 앱에 두지 않는다(서버 프록시 경유).

## 앱 특징 (요약)
- **텍스트 채팅 기반 AI 모의 면접**: 공고·직무를 입력하면 맞춤 질문이 생성되고, 채팅으로 면접을 진행한다.
- **실시간 스트리밍 응답**: 서버(SSE)에서 LLM 답변을 토큰 단위로 받아 화면에 흘려준다.
- **정량 피드백·리포트**: 답변별 점수/등급 + 최종 100점·합불 판정 리포트, 공유/내보내기.
- **성장 추적**: 종합 점수 추이 라인 차트 + 항목별 레이더 + 스트릭 등 참여 지표.
- **이어하기**: 면접 중 일시정지 → 나중에 이어서 진행 (상태 복구).
- **소셜 로그인 필수**: 카카오/애플/구글. 온보딩에서 닉네임 직접 입력.
- **횟수제**: 하루 기본 질문 20개(꼬리질문 제외), 자정 리셋. 서버가 카운트 관리.
- 시크릿/LLM 키는 앱에 두지 않는다. 모든 LLM 호출은 서버가 프록시한다.

---

## 아키텍처 패턴

**Clean Architecture + Riverpod** (상태관리·DI 모두 Riverpod로 통합, get_it 미사용).

```
lib/
├── core/            # 공통: 상수·테마·에러(Failure)·네트워크 클라이언트·라우터
├── data/            # DataSource(remote/local) · Repository 구현 · DTO(model)
├── domain/          # Entity · Repository 인터페이스 · UseCase
└── presentation/    # 화면(Screen/Widget) · Riverpod Provider(Notifier)
```

- **의존 방향**: `presentation → domain ← data`. `domain`은 Flutter·외부 패키지에 비의존(순수 Dart).
- **레이어 규칙**:
  - `presentation`은 `domain`의 UseCase/Entity만 참조. Repository 구현·DTO를 직접 참조하지 않는다.
  - `data`는 `domain`의 Repository 인터페이스를 구현한다.

### 패턴별 방침
| 관심사 | 패턴 / 라이브러리 | 방침 |
|--------|-------------------|------|
| 상태관리 | **Riverpod** (`Notifier` / `AsyncNotifier`) | 로딩/에러/데이터는 `AsyncValue`로 표현. `StatefulWidget` 남용 지양 |
| DI | **Riverpod Provider** | Repository·DataSource·UseCase를 Provider로 주입. 전역 싱글턴/서비스 로케이터 지양 |
| 라우팅 | **go_router** | 선언적 라우팅, 딥링크·리다이렉트(로그인 가드) 처리 |
| 모델 | **freezed + json_serializable** | DTO/Entity는 불변(immutable). `copyWith`·`fromJson`/`toJson` 코드 생성 |
| 네트워크 | **dio** | 인터셉터로 토큰 주입·에러 매핑. 면접 응답은 스트리밍(SSE) 수신 |
| 에러 처리 | **domain `Failure` + `AsyncValue.error`** | DataSource는 예외 → Repository에서 `Failure`로 변환 → presentation은 `AsyncValue`로 표시 |
| 로컬 저장 | `flutter_secure_storage`(토큰) / `shared_preferences`(설정) | 민감정보는 secure storage만 사용 |

> 위 패키지는 **도입 예정**이다. 실제 추가 시 `pubspec.yaml`에 반영하고 코드 생성(`build_runner`)을 설정한다.

---

## 코드 컨벤션
- **Effective Dart** 준수. 깊은 if-else 중첩보다 early return.
- 코드·주석은 영어, **사용자 노출 문자열은 한국어**(하드코딩 금지 → 상수/로컬라이즈).
- 위젯은 작게·단일 책임. `const` 생성자 적극 사용.
- 파일명 snake_case, 클래스 PascalCase. `final`/`const` 우선, `var` 남용 금지.

## 검증 명령 (테스트 단계에서 반드시 실행)
```bash
flutter analyze      # 정적 분석 — 경고 0 유지
flutter test         # 단위·위젯 테스트
```
- 새 로직(특히 UseCase·Notifier·Repository)에는 테스트를 함께 추가한다.

---

## 환경 / Flavor
- 환경 분리: **dev / prod**(필요 시 staging). 진입점 또는 `--dart-define`으로 구성.
- 환경별 주입값: API base URL, 소셜 키(카카오 등). 코드에 **하드코딩 금지**.
- 실행 예: `flutter run --dart-define-from-file=env/dev.json` (env/*.json은 `.gitignore`, 예시는 `env/dev.example.json`).
- 빌드 대상: iOS/Android 각각 dev/prod 번들 ID·앱 아이콘 구분 검토.

## 국제화 (l10n)
- `flutter_localizations` + `intl`, ARB 파일(`lib/l10n/app_ko.arb`, `app_en.arb`).
- 지원 로케일: **한국어(기본) / 영어**. (앱 UI 로컬라이즈 — 면접 "진행 언어" 선택과는 별개 개념)
- 모든 사용자 노출 문자열은 ARB를 통해서만. 화면에 문자열 하드코딩 금지.

## 네이티브 플랫폼 채널
> 기획서 명시 기능이자 포트폴리오 목표. 최소 하나는 실제 네이티브로 구현한다.

- 대상: **홈 위젯**(오늘 남은 무료 질문·스트릭) / **Live Activity**(면접 진행 2/5) / **로컬 푸시**(면접 리마인더).
- `MethodChannel` 네이밍: `com.pacer.pacer_app/<feature>` (예: `/widget`, `/live_activity`, `/notification`).
- 네이티브 구현은 `ios/`·`android/`에, Dart 래퍼는 `core/native/`에 둔다.

## 테스트·네이밍·금지 상세
- **테스트 우선순위**: UseCase > Notifier(상태) > Repository > 위젯. Mock은 `mocktail`.
- **네이밍**: Provider `<name>Provider`, 화면 `<Feature>Screen`, Notifier `<Feature>Notifier`, UseCase `<Verb><Noun>UseCase`.
- **금지**:
  - `print` 사용 금지 → `logger` 사용. **릴리스 빌드에서 민감정보(답변·토큰) 로그 금지**.
  - null assertion `!` 남용 금지 → `?.`·early return·기본값 사용.
  - 전역 가변 상태 금지. 비즈니스 로직을 위젯에 직접 작성 금지(→ Notifier/UseCase).

---

## 커밋 규칙
전역 `commit-convention` + 상위 `Pacer/CLAUDE.md` 워크플로우를 따른다.

- **형식**: Conventional Commits — `<타입>[범위]: <설명>`
  - 타입: `feat` / `fix` / `refactor` / `docs` / `style` / `test` / `chore`
  - 범위(선택): 기능/레이어 (예: `interview`, `auth`, `chart`)
- **이슈 연결**: 꼬리말에 `closed #<이슈번호>`
- **브랜치**: `main`에서 `<타입>/#<이슈번호>-<슬러그>` 로 분기. `main` 직접 커밋 금지.
- **금지**: 커밋 메시지에 `Co-Authored-By`·AI 서명/트레일러 추가 금지.
- **author**: `shinseunguk <krdut1@gmail.com>` (레포 로컬 git config에 설정됨).
- 커밋/푸시/PR은 **사용자가 요청할 때** 진행 (개발·테스트까지가 자동 범위).

예시:
```
feat(auth): 소셜 로그인(카카오·애플·구글) 화면 추가

- Riverpod AsyncNotifier로 로그인 상태 관리
- 온보딩 닉네임 입력 연동

closed #12
```
