import 'dart:math';

import 'package:checkers_core/checkers_core.dart';
import 'package:checkers_engine/checkers_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../game_controller.dart';
import '../i18n.dart';
import '../settings.dart';
import '../tournament/tournament_detail_screen.dart';
import '../tournament/tournament_store.dart';
import '../tournament/widgets.dart';
import 'game_screen.dart';
import 'home.dart';
import 'play_setup.dart';

/// The Play tab, lichess style: pick the game once (it is remembered),
/// then one tap on a tile starts playing. Everything else is in "Custom".
class PlayHome extends ConsumerWidget {
  const PlayHome({super.key});

  // Bot levels behind the quick tiles.
  static const easy = 3, medium = 8, hard = 13;

  static VariantRules variantOf(String id) =>
      Variants.all.firstWhere((v) => v.id == id, orElse: () => Variants.english);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l;
    final s = ref.watch(settingsProvider);
    final rules = variantOf(s.variant);

    void go(BotProfile? bot, {TimeControl? clock}) {
      final side = Random().nextBool() ? white : black; // fair: random colour
      ref.read(gameProvider).start(GameSetup(rules, bot, side, clock: clock));
      Navigator.of(context)
          .push(MaterialPageRoute<void>(builder: (_) => const GameScreen()));
    }

    final tiles = <Widget>[
      _Tile(l.quickEasy, bots[easy - 1].name, () => go(bots[easy - 1])),
      _Tile(l.quickMedium, bots[medium - 1].name, () => go(bots[medium - 1])),
      _Tile(l.quickHard, bots[hard - 1].name, () => go(bots[hard - 1])),
      _Tile('1+0', l.clock_bullet,
          () => go(bots[medium - 1], clock: const TimeControl(1, 0))),
      _Tile('3+2', l.clock_blitz,
          () => go(bots[medium - 1], clock: const TimeControl(3, 2))),
      _Tile('10+5', l.clock_rapid,
          () => go(bots[medium - 1], clock: const TimeControl(10, 5))),
      _Tile(l.twoPlayers, l.twoPlayersSub, () => go(null)),
      _Tile('5+3', l.twoPlayers, () => go(null, clock: const TimeControl(5, 3))),
      _Tile(l.customTile, l.customSub, () {
        Navigator.of(context).push(
            MaterialPageRoute<void>(builder: (_) => const PlaySetupScreen()));
      }, icon: Icons.tune),
    ];

    final grid = GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: MediaQuery.sizeOf(context).width >= 1000 ? 1.7 : 1.25,
      children: tiles,
    );

    return LayoutBuilder(builder: (context, box) {
      final wide = box.maxWidth >= 1000;
      final main = <Widget>[
        _VariantPill(rules),
        const SizedBox(height: 14),
        grid,
      ];
      if (!wide) {
        return PageBody(title: l.navPlay, children: [
          ...main,
          const SizedBox(height: 18),
          const NextTournamentCard(),
        ]);
      }
      // Desktop: the grid in the middle, the next tournament beside it.
      return Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1040),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
            children: [
              Text(l.navPlay,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 16),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(child: Column(children: main)),
                const SizedBox(width: 24),
                const SizedBox(width: 320, child: NextTournamentCard()),
              ]),
            ],
          ),
        ),
      );
    });
  }
}

/// One quick-start tile: a big label (level or clock) and a small line.
class _Tile extends StatelessWidget {
  final String label, sub;
  final VoidCallback onTap;
  final IconData? icon;
  const _Tile(this.label, this.sub, this.onTap, {this.icon});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final s = t.colorScheme;
    return Material(
      color: s.surfaceContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: s.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            if (icon != null) Icon(icon, size: 22, color: s.primary),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(label,
                  maxLines: 1,
                  style: t.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontFeatures: const [FontFeature.tabularFigures()])),
            ),
            const SizedBox(height: 2),
            Text(sub,
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: t.textTheme.bodySmall?.copyWith(color: s.onSurfaceVariant)),
          ]),
        ),
      ),
    );
  }
}

/// Shows the chosen variant; tap to pick another (remembered next time).
class _VariantPill extends ConsumerWidget {
  final VariantRules rules;
  const _VariantPill(this.rules);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l;
    final t = Theme.of(context);
    return Material(
      color: t.colorScheme.surfaceContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: t.colorScheme.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => showModalBottomSheet<void>(
          context: context,
          showDragHandle: true,
          isScrollControlled: true,
          builder: (sheet) => SafeArea(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.sizeOf(context).height * .8),
              child: ListView(shrinkWrap: true, children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
                  child: Text(l.chooseVariant, style: t.textTheme.titleMedium),
                ),
                for (final v in Variants.all)
                  ListTile(
                    title: Text(variantName(l, v.id),
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text(tagline(l, v)),
                    trailing: v.id == rules.id
                        ? Icon(Icons.check, color: t.colorScheme.primary)
                        : null,
                    onTap: () {
                      ref
                          .read(settingsProvider.notifier)
                          .change((x) => x.copyWith(variant: v.id));
                      Navigator.pop(sheet);
                    },
                  ),
              ]),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Row(children: [
            Icon(Icons.grid_on, color: t.colorScheme.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(variantName(l, rules.id),
                    style: t.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700)),
                Text(tagline(l, rules),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: t.textTheme.bodySmall
                        ?.copyWith(color: t.colorScheme.onSurfaceVariant)),
              ]),
            ),
            const Icon(Icons.expand_more),
          ]),
        ),
      ),
    );
  }
}

/// The soonest tournament that has not finished, with its live countdown.
class NextTournamentCard extends ConsumerWidget {
  const NextTournamentCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l;
    final t = Theme.of(context);
    final now = DateTime.now();
    final open = [
      for (final x in ref.watch(tournamentsProvider))
        if (x.d.end.isAfter(now)) x
    ]..sort((a, b) => a.d.start.compareTo(b.d.start));
    if (open.isEmpty) return const SizedBox.shrink();
    final x = open.first;
    return SectionCard(
      title: l.nextTournament,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => Navigator.of(context).push(MaterialPageRoute<void>(
            builder: (_) => TournamentDetailScreen(id: x.id))),
        child: Row(children: [
          Icon(Icons.emoji_events_outlined, color: t.colorScheme.secondary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(x.d.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              Text(clockText(l, x.d), style: t.textTheme.bodySmall),
              Countdown(
                start: x.d.start,
                end: x.d.end,
                style: t.textTheme.bodySmall?.copyWith(
                    color: t.colorScheme.primary, fontWeight: FontWeight.w700),
              ),
            ]),
          ),
          const Icon(Icons.chevron_right),
        ]),
      ),
    );
  }
}
