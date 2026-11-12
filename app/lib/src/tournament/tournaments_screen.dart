import 'package:checkers_core/checkers_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../info_tip.dart';
import '../screens/home.dart';
import 'create_tournament_screen.dart';
import 'tournament_detail_screen.dart';
import 'tournament_rules.dart';
import 'tournament_store.dart';
import 'widgets.dart';

/// All tournaments: pick one to join, or create your own.
class TournamentsScreen extends ConsumerStatefulWidget {
  const TournamentsScreen({super.key});

  @override
  ConsumerState<TournamentsScreen> createState() => _TournamentsState();
}

class _TournamentsState extends ConsumerState<TournamentsScreen> {
  ClockType? _filter;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final all = ref.watch(tournamentsProvider);
    final list = [
      for (final x in all)
        if (_filter == null || x.d.clock == _filter) x
    ]..sort((a, b) => a.d.start.compareTo(b.d.start));
    return PageBody(title: 'Tournaments', children: [
      FilledButton.icon(
        icon: const Icon(Icons.add),
        label: const Text('Create a tournament'),
        onPressed: () => Navigator.of(context).push(MaterialPageRoute<void>(
            builder: (_) => const CreateTournamentScreen())),
      ),
      const SizedBox(height: 12),
      Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: t.colorScheme.secondary.withValues(alpha: .14),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(children: [
          Icon(Icons.science_outlined, size: 18, color: t.colorScheme.secondary),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Demo: sample tournaments and no real money yet. '
              'Online play and payments come with the server.',
              style: t.textTheme.bodySmall,
            ),
          ),
        ]),
      ),
      const SizedBox(height: 12),
      Row(children: [
        Expanded(
          child: Wrap(spacing: 8, runSpacing: 4, children: [
            ChoiceChip(
                label: const Text('All'),
                selected: _filter == null,
                onSelected: (_) => setState(() => _filter = null)),
            for (final c in ClockType.values)
              ChoiceChip(
                  label: Text(clockRanges[c]!.name),
                  selected: _filter == c,
                  onSelected: (_) => setState(() => _filter = c)),
          ]),
        ),
        const InfoTip(
          title: 'Clock types',
          text: 'Bullet: 1 to 2 minutes each, very fast.\n'
              'Blitz: 3 to 5 minutes each.\n'
              'Rapid: 10 to 15 minutes each.\n'
              'Classic: 20 to 30 minutes each.\n\n'
              'A second number like 3+2 means 2 seconds are added after every move.',
        ),
      ]),
      const SizedBox(height: 12),
      if (list.isEmpty)
        const Padding(
          padding: EdgeInsets.all(24),
          child: Center(child: Text('No tournaments of this type yet.')),
        ),
      for (final x in list) _Card(x),
    ]);
  }
}

class _Card extends StatelessWidget {
  final Tournament x;
  const _Card(this.x);

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final d = x.d;
    final sponsored = d.sponsor != SponsorMode.none;
    final skin = sponsored ? colourOf(d.colourA) : null;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute<void>(
              builder: (_) => TournamentDetailScreen(id: x.id))),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            if (skin != null)
              Container(
                height: 6,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    skin,
                    d.sponsor == SponsorMode.half
                        ? (colourOf(d.colourB) ?? skin)
                        : skin,
                  ]),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Expanded(
                    child: Text(d.name,
                        style: t.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700)),
                  ),
                  if (x.mine) const Tag('Yours', icon: Icons.star, colour: Colors.amber),
                  if (x.iJoined)
                    const Tag('Joined', icon: Icons.check, colour: Colors.green),
                ]),
                const SizedBox(height: 2),
                Text(
                    sponsored
                        ? 'Presented by ${[d.sponsorA, if (d.sponsor == SponsorMode.half) d.sponsorB].join(' & ')}'
                        : 'Hosted by ${x.host}',
                    style: t.textTheme.bodySmall
                        ?.copyWith(color: t.colorScheme.onSurfaceVariant)),
                const SizedBox(height: 10),
                Wrap(spacing: 6, runSpacing: 6, children: [
                  Tag(clockText(d), icon: Icons.timer_outlined),
                  Tag(d.format == TFormat.arena ? 'Arena' : 'Swiss',
                      icon: Icons.groups_outlined),
                  Tag(Variants.byId(d.variantId).name, icon: Icons.grid_on),
                  Tag(hoursText(d.durationMin), icon: Icons.hourglass_bottom),
                ]),
                const SizedBox(height: 12),
                Row(children: [
                  Expanded(child: _Fact('Entry', d.feeUgx == 0 ? 'Free' : ugx(d.feeUgx))),
                  Expanded(child: _Fact('Prize pool', ugx(d.poolUgx))),
                  Expanded(child: _Fact('Players', '${x.joined}/${d.maxPlayers}')),
                ]),
                const SizedBox(height: 10),
                Row(children: [
                  Icon(Icons.schedule, size: 16, color: t.colorScheme.primary),
                  const SizedBox(width: 6),
                  Countdown(
                    start: d.start,
                    end: d.end,
                    style: t.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700, color: t.colorScheme.primary),
                  ),
                ]),
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}

class _Fact extends StatelessWidget {
  final String label, value;
  const _Fact(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label,
          style: t.textTheme.labelSmall
              ?.copyWith(color: t.colorScheme.onSurfaceVariant)),
      Text(value,
          style: t.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
    ]);
  }
}
