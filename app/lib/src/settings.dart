import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Everything the user can change in Settings. Saved on the device, so it
/// works offline. Each player's choices only change THEIR screen.
class AppSettings {
  final ThemeMode themeMode;
  final String boardTheme;
  final String pieceStyle;

  /// Milliseconds a piece takes to slide one step. 0 = no animation.
  final int animMs;
  final bool showCoords;
  final bool showLegalMoves;

  /// The small (i) buttons that explain things.
  final bool showInfo;
  final double textScale;

  /// App language code ('en', 'fr', 'sw', 'lg', 'ar', 'pt', 'es').
  /// null = follow the phone's language.
  final String? locale;

  /// Sounds and vibration for moves, captures, kings, low time, game end.
  final bool sound;

  /// The variant last played from the home screen (remembered).
  final String variant;

  const AppSettings({
    this.themeMode = ThemeMode.system,
    this.boardTheme = 'walnut',
    this.pieceStyle = 'classic',
    this.animMs = 220,
    this.showCoords = true,
    this.showLegalMoves = true,
    this.showInfo = true,
    this.textScale = 1.0,
    this.locale,
    this.sound = true,
    this.variant = 'english',
  });

  AppSettings copyWith({
    ThemeMode? themeMode,
    String? boardTheme,
    String? pieceStyle,
    int? animMs,
    bool? showCoords,
    bool? showLegalMoves,
    bool? showInfo,
    double? textScale,
    String? Function()? locale,
    bool? sound,
    String? variant,
  }) =>
      AppSettings(
        themeMode: themeMode ?? this.themeMode,
        boardTheme: boardTheme ?? this.boardTheme,
        pieceStyle: pieceStyle ?? this.pieceStyle,
        animMs: animMs ?? this.animMs,
        showCoords: showCoords ?? this.showCoords,
        showLegalMoves: showLegalMoves ?? this.showLegalMoves,
        showInfo: showInfo ?? this.showInfo,
        textScale: textScale ?? this.textScale,
        locale: locale != null ? locale() : this.locale,
        sound: sound ?? this.sound,
        variant: variant ?? this.variant,
      );

  Map<String, dynamic> toJson() => {
        'themeMode': themeMode.name,
        'boardTheme': boardTheme,
        'pieceStyle': pieceStyle,
        'animMs': animMs,
        'showCoords': showCoords,
        'showLegalMoves': showLegalMoves,
        'showInfo': showInfo,
        'textScale': textScale,
        'locale': locale,
        'sound': sound,
        'variant': variant,
      };

  factory AppSettings.fromJson(Map<String, dynamic> j) {
    const d = AppSettings();
    return AppSettings(
      themeMode: ThemeMode.values.firstWhere(
          (m) => m.name == j['themeMode'],
          orElse: () => d.themeMode),
      boardTheme: j['boardTheme'] as String? ?? d.boardTheme,
      pieceStyle: j['pieceStyle'] as String? ?? d.pieceStyle,
      animMs: j['animMs'] as int? ?? d.animMs,
      showCoords: j['showCoords'] as bool? ?? d.showCoords,
      showLegalMoves: j['showLegalMoves'] as bool? ?? d.showLegalMoves,
      showInfo: j['showInfo'] as bool? ?? d.showInfo,
      textScale: (j['textScale'] as num?)?.toDouble() ?? d.textScale,
      locale: j['locale'] as String?,
      sound: j['sound'] as bool? ?? d.sound,
      variant: j['variant'] as String? ?? d.variant,
    );
  }
}

final prefsProvider = Provider<SharedPreferences>(
    (_) => throw UnimplementedError('set in main()'));

class SettingsNotifier extends Notifier<AppSettings> {
  static const _key = 'settings.v1';

  @override
  AppSettings build() {
    final raw = ref.read(prefsProvider).getString(_key);
    if (raw == null) return const AppSettings();
    try {
      return AppSettings.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      return const AppSettings(); // damaged file: start fresh
    }
  }

  void change(AppSettings Function(AppSettings) f) {
    state = f(state);
    ref.read(prefsProvider).setString(_key, jsonEncode(state.toJson()));
  }
}

final settingsProvider =
    NotifierProvider<SettingsNotifier, AppSettings>(SettingsNotifier.new);
