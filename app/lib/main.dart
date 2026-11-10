import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      title: 'licheckers',
      debugShowCheckedModeBanner: false,
      themeMode: s.themeMode,
      theme: appTheme(Brightness.light),
      darkTheme: appTheme(Brightness.dark),
      // Font size setting: scales every text in the app.
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: TextScaler.linear(s.textScale)),
        child: child!,
      ),
      home: const HomeScreen(),
    );
  }
}
