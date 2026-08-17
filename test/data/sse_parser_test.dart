import 'package:flutter_test/flutter_test.dart';
import 'package:pacer_app/data/datasources/sse_parser.dart';

void main() {
  test('완결된 블록들을 순서대로 이벤트로 만든다', () async {
    final events = await parseSseStream(
      Stream.fromIterable([
        'event: message.delta\ndata: {"delta":"안녕"}\n\n',
        'event: message.done\ndata: {"seq":3}\n\n',
      ]),
    ).toList();

    expect(events.map((event) => event.event), [
      'message.delta',
      'message.done',
    ]);
    expect(events.first.data['delta'], '안녕');
    expect(events.last.data['seq'], 3);
  });

  test('청크가 블록 중간에서 끊겨도 이어붙여 파싱한다', () async {
    final events = await parseSseStream(
      Stream.fromIterable(['event: message.de', 'lta\ndata: {"del', 'ta":"캐시"}\n\n']),
    ).toList();

    expect(events, hasLength(1));
    expect(events.single.event, 'message.delta');
    expect(events.single.data['delta'], '캐시');
  });

  test('여러 이벤트가 한 청크에 몰려 와도 나눠 준다', () async {
    final events = await parseSseStream(
      Stream.fromIterable([
        'event: message.delta\ndata: {"delta":"a"}\n\n'
            'event: message.delta\ndata: {"delta":"b"}\n\n',
      ]),
    ).toList();

    expect(events.map((event) => event.data['delta']), ['a', 'b']);
  });

  test('마지막 블록에 빈 줄이 없어도 흘려보낸다', () async {
    final events = await parseSseStream(
      Stream.fromIterable(['event: interview.done\ndata: {"sessionId":"s1"}']),
    ).toList();

    expect(events.single.data['sessionId'], 's1');
  });

  test('주석·빈 블록·깨진 JSON은 건너뛴다', () async {
    final events = await parseSseStream(
      Stream.fromIterable([
        ': keep-alive\n\n',
        '\n\n',
        'event: message.delta\ndata: {oops\n\n',
        'event: message.delta\ndata: {"delta":"ok"}\n\n',
      ]),
    ).toList();

    expect(events, hasLength(1));
    expect(events.single.data['delta'], 'ok');
  });

  test('event 줄이 없으면 기본 이름 message를 쓴다', () {
    final event = parseSseBlock('data: {"a":1}');

    expect(event?.event, 'message');
  });
}
