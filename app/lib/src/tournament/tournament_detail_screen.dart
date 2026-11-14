import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../i18n.dart';
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
    final l = context.l;
    final ok = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: Text(x.d.feeUgx == 0 ? l.joinForFreeQ : l.joinForQ(ugx(x.d.feeUgx))),
        content: Text('${l.refundNote}\n\n${l.demoNoMoney}'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c, false), child: Text(l.back)),
          FilledButton(onPressed: () => Navigator.pop(c, true), child: Text(l.join)),
        ],
      ),
    );
    if (ok == true) ref.read(tournamentsProvider.notifier).join(x.id);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Theme.of(context);
    final l = context.l;
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
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(children: [
                      const Icon(Icons.check_circle, color: Colors.green),
                      const SizedBox(width: 10),
                      Expanded(child: Text(l.created)),
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
                        Expanded(child: SponsorStrip(l.presentedBy(d.sponsorA), cA, logo: d.logoA)),
                        const SizedBox(width: 6),
                        Expanded(child: SponsorStrip(l.presentedBy(d.sponsorB), cB, logo: d.logoB)),
                      ])
                    : SponsorStrip(l.presentedBy(d.sponsorA), cA, logo: d.logoA),
              ),

            if (x.mine && d.logosWaitingForCheck)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Tag(l.logoPending,
                    icon: Icons.hourglass_top, colour: Colors.orange),
              ),
            // Countdown + join
            SectionCard(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Wrap(spacing: 6, runSpacing: 6, children: [
                  Tag(clockText(l, d), icon: Icons.timer_outlined),
                  Tag(formatName(l, d.format), icon: Icons.groups_outlined),
                  Tag(variantName(l, d.variantId), icon: Icons.grid_on),
                ]),
                const SizedBox(height: 12),
                Countdown(
                  start: d.start,
                  end: d.end,
                  style: t.textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.w800, color: t.colorScheme.primary),
                ),
                Text(l.fromTo(dayTime(context, d.start), dayTime(context, d.end), duration(l, d.durationMin)),
                    style: t.textTheme.bodySmall),
                const SizedBox(height: 12),
                if (x.iJoined)
                  Tag(l.youreIn, icon: Icons.check, colour: Colors.green)
                else
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () => _join(context, ref),
                      child: Text(d.feeUgx == 0 ? l.joinForFree : l.joinFor(ugx(d.feeUgx))),
                    ),
                  ),
              ]),
            ),

            // Share link
            SectionCard(
              title: l.invitePeople,
              trailing: InfoTip(title: l.shareLinkTitle, text: l.shareLinkInfo),
              child: Row(children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: t.colorScheme.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(8)),
                    // A web address always reads left to right.
                    child: Text(x.shareLink,
                        textDirection: TextDirection.ltr,
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filledTonal(
                  tooltip: l.copyLink,
                  icon: const Icon(Icons.copy),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: x.shareLink));
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(l.linkCopied)));
                  },
                ),
              ]),
            ),

            // Prizes
            SectionCard(
              title: l.prizes,
              child: Column(children: [
                for (var i = 0; i < prizes.length; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Row(children: [
                      Expanded(child: Text(placeLabel(l, i + 1))),
                      Text(ugx(prizes[i]), style: const TextStyle(fontWeight: FontWeight.w700)),
                    ]),
                  ),
                const Divider(),
                Row(children: [
                  Expanded(child: Text(l.entryFee)),
                  Text(d.feeUgx == 0 ? l.free : ugx(d.feeUgx)),
                ]),
                Row(children: [
                  Expanded(child: Text(l.players)),
                  Flexible(child: Text(l.joinedCount(x.joined, d.minPlayers, d.maxPlayers), textAlign: TextAlign.end)),
                ]),
              ]),
            ),

            // How it is played
            SectionCard(
              title: l.howItWorks,
              trailing: InfoTip(title: l.pointsTitle, text: l.pointsInfo),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(d.format == TFormat.arena ? l.arenaShort : l.swissShort(d.rounds)),
                const SizedBox(height: 6),
                Text(l.pointsLine),
                const SizedBox(height: 6),
                Text(d.voiceAllowed ? l.voiceOn : l.voiceOff),
                Text(d.spectatorDelaySec == 0
                    ? l.watchNoDelay
                    : l.watchDelayed(d.spectatorDelaySec)),
              ]),
            ),

            // The board players will see
            SectionCard(
              title: l.boardYouPlay,
              trailing: InfoTip(title: l.sameBoardTitle, text: l.sameBoardInfo),
              child: Center(child: BoardPreview(d, size: 260)),
            ),

            if (x.mine)
              SectionCard(
                title: l.yourMoney,
                child: Column(children: [
                  _row(l.feesSoFar, ugx(m.collected)),
                  _row(l.poolLocked, ugx(d.poolUgx)),
                  _row(l.platformShare(platformCutPercent), ugx(m.platformCut)),
                  _row(l.youWouldEnd, ugx(m.hostResult)),
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
