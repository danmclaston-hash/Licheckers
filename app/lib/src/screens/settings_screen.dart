import 'package:checkers_core/checkers_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../board_view.dart';
import '../i18n.dart';
import '../install/install_banner.dart';
import '../info_tip.dart';
import '../settings.dart';
import '../theme.dart';
import 'home.dart';
import 'learn_screen.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(settingsProvider);
    final set = ref.read(settingsProvider.notifier).change;
    final l = context.l;
    final current = Localizations.localeOf(context).languageCode;
    final preview = Position.fromRows(Variants.english, const [
      '........', '..b.b...', '.....B..', '........',
      '...w....', '..W.....', '.w.w....', '........',
    ], white);

    return PageBody(title: l.navSettings, children: [
      // Language first: someone who cannot read the current language must
      // still find it. The globe icon and the names in their own language help.
      SectionCard(
        title: l.language,
        trailing: const Icon(Icons.language),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Wrap(spacing: 8, runSpacing: 8, children: [
            ChoiceChip(
              label: Text(l.languagePhone),
              selected: s.locale == null,
              onSelected: (_) => set((x) => x.copyWith(locale: () => null)),
            ),
            for (final (code, name) in appLanguages)
              ChoiceChip(
                label: Text(name),
                selected: s.locale == code,
                onSelected: (_) => set((x) => x.copyWith(locale: () => code)),
              ),
          ]),
          if (current != 'en')
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(l.translationNote,
                  style: Theme.of(context).textTheme.bodySmall),
            ),
        ]),
      ),
      SectionCard(
        title: l.rulesOfVariants,
        trailing: InfoTip(title: l.rulesOfVariants, text: l.rulesOfVariantsSub),
        child: const VariantList(),
      ),
      SectionCard(
        title: l.display,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SegmentedButton<ThemeMode>(
            showSelectedIcon: false,
            segments: [
              ButtonSegment(value: ThemeMode.system, label: Text(l.themeSystem)),
              ButtonSegment(value: ThemeMode.light, label: Text(l.themeLight)),
              ButtonSegment(value: ThemeMode.dark, label: Text(l.themeDark)),
            ],
            selected: {s.themeMode},
            onSelectionChanged: (v) =>
                set((x) => x.copyWith(themeMode: v.first)),
          ),
          const SizedBox(height: 16),
          Row(children: [
            Text(l.textSize, style: Theme.of(context).textTheme.bodyMedium),
            Expanded(
              child: Slider(
                value: s.textScale,
                min: 0.85,
                max: 1.4,
                divisions: 11,
                label: '${(s.textScale * 100).round()}%',
                onChanged: (v) => set((x) => x.copyWith(textScale: v)),
              ),
            ),
          ]),
          const InstallTile(),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l.showInfo),
            subtitle: Text(l.showInfoSub),
            value: s.showInfo,
            onChanged: (v) => set((x) => x.copyWith(showInfo: v)),
          ),
        ]),
      ),
      SectionCard(
        title: l.boardAndPieces,
        trailing: InfoTip(title: l.yourLookTitle, text: l.yourLookText),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 260),
              child: BoardView(
                position: preview,
                theme: boardThemeById(s.boardTheme),
                style: pieceStyleById(s.pieceStyle),
                showCoords: s.showCoords,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(l.board, style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 6),
          Wrap(spacing: 8, runSpacing: 8, children: [
            for (final t in boardThemes)
              ChoiceChip(
                avatar: _Swatch(t.lightA, t.darkB),
                label: Text(boardName(l, t.id)),
                selected: s.boardTheme == t.id,
                onSelected: (_) => set((x) => x.copyWith(boardTheme: t.id)),
              ),
          ]),
          const SizedBox(height: 14),
          Text(l.pieces, style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 6),
          Wrap(spacing: 8, runSpacing: 8, children: [
            for (final p in pieceStyles)
              ChoiceChip(
                avatar: _Swatch(p.whiteA, p.blackA),
                label: Text(pieceName(l, p.id)),
                selected: s.pieceStyle == p.id,
                onSelected: (_) => set((x) => x.copyWith(pieceStyle: p.id)),
              ),
          ]),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l.squareNumbers),
            value: s.showCoords,
            onChanged: (v) => set((x) => x.copyWith(showCoords: v)),
          ),
        ]),
      ),
      SectionCard(
        title: l.sectionGame,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l.sounds),
            subtitle: Text(l.soundsSub),
            value: s.sound,
            onChanged: (v) => set((x) => x.copyWith(sound: v)),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l.showLegal),
            subtitle: Text(l.showLegalSub),
            value: s.showLegalMoves,
            onChanged: (v) => set((x) => x.copyWith(showLegalMoves: v)),
          ),
          const SizedBox(height: 8),
          Text(l.pieceAnimation, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 8),
          SegmentedButton<int>(
            showSelectedIcon: false,
            segments: [
              ButtonSegment(value: 0, label: Text(l.animOff)),
              ButtonSegment(value: 120, label: Text(l.animFast)),
              ButtonSegment(value: 220, label: Text(l.animNormal)),
              ButtonSegment(value: 380, label: Text(l.animSlow)),
            ],
            selected: {s.animMs},
            onSelectionChanged: (v) => set((x) => x.copyWith(animMs: v.first)),
          ),
        ]),
      ),
    ]);
  }
}

class _Swatch extends StatelessWidget {
  final Color a, b;
  const _Swatch(this.a, this.b);

  @override
  Widget build(BuildContext context) => Container(
        width: 18,
        height: 18,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(colors: [a, a, b, b], stops: const [0, .5, .5, 1]),
          border: Border.all(color: Theme.of(context).colorScheme.outline),
        ),
      );
}
