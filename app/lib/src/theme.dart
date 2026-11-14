import 'package:flutter/material.dart';

import 'fonts.dart';

// Green that passes text contrast (4.5:1) in each mode:
// darker in light mode, lighter (with dark text on it) in dark mode.
const _greenLight = Color(0xFF4F7A28);
const _greenDark = Color(0xFF8FBF5A);
const _amber = Color(0xFFD9A441); // results and money only

ThemeData appTheme(Brightness b) {
  final dark = b == Brightness.dark;
  final green = dark ? _greenDark : _greenLight;
  final scheme = ColorScheme.fromSeed(
    seedColor: green,
    brightness: b,
    surface: dark ? const Color(0xFF16191D) : const Color(0xFFF4F2EE),
  ).copyWith(
    primary: green,
    onPrimary: dark ? const Color(0xFF10210A) : Colors.white,
    secondary: _amber,
    surfaceContainer: dark ? const Color(0xFF1E2227) : Colors.white,
    surfaceContainerHigh: dark ? const Color(0xFF262B31) : const Color(0xFFECE9E3),
  );
  return ThemeData(
    useMaterial3: true,
    // Arabic letters come from this font once it is loaded (fonts.dart).
    fontFamilyFallback: const [arabicFont],
    colorScheme: scheme,
    scaffoldBackgroundColor: scheme.surface,
    appBarTheme: AppBarTheme(
      backgroundColor: scheme.surface,
      surfaceTintColor: Colors.transparent,
      centerTitle: false,
    ),
    cardTheme: CardThemeData(
      color: scheme.surfaceContainer,
      elevation: 0,
      margin: EdgeInsets.zero,
      // Light mode: a thin border instead of a shadow. Dark mode: tonal fill.
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: dark ? BorderSide.none : BorderSide(color: scheme.outlineVariant),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(0, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
  );
}

/// Colours of a board. Each square colour is a gentle gradient across the
/// whole board (top-left to bottom-right).
class BoardTheme {
  final String id, name;
  final Color lightA, lightB, darkA, darkB, frame;
  const BoardTheme(this.id, this.name, this.lightA, this.lightB, this.darkA,
      this.darkB, this.frame);
}

const boardThemes = [
  BoardTheme('walnut', 'Walnut', Color(0xFFF0D9B5), Color(0xFFE3C79C),
      Color(0xFFB58863), Color(0xFF8F6645), Color(0xFF4A3526)),
  BoardTheme('forest', 'Forest', Color(0xFFEEEED2), Color(0xFFDDE0BD),
      Color(0xFF86A666), Color(0xFF5F8245), Color(0xFF2F4226)),
  BoardTheme('ocean', 'Ocean', Color(0xFFDEE3E6), Color(0xFFC9D3DA),
      Color(0xFF8CA2AD), Color(0xFF5E7C8C), Color(0xFF2B3B45)),
  BoardTheme('midnight', 'Midnight', Color(0xFF9AA3B5), Color(0xFF848EA3),
      Color(0xFF3F4A63), Color(0xFF262F45), Color(0xFF141A28)),
  BoardTheme('sunset', 'Sunset', Color(0xFFFBE3C4), Color(0xFFF6CFA6),
      Color(0xFFD9825B), Color(0xFFA9506A), Color(0xFF4B2338)),
  // The four "Clear" boards are built to pass the tournament readability
  // checks with the Flat and Classic pieces (see tournament_rules.dart).
  BoardTheme('clear-green', 'Clear Green', Color(0xFFEEEED2), Color(0xFFE2E4C4),
      Color(0xFF688C50), Color(0xFF64874E), Color(0xFF2F4226)),
  BoardTheme('clear-brown', 'Clear Brown', Color(0xFFF2E3C6), Color(0xFFE8D3AC),
      Color(0xFFA27A51), Color(0xFF9D764E), Color(0xFF4A3526)),
  BoardTheme('clear-blue', 'Clear Blue', Color(0xFFE3ECF2), Color(0xFFD3E0EA),
      Color(0xFF63869E), Color(0xFF608298), Color(0xFF2B3B45)),
  BoardTheme('clear-red', 'Clear Red', Color(0xFFFBE8DD), Color(0xFFF3D3C2),
      Color(0xFFBF6B53), Color(0xFFB96751), Color(0xFF4B2338)),
  BoardTheme('contrast', 'High contrast', Color(0xFFFFFFFF), Color(0xFFFFFFFF),
      Color(0xFF3A3A3A), Color(0xFF3A3A3A), Color(0xFF000000)),
];

BoardTheme boardThemeById(String id) =>
    boardThemes.firstWhere((t) => t.id == id, orElse: () => boardThemes.first);

/// How the pieces are drawn. All are vector drawings (sharp at any size).
class PieceStyle {
  final String id, name;
  final Color whiteA, whiteB, blackA, blackB, crown;
  final bool glossy, flat;
  const PieceStyle(this.id, this.name, this.whiteA, this.whiteB, this.blackA,
      this.blackB, this.crown,
      {this.glossy = false, this.flat = false});
}

const pieceStyles = [
  PieceStyle('classic', 'Classic', Color(0xFFFDFBF5), Color(0xFFD8D0BC),
      Color(0xFF4A4A4A), Color(0xFF1C1C1C), Color(0xFFE2B33C)),
  PieceStyle('wood', 'Wood', Color(0xFFF3D9A6), Color(0xFFC99A55),
      Color(0xFF7A4526), Color(0xFF41200F), Color(0xFFFFD86B)),
  PieceStyle('glass', 'Glass', Color(0xFFEAF6FF), Color(0xFF9CC6E8),
      Color(0xFFE8656F), Color(0xFF96222F), Color(0xFFFFE08A), glossy: true),
  PieceStyle('ruby', 'Ivory & Ruby', Color(0xFFFFF8E7), Color(0xFFE5D3A8),
      Color(0xFFC7372F), Color(0xFF7B1612), Color(0xFFFFD257)),
  PieceStyle('flat', 'Flat', Color(0xFFF5F5F5), Color(0xFFF5F5F5),
      Color(0xFF2B2B2B), Color(0xFF2B2B2B), Color(0xFFE2B33C), flat: true),
];

PieceStyle pieceStyleById(String id) =>
    pieceStyles.firstWhere((t) => t.id == id, orElse: () => pieceStyles.first);
