import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../i18n.dart';
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
    final l = context.l;
    final all = ref.watch(tournamentsProvider);
    final list = [
      for (final x in all)
        if (_filter == null || x.d.clock == _filter) x
    ]..sort((a, b) => a.d.start.compareTo(b.d.start));
    return PageBody(title: l.navTournaments, children: [
      FilledButton.icon(
        icon: const Icon(Icons.add),
        label: Text(l.createTournament),
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
              l.demoNote,
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
                label: Text(l.all),
                selected: _filter == null,
                onSelected: (_) => setState(() => _filter = null)),
            for (final c in ClockType.values)
              ChoiceChip(
                  label: Text(clockName(l, c)),
                  selected: _filter == c,
                  onSelected: (_) => setState(() => _filter = c)),
          ]),
        ),
        InfoTip(title: l.clockTypesTitle, text: l.clockTypesText),
      ]),
      const SizedBox(height: 12),
      if (list.isEmpty)
        Padding(
          padding: const EdgeInsets.all(24),
          child: Center(child: Text(l.noTournamentsOfType)),
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
    final l = context.l;
    final d = x.d;
    final sponsored = d.sponsor != SponsorMode.none;
    final skin = sponsored ? d.sponsorColourA : null;
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
                        ? d.sponsorColourB
                        : skin,
                  ]),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  if (sponsored && d.logoA != null) ...[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(2),
                        child: Image.memory(d.logoA!, width: 32, height: 32, fit: BoxFit.contain),
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                  Expanded(
                    child: Text(d.name,
                        style: t.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700)),
                  ),
                  if (x.mine) Tag(l.yours, icon: Icons.star, colour: Colors.amber),
                  if (x.iJoined)
                    Tag(l.joinedTag, icon: Icons.check, colour: Colors.green),
                ]),
                const SizedBox(height: 2),
                Text(
                    sponsored
                        ? l.presentedBy([d.sponsorA, if (d.sponsor == SponsorMode.half) d.sponsorB].join(' & '))
                        : l.hostedBy(x.host),
                    style: t.textTheme.bodySmall
                        ?.copyWith(color: t.colorScheme.onSurfaceVariant)),
                const SizedBox(height: 10),
                Wrap(spacing: 6, runSpacing: 6, children: [
                  Tag(clockText(l, d), icon: Icons.timer_outlined),
                  Tag(formatName(l, d.format),
                      icon: Icons.groups_outlined),
                  Tag(variantName(l, d.variantId), icon: Icons.grid_on),
                  Tag(duration(l, d.durationMin), icon: Icons.hourglass_bottom),
                ]),
                const SizedBox(height: 12),
                Row(children: [
                  Expanded(child: _Fact(l.entry, d.feeUgx == 0 ? l.free : ugx(d.feeUgx))),
                  Expanded(child: _Fact(l.prizePool, ugx(d.poolUgx))),
                  Expanded(child: _Fact(l.players, '${x.joined}/${d.maxPlayers}')),
                ]),
                const SizedBox(height: 10),
                Row(children: [
                  Icon(Icons.schedule, size: 16, color: t.colorScheme.primary),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Countdown(
                      start: d.start,
                      end: d.end,
                      style: t.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w700, color: t.colorScheme.primary),
                    ),
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
