import 'dart:math';

import 'package:checkers_core/checkers_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../info_tip.dart';
import '../screens/home.dart';
import '../theme.dart';
import 'tournament_detail_screen.dart';
import 'tournament_rules.dart';
import 'tournament_store.dart';
import 'widgets.dart';

/// The developer's own account creates tournaments without the creation fee.
const kDeveloperAccount = false;

const _defaults = {
  ClockType.bullet: (1, 0),
  ClockType.blitz: (3, 2),
  ClockType.rapid: (10, 5),
  ClockType.classic: (20, 10),
};

/// Create a tournament: one scrolling form, a live preview of the board, and
/// a bar at the bottom that always shows what you will pay.
class CreateTournamentScreen extends ConsumerStatefulWidget {
  const CreateTournamentScreen({super.key});

  @override
  ConsumerState<CreateTournamentScreen> createState() => _CreateState();
}

class _CreateState extends ConsumerState<CreateTournamentScreen> {
  final d = TournamentDraft();
  final _name = TextEditingController();
  final _min = TextEditingController(text: '8');
  final _max = TextEditingController(text: '200');
  final _fee = TextEditingController(text: '5000');
  final _pool = TextEditingController(text: '100000');
  final _sa = TextEditingController();
  final _sb = TextEditingController();
  double _whatIf = 30;

  @override
  void dispose() {
    for (final c in [_name, _min, _max, _fee, _pool, _sa, _sb]) {
      c.dispose();
    }
    super.dispose();
  }

  int _n(TextEditingController c) => int.tryParse(c.text.replaceAll(',', '').trim()) ?? 0;

  void _sync() => setState(() {
        d.name = _name.text;
        d.minPlayers = _n(_min);
        d.maxPlayers = _n(_max);
        d.feeUgx = _n(_fee);
        d.poolUgx = _n(_pool);
        d.sponsorA = _sa.text;
        d.sponsorB = _sb.text;
        if (d.format == TFormat.swiss) {
          final m = d.maxRounds;
          if (m >= 3 && d.rounds > m) d.rounds = m;
        }
      });

  void _setClock(ClockType c) => setState(() {
        d.clock = c;
        d.baseMin = _defaults[c]!.$1;
        d.incSec = _defaults[c]!.$2;
      });

  Future<void> _pickStart() async {
    final now = DateTime.now();
    final day = await showDatePicker(
        context: context,
        initialDate: d.start,
        firstDate: now,
        lastDate: now.add(const Duration(days: 60)));
    if (day == null || !mounted) return;
    final time = await showTimePicker(
        context: context, initialTime: TimeOfDay.fromDateTime(d.start));
    if (time == null) return;
    setState(() => d.start =
        DateTime(day.year, day.month, day.day, time.hour, time.minute));
  }

  Future<void> _create() async {
    final pay = d.totalToPay(isDeveloper: kDeveloperAccount);
    final ok = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text('Lock the prize pool and create?'),
        content: Text(
          'You pay ${ugx(pay)} now:\n'
          '  Prize pool (locked): ${ugx(d.poolUgx)}\n'
          '  Creation fee: ${kDeveloperAccount ? 'free' : ugx(creationFeeUgx)}\n'
          '${d.sponsorFee > 0 ? '  Sponsor look: ${ugx(d.sponsorFee)}\n' : ''}'
          '\nIf the tournament is cancelled before it starts, every player '
          'gets their entry fee back and your prize pool returns to you. '
          'Once it starts, the prize pool stays locked until the winners are paid.\n\n'
          'Demo: no real money moves yet.',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Back')),
          FilledButton(onPressed: () => Navigator.pop(c, true), child: const Text('Create')),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    final r = Random();
    final id = List.generate(5, (_) => chars[r.nextInt(chars.length)]).join();
    final t = Tournament(id, d, 'You', mine: true);
    ref.read(tournamentsProvider.notifier).add(t);
    Navigator.of(context).pushReplacement(MaterialPageRoute<void>(
        builder: (_) => TournamentDetailScreen(id: id, justCreated: true)));
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final problems = d.problems();
    final pay = d.totalToPay(isDeveloper: kDeveloperAccount);
    final board = boardThemeById(d.boardId), piece = pieceStyleById(d.pieceId);
    final range = clockRanges[d.clock]!;
    final skin = d.sponsor == SponsorMode.none ? null : colourOf(d.colourA);

    final form = ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      children: [
        // ---- 1. About
        SectionCard(title: '1. About', child: Column(children: [
          TextField(
            controller: _name,
            maxLength: 40,
            decoration: const InputDecoration(
                labelText: 'Tournament name', border: OutlineInputBorder()),
            onChanged: (_) => _sync(),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Wrap(spacing: 8, runSpacing: 8, children: [
              for (final v in Variants.all)
                ChoiceChip(
                  label: Text(v.name),
                  selected: v.id == d.variantId,
                  onSelected: (_) => setState(() => d.variantId = v.id),
                ),
            ]),
          ),
        ])),

        // ---- 2. Format
        SectionCard(
          title: '2. Format',
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              ChoiceChip(
                label: const Text('Arena'),
                selected: d.format == TFormat.arena,
                onSelected: (_) => setState(() => d.format = TFormat.arena),
              ),
              const InfoTip(
                title: 'Arena',
                text: 'Join any time before the end. Play as many games as you can. '
                    'A win is 3 points, a draw 1, a loss 0. Most points when the clock ends wins.\n\n'
                    'Best for big crowds, because people can arrive late.',
              ),
              const SizedBox(width: 12),
              ChoiceChip(
                label: const Text('Swiss'),
                selected: d.format == TFormat.swiss,
                onSelected: (_) => setState(() {
                  d.format = TFormat.swiss;
                  d.rounds = max(3, min(d.rounds, d.maxRounds));
                }),
              ),
              const InfoTip(
                title: 'Swiss',
                text: 'A fixed number of rounds. Each round you are matched with someone '
                    'who has a similar score. Everyone plays every round. Most points after the last round wins.\n\n'
                    'Best for smaller, serious events (up to about 200 players). '
                    'You can only join before round 1 starts.',
              ),
            ]),
            if (d.format == TFormat.swiss) ...[
              const SizedBox(height: 8),
              if (d.maxRounds < 3)
                Text('Not enough time for 3 rounds. Make the tournament longer or the clock faster.',
                    style: TextStyle(color: t.colorScheme.error))
              else ...[
                Text('Rounds: ${min(d.rounds, d.maxRounds)} (up to ${d.maxRounds} fit)'),
                Slider(
                  min: 3,
                  max: d.maxRounds.toDouble().clamp(4, 40),
                  divisions: max(1, d.maxRounds - 3),
                  value: d.rounds.clamp(3, d.maxRounds).toDouble(),
                  onChanged: (v) => setState(() => d.rounds = v.round()),
                ),
              ],
            ],
          ]),
        ),

        // ---- 3. Clock
        SectionCard(
          title: '3. Clock',
          trailing: const InfoTip(
            title: 'Clock',
            text: 'Every tournament game has a clock, so a slow player cannot stall the whole event. '
                'The second number is extra seconds added after every move.',
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Wrap(spacing: 8, children: [
              for (final c in ClockType.values)
                ChoiceChip(
                  label: Text(clockRanges[c]!.name),
                  selected: d.clock == c,
                  onSelected: (_) => _setClock(c),
                ),
            ]),
            const SizedBox(height: 8),
            Text('Minutes per player: ${d.baseMin}'),
            Slider(
              min: range.minBase.toDouble(),
              max: range.maxBase.toDouble(),
              divisions: max(1, range.maxBase - range.minBase),
              value: d.baseMin.clamp(range.minBase, range.maxBase).toDouble(),
              onChanged: (v) => setState(() => d.baseMin = v.round()),
            ),
            Text('Seconds added after each move: ${d.incSec}'),
            Slider(
              min: range.minInc.toDouble(),
              max: range.maxInc.toDouble(),
              divisions: max(1, range.maxInc - range.minInc),
              value: d.incSec.clamp(range.minInc, range.maxInc).toDouble(),
              onChanged: (v) => setState(() => d.incSec = v.round()),
            ),
            Text('${clockText(d)}. A long game lasts about '
                '${gameMinutes(d.baseMin, d.incSec).round()} minutes.',
                style: t.textTheme.bodySmall),
          ]),
        ),

        // ---- 4. When
        SectionCard(
          title: '4. When',
          trailing: const InfoTip(
            title: 'Start and length',
            text: 'Tournaments are short on purpose: 30 minutes to 4 hours. '
                'Players see a live countdown to the start, then to the end. '
                'No new games are paired in the last minutes; games already running may finish.',
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Wrap(spacing: 8, runSpacing: 8, children: [
              ActionChip(
                  label: const Text('In 1 hour'),
                  onPressed: () => setState(() =>
                      d.start = DateTime.now().add(const Duration(hours: 1)))),
              ActionChip(
                  label: const Text('In 3 hours'),
                  onPressed: () => setState(() =>
                      d.start = DateTime.now().add(const Duration(hours: 3)))),
              ActionChip(
                  label: const Text('In 8 hours'),
                  onPressed: () => setState(() =>
                      d.start = DateTime.now().add(const Duration(hours: 8)))),
              ActionChip(
                  avatar: const Icon(Icons.edit_calendar, size: 16),
                  label: const Text('Pick date and time'),
                  onPressed: _pickStart),
            ]),
            const SizedBox(height: 8),
            Text('Starts: ${dayTime(d.start)}',
                style: const TextStyle(fontWeight: FontWeight.w600)),
            Text('Length: ${hoursText(d.durationMin)}'),
            Slider(
              min: minDurationMin.toDouble(),
              max: maxDurationMin.toDouble(),
              divisions: (maxDurationMin - minDurationMin) ~/ 15,
              value: d.durationMin.toDouble(),
              onChanged: (v) => setState(() {
                d.durationMin = v.round();
                if (d.format == TFormat.swiss && d.maxRounds >= 3) {
                  d.rounds = min(d.rounds, d.maxRounds);
                }
              }),
            ),
            Text('Ends: ${dayTime(d.end)}',
                style: const TextStyle(fontWeight: FontWeight.w600)),
            if (d.format == TFormat.swiss)
              Text('About ${d.maxRounds} rounds fit in ${hoursText(d.durationMin)}.',
                  style: t.textTheme.bodySmall),
          ]),
        ),

        // ---- 5. Players and money
        SectionCard(
          title: '5. Players and money',
          trailing: const InfoTip(
            title: 'How the money works',
            text: 'You lock the whole prize pool when you create the tournament. '
                'Players pay the entry fee to join. Winners are paid from your locked prize pool. '
                'The entry fees are yours. The platform takes $platformCutPercent% of your profit only '
                '(entry fees minus prize pool). If the entries do not cover the pool, the platform takes nothing.\n\n'
                'If the tournament is cancelled before it starts, everyone is refunded. '
                'Once it starts, the money is locked.',
          ),
          child: _money(t),
        ),

        // ---- 6. Board and pieces
        SectionCard(
          title: '6. Board and pieces',
          trailing: const InfoTip(
            title: 'Why only these?',
            text: 'Everyone in the tournament plays on the same board, so players can always see '
                'the squares and pieces clearly. Only boards and pieces that pass our '
                'readability tests are offered. Sponsors can never change the board.',
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Wrap(spacing: 8, runSpacing: 8, children: [
              for (final b in boardThemes.where((b) => b.id.startsWith('clear-')))
                ChoiceChip(
                  label: Text(b.name),
                  selected: d.boardId == b.id,
                  onSelected: (_) => setState(() => d.boardId = b.id),
                ),
            ]),
            const SizedBox(height: 8),
            Wrap(spacing: 8, children: [
              for (final p in pieceStyles.where((p) => p.id == 'flat' || p.id == 'classic'))
                ChoiceChip(
                  label: Text('${p.name} pieces'),
                  selected: d.pieceId == p.id,
                  onSelected: (_) => setState(() => d.pieceId = p.id),
                ),
            ]),
            const SizedBox(height: 12),
            Center(child: BoardPreview(d, size: 250)),
            const SizedBox(height: 10),
            ChecksList(boardChecks(board, piece)),
          ]),
        ),

        // ---- 7. Sponsor
        SectionCard(
          title: '7. Sponsor (optional)',
          trailing: const InfoTip(
            title: 'Sponsored tournaments',
            text: 'A sponsor changes the look of the app for this tournament only: colours and a '
                'name strip, and optionally their name on the pieces. '
                'The board squares never change. There are never pop-ups, videos or sounds, '
                'and nothing ever covers the board or the clocks. '
                'When a player leaves the tournament, the app looks normal again.\n\n'
                'Price: ${'UGX 15,000'} per sponsor, plus UGX 3,000 per sponsor to put their name on the pieces. '
                'Artwork is checked first, so a sponsored tournament must start at least 6 hours from now.',
          ),
          child: _sponsor(t),
        ),

        // ---- 8. Options
        SectionCard(
          title: '8. Options',
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Allow voice chat in games'),
              subtitle: const Text('Players can still choose to talk or not'),
              value: d.voiceAllowed,
              onChanged: (v) => setState(() => d.voiceAllowed = v),
            ),
            Row(children: [
              const Text('Live watching delay'),
              const InfoTip(
                title: 'Watching delay',
                text: 'Other people can watch the top games live. In paid tournaments their view is a few '
                    'seconds late, so nobody can pass the best move to a player.',
              ),
            ]),
            Wrap(spacing: 8, children: [
              for (final s in [0, 10, 20, 30])
                ChoiceChip(
                  label: Text(s == 0 ? 'None' : '$s s'),
                  selected: d.spectatorDelaySec == s,
                  onSelected: (_) => setState(() => d.spectatorDelaySec = s),
                ),
            ]),
          ]),
        ),
      ],
    );

    final bottom = Container(
      decoration: BoxDecoration(
        color: t.colorScheme.surfaceContainer,
        border: Border(top: BorderSide(color: t.dividerColor)),
      ),
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: SafeArea(
        top: false,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          if (problems.isNotEmpty)
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  problems.length == 1
                      ? problems.first
                      : '${problems.first}  (+${problems.length - 1} more)',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: t.colorScheme.error, fontSize: 13),
                ),
              ),
            ),
          Row(children: [
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('You pay now', style: t.textTheme.labelSmall),
                Text(ugx(pay),
                    style: t.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
              ]),
            ),
            FilledButton(
              onPressed: problems.isEmpty ? _create : null,
              child: const Text('Lock prize pool and create'),
            ),
          ]),
        ]),
      ),
    );

    final scaffold = Scaffold(
      appBar: AppBar(title: const Text('Create tournament')),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 720), child: form),
      ),
      bottomNavigationBar: bottom,
    );
    return skin == null ? scaffold : Theme(data: skinTheme(t, skin), child: scaffold);
  }

  Widget _num2(TextEditingController c, String label, {String? prefix}) => TextField(
        controller: c,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
            labelText: label, prefixText: prefix, border: const OutlineInputBorder()),
        onChanged: (_) => _sync(),
      );

  Widget _money(ThemeData t) {
    final lo = d.minPlayers.clamp(1, 100000), hi = max(d.maxPlayers, lo + 1);
    final players = _whatIf.clamp(lo.toDouble(), hi.toDouble());
    final m = moneySummary(players: players.round(), fee: d.feeUgx, pool: d.poolUgx);
    final prizes = prizeAmounts(d.poolUgx, d.percents);
    Widget line(String a, String b, {bool bold = false, Color? colour}) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(children: [
            Expanded(child: Text(a)),
            Text(b, style: TextStyle(fontWeight: bold ? FontWeight.w800 : FontWeight.w500, color: colour)),
          ]),
        );
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Expanded(child: _num2(_min, 'Min players')),
        const SizedBox(width: 12),
        Expanded(child: _num2(_max, 'Max players')),
      ]),
      const SizedBox(height: 12),
      Row(children: [
        Expanded(child: _num2(_fee, 'Entry fee', prefix: 'UGX ')),
        const SizedBox(width: 12),
        Expanded(child: _num2(_pool, 'Prize pool', prefix: 'UGX ')),
      ]),
      const SizedBox(height: 12),
      Row(children: [
        Text('Winner split', style: t.textTheme.labelLarge),
        const InfoTip(
          title: 'Winner split',
          text: 'How the prize pool is shared between the top places. '
              'Rounding leftovers go to first place.',
        ),
      ]),
      Wrap(spacing: 8, children: [
        for (final s in splitPresets.keys)
          ChoiceChip(
            label: Text(s),
            selected: d.split == s,
            onSelected: (_) => setState(() => d.split = s),
          ),
      ]),
      const SizedBox(height: 6),
      Text(
          [for (var i = 0; i < prizes.length; i++) '${ordinal(i + 1)} ${ugx(prizes[i])}']
              .join('  ·  '),
          style: t.textTheme.bodySmall),
      const Divider(height: 28),
      Row(children: [
        Expanded(
            child: Text('What if this many players join?',
                style: t.textTheme.labelLarge)),
        const InfoTip(
          title: 'Your money, worked out',
          text: 'Move the slider to see what you would earn. The platform cut is taken from your profit only.',
        ),
      ]),
      Slider(
        min: lo.toDouble(),
        max: hi.toDouble(),
        value: players,
        onChanged: (v) => setState(() => _whatIf = v),
      ),
      line('Players', '${players.round()}', bold: true),
      line('Entry fees collected', ugx(m.collected)),
      line('Prize pool you locked', '-${ugx(d.poolUgx)}'),
      line('Platform share ($platformCutPercent% of profit)', '-${ugx(m.platformCut)}'),
      const Divider(),
      line('You end with', ugx(m.hostResult),
          bold: true,
          colour: m.hostResult < 0 ? t.colorScheme.error : null),
      if (m.breakEvenPlayers != null)
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
              'You break even at ${m.breakEvenPlayers} players. Below that you lose part of the pool.',
              style: t.textTheme.bodySmall),
        ),
    ]);
  }

  Widget _sponsor(ThemeData t) {
    Widget colours(String current, void Function(String) pick) => Wrap(spacing: 6, children: [
          for (final e in sponsorColours.entries)
            GestureDetector(
              onTap: () => pick(e.key),
              child: Container(
                width: 28,
                height: 28,
                margin: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  color: e.value,
                  shape: BoxShape.circle,
                  border: Border.all(
                      width: current == e.key ? 3 : 1,
                      color: current == e.key ? t.colorScheme.onSurface : Colors.black26),
                ),
              ),
            ),
        ]);
    final half = d.sponsor == SponsorMode.half;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Wrap(spacing: 8, children: [
        ChoiceChip(
            label: const Text('No sponsor'),
            selected: d.sponsor == SponsorMode.none,
            onSelected: (_) => setState(() => d.sponsor = SponsorMode.none)),
        ChoiceChip(
            label: const Text('One sponsor'),
            selected: d.sponsor == SponsorMode.single,
            onSelected: (_) => setState(() => d.sponsor = SponsorMode.single)),
        ChoiceChip(
            label: const Text('Two sponsors (half each)'),
            selected: half,
            onSelected: (_) => setState(() => d.sponsor = SponsorMode.half)),
      ]),
      if (d.sponsor != SponsorMode.none) ...[
        const SizedBox(height: 12),
        TextField(
          controller: _sa,
          maxLength: 20,
          decoration: InputDecoration(
              labelText: half ? 'Sponsor 1 name (white side)' : 'Sponsor name',
              border: const OutlineInputBorder()),
          onChanged: (_) => _sync(),
        ),
        colours(d.colourA, (c) => setState(() => d.colourA = c)),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text('Name on ${half ? 'white ' : ''}pieces (+${ugx(piecesAddOnUgx)})'),
          subtitle: Text('Up to $maxLabelLength letters, checked for readability'),
          value: d.piecesA,
          onChanged: (v) => setState(() => d.piecesA = v),
        ),
        if (half) ...[
          const SizedBox(height: 8),
          TextField(
            controller: _sb,
            maxLength: 20,
            decoration: const InputDecoration(
                labelText: 'Sponsor 2 name (black side)', border: OutlineInputBorder()),
            onChanged: (_) => _sync(),
          ),
          colours(d.colourB, (c) => setState(() => d.colourB = c)),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('Name on black pieces (+${ugx(piecesAddOnUgx)})'),
            value: d.piecesB,
            onChanged: (v) => setState(() => d.piecesB = v),
          ),
        ],
        const SizedBox(height: 8),
        Text('Sponsor total: ${ugx(d.sponsorFee)}',
            style: const TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        Text(
            'Upload of a logo image is coming with the server. For now the sponsor is a name and a colour. '
            'Every sponsor is checked by a person before the tournament goes live.',
            style: t.textTheme.bodySmall),
      ],
    ]);
  }
}
