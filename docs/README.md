# docs — 앱 설계 문서

`pacer_app` 구현의 기준이 되는 설계 문서를 둔다.
**API·ERD 계약**은 서버 레포(`pacer_server/docs/`)를 원본으로 참조한다.

## 배치 문서 (역할별 분산 — 앱 담당)

| 파일 | 내용 | 상태 |
|------|------|------|
| `Pacer_기능명세_유저스토리_v1.md` | 기능 명세 / 유저 스토리 | ✅ 배치 |
| `Pacer_화면정의서_v1.md` | 화면 구성·상태(로딩/에러/빈 상태) | ✅ 배치 |
| `design/` | 디자인 시안 (단일 파일 인터랙티브 프로토타입) | ✅ 배치 |

## 공유 문서 (서버 레포가 정본)

양쪽 레포에 걸친 문서는 **사본을 만들지 않고** 서버 정본을 링크한다 (결정: [ADR 0005](https://github.com/shinseunguk/pacer_server/blob/main/docs/decisions/0005-docs-layout.md)).

| 문서 | 내용 |
|------|------|
| [`Pacer_기획서_v1.md`](https://github.com/shinseunguk/pacer_server/blob/main/docs/Pacer_%EA%B8%B0%ED%9A%8D%EC%84%9C_v1.md) | 서비스 기획 |
| [`Pacer_MVP범위_v1.md`](https://github.com/shinseunguk/pacer_server/blob/main/docs/Pacer_MVP%EB%B2%94%EC%9C%84_v1.md) | Phase별 구현 범위 — 앱 작업 가드레일의 근거 |

> 계약 문서(API·ERD)와 서버 아키텍처도 `pacer_server/docs/`에 있다.
> 결정 기록(ADR)은 [`pacer_server/docs/decisions/`](https://github.com/shinseunguk/pacer_server/blob/main/docs/decisions/)에 모은다.
