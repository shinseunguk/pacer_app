import 'dart:convert';

/// One `event:` + `data:` block from a `text/event-stream` response.
class SseEvent {
  const SseEvent({required this.event, required this.data});

  final String event;
  final Map<String, dynamic> data;
}

const _blockSeparator = '\n\n';

/// Turns raw SSE text chunks into events.
///
/// Chunks arrive at arbitrary boundaries, so a partial block is buffered until
/// its terminating blank line shows up. Unparseable blocks are skipped rather
/// than killing the stream.
Stream<SseEvent> parseSseStream(Stream<String> source) async* {
  var buffer = '';

  await for (final chunk in source) {
    buffer += chunk;

    var index = buffer.indexOf(_blockSeparator);
    while (index != -1) {
      final block = buffer.substring(0, index);
      buffer = buffer.substring(index + _blockSeparator.length);

      final event = parseSseBlock(block);
      if (event != null) yield event;

      index = buffer.indexOf(_blockSeparator);
    }
  }

  final tail = parseSseBlock(buffer);
  if (tail != null) yield tail;
}

/// Parses a single block. Returns null when it carries no usable event.
SseEvent? parseSseBlock(String block) {
  if (block.trim().isEmpty) return null;

  var name = 'message';
  final dataLines = <String>[];

  for (final line in const LineSplitter().convert(block)) {
    if (line.startsWith(':')) continue; // comment / keep-alive
    if (line.startsWith('event:')) {
      name = line.substring('event:'.length).trim();
    } else if (line.startsWith('data:')) {
      dataLines.add(line.substring('data:'.length).trim());
    }
  }

  if (dataLines.isEmpty) return null;

  try {
    final decoded = jsonDecode(dataLines.join('\n'));
    if (decoded is! Map<String, dynamic>) return null;
    return SseEvent(event: name, data: decoded);
  } on FormatException {
    return null;
  }
}
