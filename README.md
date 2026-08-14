# pacer_app

> 페이서(Pacer) — 면접의 페이스를 잡아주는 AI 코치. Flutter 모바일 앱 (iOS / Android).

채용 공고·직무를 입력하면 AI가 맞춤 면접 질문을 생성하고, 텍스트 채팅으로 모의 면접을 진행한 뒤 정량 피드백과 성장 추적을 제공하는 앱의 클라이언트입니다.

## 기술 스택

| 영역 | 스택 |
|------|------|
| 프레임워크 | Flutter |
| 상태관리 / 아키텍처 | Riverpod(또는 Bloc) + Clean Architecture + get_it(DI) |
| 네이티브 연동 | 플랫폼 채널 (홈 위젯 · Live Activity · 로컬 푸시) |

> 백엔드는 별도 저장소 `pacer_server` (NestJS) 를 사용합니다.

> 아직 스캐폴딩 전입니다. `flutter create` 로 프로젝트를 생성할 예정입니다.
