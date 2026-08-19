import 'package:sentry_flutter/sentry_flutter.dart';

/// Sentry로 나가는 이벤트에서 민감 정보를 걷어낸다.
///
/// 이 앱은 사용자가 **면접 답변·자기소개·공고 원문**을 직접 입력한다 (민감 개인정보).
/// 필드 이름을 하나씩 지우는 방식은 화면이 늘 때마다 빠뜨리기 쉬우므로,
/// **본문은 통째로 버리고 남길 것만 골라 남긴다.**
///
/// ⚠️ `copyWith(x: null)`은 필드를 **지우지 못한다** — `null`을 "변경 없음"으로 본다.
/// 그래서 비워야 하는 객체는 `copyWith`가 아니라 **새로 만들어** 교체한다.

/// 남겨도 되는 헤더 — 디버깅에 필요하고 개인정보가 아닌 것만.
const _allowedHeaders = {
  'content-type',
  'content-length',
  'user-agent',
  'accept',
};

/// breadcrumb에서 남겨도 되는 키 — 원문이 아닌 메타데이터만.
const _allowedCrumbData = {'method', 'status_code', 'reason'};

const _redacted = '[redacted]';

/// 예외 이벤트에서 요청 본문·사용자 정보·부가 컨텍스트를 제거한다.
SentryEvent? scrubEvent(SentryEvent event, Hint hint) {
  final request = event.request;

  return event.copyWith(
    request: request == null ? null : _scrubRequest(request),
    // id만 남긴 사용자로 통째로 교체한다 — 이메일·닉네임은 새로 만들어야 지워진다.
    // SentryUser는 식별 필드가 최소 하나 필요해서, id가 없으면 마스킹 값을 넣는다.
    user: event.user == null
        ? null
        : SentryUser(id: event.user!.id ?? _redacted),
    // ignore: deprecated_member_use — 구 SDK 경로가 채울 수 있어 방어적으로 비운다.
    extra: const {},
  );
}

/// 이동 경로만 남기고 데이터는 버린다 — 네트워크 breadcrumb에 본문이 실린다.
Breadcrumb? scrubBreadcrumb(Breadcrumb? crumb, Hint hint) {
  if (crumb == null) return null;

  return Breadcrumb(
    message: crumb.message?.split('?').first,
    timestamp: crumb.timestamp,
    category: crumb.category,
    data: _safeCrumbData(crumb.data),
    level: crumb.level,
    type: crumb.type,
  );
}

/// 본문·쿼리·쿠키를 버린 새 요청을 만든다.
///
/// `cookies`를 넘기지 않으면 생성자가 헤더에서 찾아 채우는데,
/// 헤더를 먼저 걸러 `cookie`를 없앴으므로 결과는 항상 비어 있다.
SentryRequest _scrubRequest(SentryRequest request) {
  return SentryRequest(
    // URL에 붙은 쿼리스트링도 잘라낸다.
    url: request.url?.split('?').first,
    method: request.method,
    queryString: request.queryString == null ? null : _redacted,
    // 본문에 답변 원문이 들어온다 — 통째로 버린다.
    data: _redacted,
    headers: _filterHeaders(request.headers),
    fragment: request.fragment,
    apiTarget: request.apiTarget,
  );
}

Map<String, dynamic>? _safeCrumbData(Map<String, dynamic>? data) {
  if (data == null) return null;

  final safe = <String, dynamic>{};
  for (final entry in data.entries) {
    if (_allowedCrumbData.contains(entry.key)) safe[entry.key] = entry.value;
  }
  return safe.isEmpty ? null : safe;
}

Map<String, String>? _filterHeaders(Map<String, String>? headers) {
  if (headers == null) return null;

  final filtered = <String, String>{};
  headers.forEach((key, value) {
    if (_allowedHeaders.contains(key.toLowerCase())) filtered[key] = value;
  });
  return filtered;
}
