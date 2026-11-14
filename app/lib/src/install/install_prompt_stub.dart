bool get installSupported => false;
bool isInstalled() => true;
bool canPromptInstall() => false;
bool isIosSafari() => false;
Future<bool> promptInstall() async => false;
