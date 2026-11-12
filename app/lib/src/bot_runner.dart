// Runs the bot away from the screen thread. Phones/desktop: a Dart isolate.
// Browser: a Web Worker (so the page never freezes while the bot thinks).
export 'bot_runner_io.dart' if (dart.library.js_interop) 'bot_runner_web.dart';
