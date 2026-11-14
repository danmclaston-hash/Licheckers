import 'dart:async';
import 'dart:js_interop';

import 'package:checkers_core/checkers_core.dart';
import 'package:checkers_engine/checkers_engine.dart';

extension type _Worker._(JSObject _) implements JSObject {
  external factory _Worker(String url);
  external void postMessage(JSString m);
  external void terminate();
  external set onmessage(JSFunction f);
  external set onerror(JSFunction f);
}

extension type _Msg._(JSObject _) implements JSObject {
  external JSAny? get data;
}

final Map<_Worker, Completer<Move>> _live = {};

/// Finds the bot's move in a Web Worker, so the page stays smooth.
/// If the worker cannot start, falls back to a short think on the page.
Future<Move> askBot(Game game, String variantId, int level, int seed,
    {int? capMs}) {
  final job = encodeBotJob(game, variantId, level, seed, capMs: capMs);
  final done = Completer<Move>();

  void fallback() {
    if (done.isCompleted) return;
    // Cap the level so the page is only blocked briefly.
    final capped = encodeBotJob(game, variantId, level.clamp(1, 6), seed);
    done.complete(decodeBotMove(game, runBotJob(capped)));
  }

  try {
    final w = _Worker('bot_worker.js');
    _live[w] = done;
    void close() {
      _live.remove(w);
      w.terminate();
    }

    w.onmessage = ((_Msg e) {
      final text = (e.data as JSString).toDart;
      close();
      if (done.isCompleted) return;
      if (text.startsWith('ERROR')) {
        fallback();
      } else {
        done.complete(decodeBotMove(game, text));
      }
    }).toJS;
    w.onerror = ((JSAny? _) {
      close();
      fallback();
    }).toJS;
    w.postMessage(job.toJS);
  } catch (_) {
    fallback();
  }
  return done.future;
}

/// Stop any thinking that is still running (new game, undo...).
void cancelBot() {
  for (final e in Map.of(_live).entries) {
    e.key.terminate();
    if (!e.value.isCompleted) e.value.completeError('cancelled');
  }
  _live.clear();
}
