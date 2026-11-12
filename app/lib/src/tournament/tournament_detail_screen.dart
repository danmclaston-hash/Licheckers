import 'package:checkers_core/checkers_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../info_tip.dart';
import '../screens/home.dart';
import 'tournament_rules.dart';
import 'tournament_store.dart';
import 'widgets.dart';

/// One tournament. If it is sponsored, the colours of the sponsor are used
/// on this screen only. Leave the screen and the app is normal again.
class TournamentDetailScreen extends ConsumerWidget {
  final String id;
  final bool justCreated;
  const TournamentDetailScreen({super.key, required this.id, this.justCreated = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final x = ref.watch(tournamentsProvider).firstWhere((t) => t.id == id);
    final d = x.d;
    final base = Theme.of(context);
    final sponsored = d.sponsor != SponsorMode.none;
    final skin = sponsored ? d.sponsorColourA : null;
    final theme = skin == null ? base : skinTheme(base, skin);
    return Theme(
      data: theme,
      child: Builder(builder: (context) => _Body(x: x, justCreated: justCreated)),
    );
  }
}

class _Body extends ConsumerWidget {
  final Tournament x;
  final bool justCreated;
  const _Body({required this.x, required this.justCreated});

  Future<void> _join(BuildContext context, WidgetRef ref) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: Text(x.d.feeUgx == 0 ? 'Join for free?' : 'Join for ${ugx(x.d.feeUgx)}?'),
        content: const Text(
            'If the tournament is cancelled before it starts, you get your entry fee back.\n\n'
            'Demo: no real money moves yet.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Back')),
          FilledButton(onPressed: () => Navigator.pop(c, true), child: const Text('Join')),
        ],
      ),
    );
    if (ok == true) ref.read(tournamentsProvider.notifier).join(x.id);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Theme.of(context);
    final d = x.d;
    final half = d.sponsor == SponsorMode.half;
    final sponsored = d.sponsor != SponsorMode.none;
    final prizes = prizeAmounts(d.poolUgx, d.percents);
    final m = moneySummary(players: x.joined, fee: d.feeUgx, pool: d.poolUgx);
    final cA = d.sponsorColourA, cB = d.sponsorColourB;

    return Scaffold(
      appBar: AppBar(title: Text(d.name, overflow: TextOverflow.ellipsis)),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: ListView(padding: const EdgeInsets.all(16), children: [
            if (justCreated)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Card(
                  color: Colors.green.withValues(alpha: .15),
                  child: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(children: [
                      Icon(Icons.check_circle, color: Colors.green),
                      SizedBox(width: 10),
                      Expanded(
                          child: Text('Tournament created. Share the link below so people can join.')),
                    ]),
                  ),
                ),
              ),
            // Sponsor strip: static, above the content, never over the board.
            if (sponsored)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: half
                    ? Row(children: [
                        Expanded(child: SponsorStrip('Presented by ${d.sponsorA}', cA, logo: d.logoA)),
                        const SizedBox(width: 6),
                        Expanded(child: SponsorStrip('Presented by ${d.sponsorB}', cB, logo: d.logoB)),
                      ])
                    : SponsorStrip('Presented by ${d.sponsorA}', cA, logo: d.logoA),
              ),

            if (x.mine && d.logosWaitingForCheck)
              const Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Tag('Logo waiting for safety check: only you can see it',
                    icon: Icons.hourglass_top, colour: Colors.orange),
              ),
            // Countdown + join
            SectionCard(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Wrap(spacing: 6, runSpacing: 6, children: [
                  Tag(clockText(d), icon: Icons.timer_outlined),
                  Tag(d.format == TFormat.arena ? 'Arena' : 'Swiss', icon: Icons.groups_outlined),
                  Tag(Variants.byId(d.variantId).name, icon: Icons.grid_on),
                ]),
                const SizedBox(height: 12),
                Countdown(
                  start: d.start,
                  end: d.end,
                  style: t.textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.w800, color: t.colorScheme.primary),
                ),
                Text('${dayTime(d.start)} to ${dayTime(d.end)}  (${hoursText(d.durationMin)})',
                    style: t.textTheme.bodySmall),
                const SizedBox(height: 12),
                if (x.iJoined)
                  const Tag("You're in", icon: Icons.check, colour: Colors.green)
                else
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () => _join(context, ref),
                      child: Text(d.feeUgx == 0 ? 'Join for free' : 'Join for ${ugx(d.feeUgx)}'),
                    ),
                  ),
              ]),
            ),

            // Share link
            SectionCard(
              title: 'Invite people',
              trailing: const InfoTip(
                title: 'Share link',
                text: 'Send this link on WhatsApp or anywhere. People who already have the app '
                    'open this tournament. New people are asked to sign up first, then join.\n\n'
                    'The link starts working when online play is live.',
              ),
              child: Row(children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: t.colorScheme.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(x.shareLink,
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filledTonal(
                  tooltip: 'Copy link',
                  icon: const Icon(Icons.copy),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: x.shareLink));
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text('Link copied')));
                  },
                ),
              ]),
            ),

            // Prizes
            SectionCard(
              title: 'Prizes',
              child: Column(children: [
                for (var i = 0; i < prizes.length; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Row(children: [
                      Expanded(child: Text(ordinal(i + 1))),
                      Text(ugx(prizes[i]), style: const TextStyle(fontWeight: FontWeight.w700)),
                    ]),
                  ),
                const Divider(),
                Row(children: [
                  const Expanded(child: Text('Entry fee')),
                  Text(d.feeUgx == 0 ? 'Free' : ugx(d.feeUgx)),
                ]),
                Row(children: [
                  const Expanded(child: Text('Players')),
                  Text('${x.joined} joined (min ${d.minPlayers}, max ${d.maxPlayers})'),
                ]),
              ]),
            ),

            // How it is played
            SectionCard(
              title: 'How it works',
              trailing: const InfoTip(
                title: 'Points and ties',
                text: 'Win 3 points, draw 1, loss 0. If players have the same points, '
                    'more wins ranks higher, then the head-to-head result, then the strength of '
                    'opponents, then fewer games, then who reached the score first. '
                    'So there is always only one first place.',
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(d.format == TFormat.arena
                    ? 'Arena: join any time. Play as many games as you can. Most points when the clock ends wins.'
                    : 'Swiss: ${d.rounds} rounds. Each round you meet someone with a similar score. Join before round 1.'),
                const SizedBox(height: 6),
                const Text('Win = 3 points · Draw = 1 · Loss = 0'),
                const SizedBox(height: 6),
                Text(d.voiceAllowed
                    ? 'Voice chat is allowed (opt-in for both players).'
                    : 'Voice chat is off in this tournament.'),
                Text(d.spectatorDelaySec == 0
                    ? 'Live watching: no delay.'
                    : 'Live watching is ${d.spectatorDelaySec} seconds late.'),
              ]),
            ),

            // The board players will see
            SectionCard(
              title: 'The board you will play on',
              trailing: const InfoTip(
                title: 'Same board for everyone',
                text: 'Everyone in this tournament sees this board and these pieces, '
                    'so the game is always clear. Your own board choice returns when you leave.',
              ),
              child: Center(child: BoardPreview(d, size: 260)),
            ),

            if (x.mine)
              SectionCard(
                title: 'Your money (host)',
                child: Column(children: [
                  _row('Entry fees so far', ugx(m.collected)),
                  _row('Prize pool locked', ugx(d.poolUgx)),
                  _row('Platform share ($platformCutPercent% of profit)', ugx(m.platformCut)),
                  _row('You would end with', ugx(m.hostResult)),
                ]),
              ),
          ]),
        ),
      ),
    );
  }

  Widget _row(String a, String b) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(children: [Expanded(child: Text(a)), Text(b)]),
      );
}
