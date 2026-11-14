import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/fonts.dart';
import 'src/i18n.dart';
import 'src/screens/home.dart';
import 'src/settings.dart';
import 'src/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(ProviderScope(
    overrides: [prefsProvider.overrideWithValue(prefs)],
    child: const LicheckersApp(),
  ));
}

class LicheckersApp extends ConsumerWidget {
  const LicheckersApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(settingsProvider);
    return MaterialApp(
      onGenerateTitle: (c) => c.l.appTitle,
      debugShowCheckedModeBanner: false,
      // Every text comes from lib/l10n. null locale = the phone's language.
      locale: s.locale == null ? null : Locale(s.locale!),
      supportedLocales: L.supportedLocales,
      localizationsDelegates: appLocalizationsDelegates,
      themeMode: s.themeMode,
      theme: appTheme(Brightness.light),
      darkTheme: appTheme(Brightness.dark),
      // Font size setting: scales every text in the app.
      builder: (context, child) => _FontGate(
        code: Localizations.localeOf(context).languageCode,
        child: MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: TextScaler.linear(s.textScale)),
          child: child!,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

/// Loads the font a language needs (only Arabic so far) the first time that
/// language is shown, then redraws so the letters appear.
class _FontGate extends StatefulWidget {
  final String code;
  final Widget child;
  const _FontGate({required this.code, required this.child});

  @override
  State<_FontGate> createState() => _FontGateState();
}

class _FontGateState extends State<_FontGate> {
  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void didUpdateWidget(_FontGate old) {
    super.didUpdateWidget(old);
    if (old.code != widget.code) _load();
  }

  Future<void> _load() async {
    await ensureFontsFor(widget.code);
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
