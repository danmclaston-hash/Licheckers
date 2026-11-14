// Install the web app to the home screen. Real work on the web; on phones
// and desktop apps (already installed) everything answers "no".
export 'install_prompt_stub.dart'
    if (dart.library.js_interop) 'install_prompt_web.dart';
