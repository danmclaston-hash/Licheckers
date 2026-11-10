import 'package:checkers_core/checkers_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../board_view.dart';
import '../info_tip.dart';
import '../settings.dart';
import '../theme.dart';
import 'home.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(settingsProvider);
    final set = ref.read(settingsProvider.notifier).change;
    final preview = Position.fromRows(Variants.english, const [
      '........', '..b.b...', '.....B..', '........',
      '...w....', '..W.....', '.w.w....', '........',
    ], white);

    return PageBody(title: 'Settings', children: [
      SectionCard(
        title: 'Display',
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SegmentedButton<ThemeMode>(
            segments: const [
              ButtonSegment(value: ThemeMode.system, label: Text('System')),
              ButtonSegment(value: ThemeMode.light, label: Text('Light')),
              ButtonSegment(value: ThemeMode.dark, label: Text('Dark')),
            ],
            selected: {s.themeMode},
            onSelectionChanged: (v) =>
                set((x) => x.copyWith(themeMode: v.first)),
          ),
          const SizedBox(height: 16),
          Row(children: [
            Text('Text size', style: Theme.of(context).textTheme.bodyMedium),
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
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Show info buttons'),
            subtitle: const Text('The small (i) buttons that explain things'),
            value: s.showInfo,
            onChanged: (v) => set((x) => x.copyWith(showInfo: v)),
          ),
        ]),
      ),
      SectionCard(
        title: 'Board and pieces',
        trailing: const InfoTip(
          title: 'Your look only',
          text: 'These choices change only your screen. In an online game '
              'your opponent keeps their own board and pieces.',
        ),
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
          Text('Board', style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 6),
          Wrap(spacing: 8, runSpacing: 8, children: [
            for (final t in boardThemes)
              ChoiceChip(
                avatar: _Swatch(t.lightA, t.darkB),
                label: Text(t.name),
                selected: s.boardTheme == t.id,
                onSelected: (_) => set((x) => x.copyWith(boardTheme: t.id)),
              ),
          ]),
          const SizedBox(height: 14),
          Text('Pieces', style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 6),
          Wrap(spacing: 8, runSpacing: 8, children: [
            for (final p in pieceStyles)
              ChoiceChip(
                avatar: _Swatch(p.whiteA, p.blackA),
                label: Text(p.name),
                selected: s.pieceStyle == p.id,
                onSelected: (_) => set((x) => x.copyWith(pieceStyle: p.id)),
              ),
          ]),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Square numbers'),
            value: s.showCoords,
            onChanged: (v) => set((x) => x.copyWith(showCoords: v)),
          ),
        ]),
      ),
      SectionCard(
        title: 'Game',
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Show legal moves'),
            subtitle: const Text('Dots where a piece can go, and a ring on pieces that must capture'),
            value: s.showLegalMoves,
            onChanged: (v) => set((x) => x.copyWith(showLegalMoves: v)),
          ),
          const SizedBox(height: 8),
          Text('Piece animation', style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 8),
          SegmentedButton<int>(
            segments: const [
              ButtonSegment(value: 0, label: Text('Off')),
              ButtonSegment(value: 120, label: Text('Fast')),
              ButtonSegment(value: 220, label: Text('Normal')),
              ButtonSegment(value: 380, label: Text('Slow')),
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
