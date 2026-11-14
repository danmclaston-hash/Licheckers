import 'dart:js_interop';

@JS('lichCanInstall')
external JSBoolean _canInstall();
@JS('lichInstall')
external JSPromise<JSString> _install();
@JS('lichIsInstalled')
external JSBoolean _isInstalled();
@JS('lichIsIos')
external JSBoolean _isIos();

bool get installSupported => true;

bool _safe(JSBoolean Function() f, bool fallback) {
  try {
    return f().toDart;
  } catch (_) {
    return fallback; // the page script is missing: behave as "cannot"
  }
}

/// Already on the home screen (or opened as an installed app)?
bool isInstalled() => _safe(() => _isInstalled(), true);

/// Did the browser offer an install (Chrome, Edge, Samsung Internet...)?
bool canPromptInstall() => _safe(() => _canInstall(), false);

/// iPhone/iPad Safari: no install button exists, people use the Share menu.
bool isIosSafari() => _safe(() => _isIos(), false);

/// Shows the browser's own install question. true = the person said yes.
Future<bool> promptInstall() async {
  try {
    final outcome = (await _install().toDart).toDart;
    return outcome == 'accepted';
  } catch (_) {
    return false;
  }
}
