import 'dart:math';

import 'package:checkers_core/checkers_core.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../i18n.dart';
import '../info_tip.dart';
import '../screens/home.dart';
import '../theme.dart';
import 'sponsor_logo.dart';
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

  bool _busy = false;

  /// Stores a checked logo and makes its main colour the sponsor colour.
  Future<void> _useLogo(bool first, Uint8List bytes) async {
    final colour = await logoColour(bytes); // also proves it is a picture
    setState(() {
      if (first) {
        d.logoA = bytes;
        d.logoColourA = colour;
        d.colourA = 'Logo';
      } else {
        d.logoB = bytes;
        d.logoColourB = colour;
        d.colourB = 'Logo';
      }
    });
  }

  Future<void> _run(Future<void> Function() job) async {
    setState(() => _busy = true);
    try {
      await job();
    } on LogoError catch (e) {
      _say(logoErrorText(context.l, e));
    } catch (e) {
      _say(context.l.somethingWrong('$e'));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _say(String m) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(m), duration: const Duration(seconds: 6)));
  }

  Future<void> _upload(bool first) => _run(() async {
        final f = await FilePicker.pickFile(type: FileType.image);
        if (f == null) return;
        final bytes = await f.xFile.readAsBytes();
        final err = logoFileProblem(f.name, bytes.length);
        if (err != null) throw LogoError(err);
        await _useLogo(first, bytes);
      });

  Future<void> _fromLink(bool first) async {
    final c = TextEditingController();
    final l = context.l;
    final link = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l.linkTitle),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(
            controller: c,
            autofocus: true,
            keyboardType: TextInputType.url,
            decoration: const InputDecoration(
                hintText: 'https://example.com/logo.png',
                border: OutlineInputBorder()),
          ),
          const SizedBox(height: 8),
          Text(l.linkHelp, style: const TextStyle(fontSize: 12)),
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text(l.cancel)),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, c.text), child: Text(l.add)),
        ],
      ),
    );
    c.dispose();
    if (link == null || link.trim().isEmpty) return;
    await _run(() async => _useLogo(first, await fetchLogo(link)));
  }

  void _removeLogo(bool first) => setState(() {
        if (first) {
          d.logoA = null;
          d.logoColourA = null;
          if (d.colourA == 'Logo') d.colourA = 'Blue';
        } else {
          d.logoB = null;
          d.logoColourB = null;
          if (d.colourB == 'Logo') d.colourB = 'Red';
        }
      });

  Widget _logoRow(ThemeData t, bool first) {
    final l = context.l;
    final logo = first ? d.logoA : d.logoB;
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 4),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: t.dividerColor),
            ),
            padding: const EdgeInsets.all(4),
            child: logo == null
                ? const Icon(Icons.image_outlined, color: Colors.black38)
                : Image.memory(logo, fit: BoxFit.contain),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Wrap(spacing: 8, runSpacing: 8, children: [
              OutlinedButton.icon(
                  onPressed: _busy ? null : () => _upload(first),
                  icon: const Icon(Icons.upload, size: 18),
                  label: Text(l.upload)),
              OutlinedButton.icon(
                  onPressed: _busy ? null : () => _fromLink(first),
                  icon: const Icon(Icons.link, size: 18),
                  label: Text(l.fromLink)),
              if (logo != null)
                TextButton(
                    onPressed: () => _removeLogo(first), child: Text(l.remove)),
            ]),
          ),
        ]),
        if (_busy) const LinearProgressIndicator(),
        if (logo != null)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
                l.logoAdded,
                style: t.textTheme.bodySmall),
          ),
      ]),
    );
  }

  Future<void> _create() async {
    final pay = d.totalToPay(isDeveloper: kDeveloperAccount);
    final l = context.l;
    final ok = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: Text(l.confirmTitle),
        content: Text(
          '${l.confirmPay(ugx(pay))}\n'
          '  ${l.confirmPool(ugx(d.poolUgx))}\n'
          '  ${l.confirmFee(kDeveloperAccount ? l.free : ugx(creationFeeUgx))}\n'
          '${d.sponsorFee > 0 ? '  ${l.confirmSponsor(ugx(d.sponsorFee))}\n' : ''}'
          '\n${l.confirmRules}\n\n${l.demoNoMoney}',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c, false), child: Text(l.back)),
          FilledButton(onPressed: () => Navigator.pop(c, true), child: Text(l.create)),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    final r = Random();
    final id = List.generate(5, (_) => chars[r.nextInt(chars.length)]).join();
    final t = Tournament(id, d, l.you, mine: true);
    ref.read(tournamentsProvider.notifier).add(t);
    Navigator.of(context).pushReplacement(MaterialPageRoute<void>(
        builder: (_) => TournamentDetailScreen(id: id, justCreated: true)));
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final l = context.l;
    final problems = [for (final p in d.problems()) problemText(l, p, d)];
    final pay = d.totalToPay(isDeveloper: kDeveloperAccount);
    final board = boardThemeById(d.boardId), piece = pieceStyleById(d.pieceId);
    final range = clockRanges[d.clock]!;
    final skin = d.sponsor == SponsorMode.none ? null : d.sponsorColourA;

    final form = ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      children: [
        // ---- 1. About
        SectionCard(title: l.secAbout, child: Column(children: [
          TextField(
            controller: _name,
            maxLength: 40,
            decoration: InputDecoration(
                labelText: l.tournamentName, border: const OutlineInputBorder()),
            onChanged: (_) => _sync(),
          ),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Wrap(spacing: 8, runSpacing: 8, children: [
              for (final v in Variants.all)
                ChoiceChip(
                  label: Text(variantName(l, v.id)),
                  selected: v.id == d.variantId,
                  onSelected: (_) => setState(() => d.variantId = v.id),
                ),
            ]),
          ),
        ])),

        // ---- 2. Format
        SectionCard(
          title: l.secFormat,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Wrap(spacing: 12, runSpacing: 4, children: [
              Row(mainAxisSize: MainAxisSize.min, children: [
              ChoiceChip(
                label: Text(l.arena),
                selected: d.format == TFormat.arena,
                onSelected: (_) => setState(() => d.format = TFormat.arena),
              ),
              InfoTip(title: l.arena, text: l.arenaInfo),
              ]),
              Row(mainAxisSize: MainAxisSize.min, children: [
              ChoiceChip(
                label: Text(l.swiss),
                selected: d.format == TFormat.swiss,
                onSelected: (_) => setState(() {
                  d.format = TFormat.swiss;
                  d.rounds = max(3, min(d.rounds, d.maxRounds));
                }),
              ),
              InfoTip(title: l.swiss, text: l.swissInfo),
              ]),
            ]),
            if (d.format == TFormat.swiss) ...[
              const SizedBox(height: 8),
              if (d.maxRounds < 3)
                Text(l.notEnoughRounds,
                    style: TextStyle(color: t.colorScheme.error))
              else ...[
                Text(l.roundsFit(min(d.rounds, d.maxRounds), d.maxRounds)),
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
          title: l.secClock,
          trailing: InfoTip(title: l.clockTitle, text: l.clockInfo),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Wrap(spacing: 8, children: [
              for (final c in ClockType.values)
                ChoiceChip(
                  label: Text(clockName(l, c)),
                  selected: d.clock == c,
                  onSelected: (_) => _setClock(c),
                ),
            ]),
            const SizedBox(height: 8),
            Text(l.minutesPerPlayer(d.baseMin)),
            Slider(
              min: range.minBase.toDouble(),
              max: range.maxBase.toDouble(),
              divisions: max(1, range.maxBase - range.minBase),
              value: d.baseMin.clamp(range.minBase, range.maxBase).toDouble(),
              onChanged: (v) => setState(() => d.baseMin = v.round()),
            ),
            Text(l.secondsAdded(d.incSec)),
            Slider(
              min: range.minInc.toDouble(),
              max: range.maxInc.toDouble(),
              divisions: max(1, range.maxInc - range.minInc),
              value: d.incSec.clamp(range.minInc, range.maxInc).toDouble(),
              onChanged: (v) => setState(() => d.incSec = v.round()),
            ),
            Text(l.longGame(clockText(l, d), gameMinutes(d.baseMin, d.incSec).round()),
                style: t.textTheme.bodySmall),
          ]),
        ),

        // ---- 4. When
        SectionCard(
          title: l.secWhen,
          trailing: InfoTip(title: l.whenTitle, text: l.whenInfo),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Wrap(spacing: 8, runSpacing: 8, children: [
              ActionChip(
                  label: Text(l.in1h),
                  onPressed: () => setState(() =>
                      d.start = DateTime.now().add(const Duration(hours: 1)))),
              ActionChip(
                  label: Text(l.in3h),
                  onPressed: () => setState(() =>
                      d.start = DateTime.now().add(const Duration(hours: 3)))),
              ActionChip(
                  label: Text(l.in8h),
                  onPressed: () => setState(() =>
                      d.start = DateTime.now().add(const Duration(hours: 8)))),
              ActionChip(
                  avatar: const Icon(Icons.edit_calendar, size: 16),
                  label: Text(l.pickDateTime),
                  onPressed: _pickStart),
            ]),
            const SizedBox(height: 8),
            Text(l.startsAt(dayTime(context, d.start)),
                style: const TextStyle(fontWeight: FontWeight.w600)),
            Text(l.lengthIs(duration(l, d.durationMin))),
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
            Text(l.endsAt(dayTime(context, d.end)),
                style: const TextStyle(fontWeight: FontWeight.w600)),
            if (d.format == TFormat.swiss)
              Text(l.roundsFitIn(d.maxRounds, duration(l, d.durationMin)),
                  style: t.textTheme.bodySmall),
          ]),
        ),

        // ---- 5. Players and money
        SectionCard(
          title: l.secMoney,
          trailing: InfoTip(title: l.moneyTitle, text: l.moneyInfo(platformCutPercent)),
          child: _money(t),
        ),

        // ---- 6. Board and pieces
        SectionCard(
          title: l.secBoard,
          trailing: InfoTip(title: l.whyOnlyThese, text: l.whyOnlyTheseInfo),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Wrap(spacing: 8, runSpacing: 8, children: [
              for (final b in boardThemes.where((b) => b.id.startsWith('clear-')))
                ChoiceChip(
                  label: Text(boardName(l, b.id)),
                  selected: d.boardId == b.id,
                  onSelected: (_) => setState(() => d.boardId = b.id),
                ),
            ]),
            const SizedBox(height: 8),
            Wrap(spacing: 8, children: [
              for (final p in pieceStyles.where((p) => p.id == 'flat' || p.id == 'classic'))
                ChoiceChip(
                  label: Text(l.piecesNamed(pieceName(l, p.id))),
                  selected: d.pieceId == p.id,
                  onSelected: (_) => setState(() => d.pieceId = p.id),
                ),
            ]),
            const SizedBox(height: 12),
            if (d.sponsor != SponsorMode.none) ...[
              d.sponsor == SponsorMode.half
                  ? Row(children: [
                      Expanded(child: SponsorStrip(d.sponsorA.isEmpty ? l.sponsor1 : d.sponsorA, d.sponsorColourA, logo: d.logoA)),
                      const SizedBox(width: 6),
                      Expanded(child: SponsorStrip(d.sponsorB.isEmpty ? l.sponsor2 : d.sponsorB, d.sponsorColourB, logo: d.logoB)),
                    ])
                  : SponsorStrip(d.sponsorA.isEmpty ? l.sponsor : l.presentedBy(d.sponsorA), d.sponsorColourA, logo: d.logoA),
              const SizedBox(height: 8),
            ],
            Center(child: BoardPreview(d, size: 250)),
            const SizedBox(height: 10),
            ChecksList(boardChecks(board, piece)),
          ]),
        ),

        // ---- 7. Sponsor
        SectionCard(
          title: l.secSponsor,
          trailing: InfoTip(
              title: l.sponsoredTitle,
              text: l.sponsoredInfo(ugx(themeFeeUgx), ugx(piecesAddOnUgx))),
          child: _sponsor(t),
        ),

        // ---- 8. Options
        SectionCard(
          title: l.secOptions,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l.allowVoice),
              subtitle: Text(l.allowVoiceSub),
              value: d.voiceAllowed,
              onChanged: (v) => setState(() => d.voiceAllowed = v),
            ),
            Row(children: [
              Flexible(child: Text(l.watchDelay)),
              InfoTip(title: l.watchDelayTitle, text: l.watchDelayInfo),
            ]),
            Wrap(spacing: 8, children: [
              for (final s in [0, 10, 20, 30])
                ChoiceChip(
                  label: Text(s == 0 ? l.none : l.seconds(s)),
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
              alignment: AlignmentDirectional.centerStart,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  problems.length == 1
                      ? problems.first
                      : l.moreProblems(problems.first, problems.length - 1),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: t.colorScheme.error, fontSize: 13),
                ),
              ),
            ),
          Row(children: [
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(l.youPayNow, style: t.textTheme.labelSmall),
                Text(ugx(pay),
                    style: t.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
              ]),
            ),
            const SizedBox(width: 12),
            // Long translations wrap onto two lines instead of spilling off.
            Flexible(
              flex: 2,
              child: FilledButton(
                style: FilledButton.styleFrom(minimumSize: const Size(0, 48)),
                onPressed: problems.isEmpty ? _create : null,
                child: Text(l.lockAndCreate,
                    textAlign: TextAlign.center, maxLines: 2),
              ),
            ),
          ]),
        ]),
      ),
    );

    final scaffold = Scaffold(
      appBar: AppBar(title: Text(l.createTitle)),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 720), child: form),
      ),
      bottomNavigationBar: bottom,
    );
    // Always wrap in a Theme (even without a sponsor), so choosing a sponsor
    // only changes colours and never rebuilds the page or loses the scroll.
    return Theme(data: skin == null ? t : skinTheme(t, skin), child: scaffold);
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
    final l = context.l;
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
        Expanded(child: _num2(_min, l.minPlayers)),
        const SizedBox(width: 12),
        Expanded(child: _num2(_max, l.maxPlayers)),
      ]),
      const SizedBox(height: 12),
      Row(children: [
        Expanded(child: _num2(_fee, l.entryFee, prefix: 'UGX ')),
        const SizedBox(width: 12),
        Expanded(child: _num2(_pool, l.prizePool, prefix: 'UGX ')),
      ]),
      const SizedBox(height: 12),
      Row(children: [
        Flexible(child: Text(l.winnerSplit, style: t.textTheme.labelLarge)),
        InfoTip(title: l.winnerSplit, text: l.winnerSplitInfo),
      ]),
      Wrap(spacing: 8, children: [
        for (final s in splitPresets.keys)
          ChoiceChip(
            label: Text(splitName(l, s)),
            selected: d.split == s,
            onSelected: (_) => setState(() => d.split = s),
          ),
      ]),
      const SizedBox(height: 6),
      Text(
          [for (var i = 0; i < prizes.length; i++) '${placeLabel(l, i + 1)} ${ugx(prizes[i])}']
              .join('  ·  '),
          style: t.textTheme.bodySmall),
      const Divider(height: 28),
      Row(children: [
        Expanded(
            child: Text(l.whatIf,
                style: t.textTheme.labelLarge)),
        InfoTip(title: l.whatIfTitle, text: l.whatIfInfo),
      ]),
      Slider(
        min: lo.toDouble(),
        max: hi.toDouble(),
        value: players,
        onChanged: (v) => setState(() => _whatIf = v),
      ),
      line(l.players, '${players.round()}', bold: true),
      line(l.feesCollected, ugx(m.collected)),
      line(l.poolYouLocked, '-${ugx(d.poolUgx)}'),
      line(l.platformShare(platformCutPercent), '-${ugx(m.platformCut)}'),
      const Divider(),
      line(l.youEndWith, ugx(m.hostResult),
          bold: true,
          colour: m.hostResult < 0 ? t.colorScheme.error : null),
      if (m.breakEvenPlayers != null)
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
              l.breakEven(m.breakEvenPlayers!),
              style: t.textTheme.bodySmall),
        ),
    ]);
  }

  Widget _sponsor(ThemeData t) {
    final l = context.l;
    Widget colours(String current, Color? logoColour, void Function(String) pick) =>
        Wrap(spacing: 6, crossAxisAlignment: WrapCrossAlignment.center, children: [
          if (logoColour != null)
            Tooltip(
              message: l.logoColour,
              child: GestureDetector(
                onTap: () => pick('Logo'),
                child: Container(
                  width: 28,
                  height: 28,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color: logoColour,
                    shape: BoxShape.circle,
                    border: Border.all(
                        width: current == 'Logo' ? 3 : 1,
                        color: current == 'Logo' ? t.colorScheme.onSurface : Colors.black26),
                  ),
                  child: const Icon(Icons.image, size: 14, color: Colors.white),
                ),
              ),
            ),
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
            label: Text(l.noSponsor),
            selected: d.sponsor == SponsorMode.none,
            onSelected: (_) => setState(() => d.sponsor = SponsorMode.none)),
        ChoiceChip(
            label: Text(l.oneSponsor),
            selected: d.sponsor == SponsorMode.single,
            onSelected: (_) => setState(() => d.sponsor = SponsorMode.single)),
        ChoiceChip(
            label: Text(l.twoSponsors),
            selected: half,
            onSelected: (_) => setState(() => d.sponsor = SponsorMode.half)),
      ]),
      if (d.sponsor != SponsorMode.none) ...[
        const SizedBox(height: 12),
        TextField(
          controller: _sa,
          maxLength: 20,
          decoration: InputDecoration(
              labelText: half ? l.sponsor1Name : l.sponsorName,
              border: const OutlineInputBorder()),
          onChanged: (_) => _sync(),
        ),
        _logoRow(t, true),
        colours(d.colourA, d.logoColourA, (c) => setState(() => d.colourA = c)),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(half ? l.nameOnWhite(ugx(piecesAddOnUgx)) : l.nameOnPieces(ugx(piecesAddOnUgx))),
          subtitle: Text(l.upToLetters(maxLabelLength)),
          value: d.piecesA,
          onChanged: (v) => setState(() => d.piecesA = v),
        ),
        if (half) ...[
          const SizedBox(height: 8),
          TextField(
            controller: _sb,
            maxLength: 20,
            decoration: InputDecoration(
                labelText: l.sponsor2Name, border: const OutlineInputBorder()),
            onChanged: (_) => _sync(),
          ),
          _logoRow(t, false),
          colours(d.colourB, d.logoColourB, (c) => setState(() => d.colourB = c)),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l.nameOnBlack(ugx(piecesAddOnUgx))),
            value: d.piecesB,
            onChanged: (v) => setState(() => d.piecesB = v),
          ),
        ],
        const SizedBox(height: 8),
        Text(l.sponsorTotal(ugx(d.sponsorFee)),
            style: const TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        Text(
            l.logoRules,
            style: t.textTheme.bodySmall),
      ],
    ]);
  }
}
