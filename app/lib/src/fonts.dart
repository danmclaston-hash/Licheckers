import 'package:flutter/services.dart';

/// Fonts for scripts that the default font cannot draw. Loaded only when a
/// language needs them, so people who never pick Arabic never download it
/// (it matters on costly mobile data). Works offline once the app is cached.
const arabicFont = 'NotoSansArabic';
bool _arabicLoaded = false;

Future<void> ensureFontsFor(String? languageCode) async {
  if (languageCode == 'ar' && !_arabicLoaded) {
    _arabicLoaded = true;
    try {
      await (FontLoader(arabicFont)
            ..addFont(rootBundle.load('assets/fonts/NotoSansArabic-Regular.ttf'))
            ..addFont(rootBundle.load('assets/fonts/NotoSansArabic-Bold.ttf')))
          .load();
    } catch (_) {
      _arabicLoaded = false; // try again next time
    }
  }
}
