// The bot's brain as a browser Web Worker. Build it with:
//   dart compile js -O2 -o app/web/bot_worker.js packages/checkers_engine/bin/bot_worker.dart
import 'dart:js_interop';

import 'package:checkers_engine/checkers_engine.dart';

extension type _Scope._(JSObject _) implements JSObject {
  external set onmessage(JSFunction f);
  external void postMessage(JSString m);
}

extension type _Msg._(JSObject _) implements JSObject {
  external JSAny? get data;
}

@JS('self')
external _Scope get _self;

void main() {
  _self.onmessage = ((_Msg e) {
    String out;
    try {
      out = runBotJob((e.data as JSString).toDart);
    } catch (err) {
      out = 'ERROR $err';
    }
    _self.postMessage(out.toJS);
  }).toJS;
}
