import 'dart:async';
import 'dart:math';

import 'package:checkers_core/checkers_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../board_view.dart';
import '../game_controller.dart';
import '../i18n.dart';
import '../layout.dart';
import '../settings.dart';
import '../sounds.dart';
import '../theme.dart';

/// The game. Focus mode: the two players (with clocks), the board, a strip
/// of moves, one status line and one row of buttons, all kept together
/// right around the board. Wide screens also get the full move list.
class GameScreen extends ConsumerWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = ref.watch(gameProvider);
    final s = ref.watch(settingsProvider);
    final l = context.l;
    final game = c.game, setup = c.setup;
    if (game == null || setup == null) {
      return Scaffold(body: Center(child: Text(l.noGame)));
    }
    c.animMs = s.animMs;
    c.onSound = s.sound ? Sounds.instance.play : null;
    final viewing = c.viewIndex != null;
    final vsBot = setup.bot != null;
    // Against the computer your side is at the bottom. With two players on
    // one device the board stays still.
    final bottom = vsBot ? setup.humanSide : white;
    final over = c.result != GameResult.ongoing;

    String name(int side) => vsBot
        ? (side == setup.humanSide ? l.you : setup.bot!.name)
        : (side == white ? l.white : l.black);

    Widget bar(int side) => _PlayerBar(
          name: name(side),
          side: side,
          style: pieceStyleById(s.pieceStyle),
          active: !over && game.position.turn == side,
          thinking: c.thinking && game.position.turn == side,
          taken: _startCount(setup.rules) -
              game.position.count(side == white ? bMan : wMan) -
              game.position.count(side == white ? bKing : wKing),
          clock: c.hasClock ? _ClockFace(controller: c, side: side) : null,
        );

    Widget board(double side) => SizedBox.square(
          dimension: side,
          child: BoardView(
            // While looking back at an old move the board shows that moment.
            position: c.shownPosition!,
            previous: viewing ? null : c.prevPosition,
            lastMove: viewing
                ? (c.viewIndex! > 0 ? game.moves[c.viewIndex! - 1] : null)
                : c.lastMove,
            moveSerial: c.moveSerial,
            flipped: bottom == black,
            theme: boardThemeById(s.boardTheme),
            style: pieceStyleById(s.pieceStyle),
            animMs: s.animMs,
            showCoords: s.showCoords,
            selected: c.selected,
            targets: s.showLegalMoves ? c.targets : const {},
            mustMove: s.showLegalMoves ? c.mustMove : const {},
            onTap: over || viewing ? null : c.tap,
          ),
        );

    return LayoutBuilder(builder: (context, box) {
      final wide = box.maxWidth >= kWideBreakpoint;
      return Scaffold(
        appBar: AppBar(
          title: Text(variantName(l, setup.rules.id)),

        ),
        body: SafeArea(
          child: LayoutBuilder(builder: (context, inner) {
            // Everything that sits around the board, in pixels.
            const bars = 2 * 56.0, strip = 44.0, status = 40.0;
            const actionRow = 64.0, gaps = 24.0;
            if (!wide) {
              final side = max(
                  200.0,
                  min(inner.maxWidth - 16,
                      inner.maxHeight - bars - strip - status - actionRow - gaps));
              // Sit a little above the middle, close under the title bar.
              return Align(
                alignment: const Alignment(0, -0.6),
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: side,
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      bar(1 - bottom),
                      const SizedBox(height: 6),
                      board(side),
                      const SizedBox(height: 6),
                      bar(bottom),
                      _MoveStrip(controller: c),
                      _StatusLine(controller: c, name: name),
                      _Actions(controller: c),
                    ]),
                  ),
                ),
              );
            }
            const panel = 320.0;
            final side = max(
                240.0,
                min(inner.maxWidth - panel - 64,
                    inner.maxHeight - bars - strip - status - gaps - 16));
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  SizedBox(
                    width: side,
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      bar(1 - bottom),
                      const SizedBox(height: 6),
                      board(side),
                      const SizedBox(height: 6),
                      bar(bottom),
                      _MoveStrip(controller: c),
                      _StatusLine(controller: c, name: name),
                    ]),
                  ),
                  const SizedBox(width: 24),
                  SizedBox(
                    width: panel,
                    height: side + bars + strip,
                    child: Card(
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 4),
                          child: Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(l.moves,
                                style: Theme.of(context).textTheme.titleSmall),
                          ),
                        ),
                        Expanded(child: _MoveList(controller: c)),
                        const Divider(height: 1),
                        _Actions(controller: c),
                      ]),
                    ),
                  ),
                ]),
              ),
            );
          }),
        ),
      );
    });
  }

  static int _startCount(VariantRules r) => Position.initial(r).count(wMan);
}

class _PlayerBar extends StatelessWidget {
  final String name;
  final int side, taken;
  final bool active, thinking;
  final PieceStyle style;
  final Widget? clock;
  const _PlayerBar({
    required this.name,
    required this.side,
    required this.taken,
    required this.active,
    required this.thinking,
    required this.style,
    this.clock,
  });

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final s = t.colorScheme;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 160),
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: active ? s.primaryContainer.withValues(alpha: .35) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        // A clear 2 px frame shows whose turn it is (not only a faint fill).
        border: Border.all(
            width: 2, color: active ? s.primary : Colors.transparent),
      ),
      child: Row(children: [
        Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: side == white ? style.whiteA : style.blackB,
            // A light ring keeps the black dot visible on dark backgrounds.
            border: Border.all(
                width: 2,
                color: side == white ? s.outline : const Color(0xFF8A8F98)),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(name,
              overflow: TextOverflow.ellipsis,
              style: t.textTheme.titleSmall
                  ?.copyWith(fontWeight: FontWeight.w600)),
        ),
        if (thinking)
          const Padding(
            padding: EdgeInsetsDirectional.only(end: 10),
            child: SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2)),
          ),
        if (taken > 0)
          Text('+$taken',
              style: t.textTheme.labelLarge?.copyWith(
                  color: s.onSurfaceVariant,
                  fontFeatures: const [FontFeature.tabularFigures()])),
        if (clock != null) ...[const SizedBox(width: 10), clock!],
      ]),
    );
  }
}

class _StatusLine extends StatelessWidget {
  final GameController controller;
  final String Function(int side) name;
  const _StatusLine({required this.controller, required this.name});

  @override
  Widget build(BuildContext context) {
    final c = controller, g = c.game!;
    final t = Theme.of(context);
    final l = context.l;
    final reason = reasonText(l, c.resultReason);
    final String text;
    switch (c.result) {
      case GameResult.ongoing:
        text = c.mustMove.isNotEmpty
            ? l.mustCapture
            : (c.thinking
                ? l.isThinking(name(g.position.turn))
                : l.toMove(name(g.position.turn)));
      case GameResult.draw:
        text = l.drawBecause(reason);
      case GameResult.whiteWins:
        text = l.wonBecause(name(white), reason);
      case GameResult.blackWins:
        text = l.wonBecause(name(black), reason);
    }
    final over = c.result != GameResult.ongoing;
    return SizedBox(
      height: 40,
      child: Center(
        child: Text(text,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: (over ? t.textTheme.titleMedium : t.textTheme.bodyMedium)
                ?.copyWith(
                    fontWeight: over ? FontWeight.w700 : FontWeight.w500,
                    color: over ? t.colorScheme.primary : t.colorScheme.onSurfaceVariant)),
      ),
    );
  }
}

class _Actions extends StatelessWidget {
  final GameController controller;
  const _Actions({required this.controller});

  @override
  Widget build(BuildContext context) {
    final c = controller;
    final l = context.l;
    final over = c.result != GameResult.ongoing;
    // Big, easy buttons (56 px tall) right under the board.
    const size = Size(0, 48);
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 4, 8),
      child: Row(children: [
        Expanded(
          // When the game is over this becomes "New game" (back to the grid).
          child: over
              ? FilledButton.tonalIcon(
                  style: FilledButton.styleFrom(minimumSize: size),
                  onPressed: () => Navigator.of(context).maybePop(),
                  icon: const Icon(Icons.grid_view),
                  label: Text(l.newGame, overflow: TextOverflow.ellipsis),
                )
              : FilledButton.tonalIcon(
                  style: FilledButton.styleFrom(minimumSize: size),
                  onPressed: c.canUndo ? c.undo : null,
                  icon: const Icon(Icons.undo),
                  label: Text(l.undo, overflow: TextOverflow.ellipsis),
                ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: over
              ? FilledButton.icon(
                  style: FilledButton.styleFrom(minimumSize: size),
                  onPressed: c.rematch,
                  icon: const Icon(Icons.replay),
                  label: Text(l.playAgain, overflow: TextOverflow.ellipsis),
                )
              : FilledButton.tonalIcon(
                  style: FilledButton.styleFrom(minimumSize: size),
                  onPressed: () async {
                    final yes = await showDialog<bool>(
                      context: context,
                      builder: (d) => AlertDialog(
                        title: Text(l.resignQ),
                        content: Text(l.resignBody),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(d, false),
                              child: Text(l.keepPlaying)),
                          FilledButton(
                              onPressed: () => Navigator.pop(d, true),
                              child: Text(l.resign)),
                        ],
                      ),
                    );
                    if (yes == true) c.resign();
                  },
                  icon: const Icon(Icons.flag_outlined),
                  label: Text(l.resign, overflow: TextOverflow.ellipsis),
                ),
        ),
      ]),
    );
  }
}

class _MoveList extends StatelessWidget {
  final GameController controller;
  const _MoveList({required this.controller});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final c = controller, game = c.game!;
    final moves = game.moves;
    if (moves.isEmpty) {
      return Center(
          child: Text(context.l.noMovesYet, style: t.textTheme.bodySmall));
    }
    final rows = (moves.length + 1) ~/ 2;
    const tab = TextStyle(fontFeatures: [FontFeature.tabularFigures()]);
    final shown = c.viewIndex ?? moves.length; // moves played in the shown position
    Widget cell(int i) => i >= moves.length
        ? const SizedBox.shrink()
        : InkWell(
            onTap: () => c.viewMove(i + 1),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              color: shown == i + 1 ? t.colorScheme.primaryContainer : null,
              child: Text(moveText(game.rules, moves[i]), style: tab),
            ),
          );
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: rows,
      itemBuilder: (_, i) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        // Move notation reads left to right in every language.
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Row(children: [
            SizedBox(
                width: 34,
                child: Text('${i + 1}.',
                    style: t.textTheme.bodySmall
                        ?.copyWith(color: t.colorScheme.onSurfaceVariant))),
            Expanded(child: Align(alignment: Alignment.centerLeft, child: cell(2 * i))),
            Expanded(child: Align(alignment: Alignment.centerLeft, child: cell(2 * i + 1))),
          ]),
        ),
      ),
    );
  }
}

/// One scrolling row of moves under the board, with back and forward
/// buttons to look at earlier positions (like lichess). Tap a move to see
/// the board at that moment; the "live" button returns to the game.
class _MoveStrip extends StatefulWidget {
  final GameController controller;
  const _MoveStrip({required this.controller});

  @override
  State<_MoveStrip> createState() => _MoveStripState();
}

class _MoveStripState extends State<_MoveStrip> {
  final _scroll = ScrollController();
  int _seen = -1;

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.controller, game = c.game!;
    final l = context.l;
    final t = Theme.of(context);
    final moves = game.moves;
    final shown = c.viewIndex ?? moves.length;
    // Follow the newest move while playing.
    if (moves.length != _seen) {
      _seen = moves.length;
      if (c.viewIndex == null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scroll.hasClients) {
            _scroll.animateTo(_scroll.position.maxScrollExtent,
                duration: const Duration(milliseconds: 160), curve: Curves.easeOut);
          }
        });
      }
    }
    const tab = TextStyle(fontFeatures: [FontFeature.tabularFigures()]);
    return SizedBox(
      height: 44,
      child: Directionality(
        textDirection: TextDirection.ltr, // notation reads left to right
        child: Row(children: [
          IconButton(
            tooltip: l.prevMove,
            icon: const Icon(Icons.chevron_left),
            onPressed: shown > 0 ? c.stepBack : null,
          ),
          Expanded(
            child: moves.isEmpty
                ? Center(child: Text(l.noMovesYet, style: t.textTheme.bodySmall))
                : ListView.builder(
                    controller: _scroll,
                    scrollDirection: Axis.horizontal,
                    itemCount: moves.length,
                    itemBuilder: (_, i) {
                      final on = shown == i + 1;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(6),
                          onTap: () => c.viewMove(i + 1),
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: on ? t.colorScheme.primaryContainer : null,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '${i.isEven ? '${i ~/ 2 + 1}. ' : ''}${moveText(game.rules, moves[i])}',
                              style: tab.copyWith(
                                  fontWeight: on ? FontWeight.w700 : FontWeight.w400),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          IconButton(
            tooltip: l.nextMove,
            icon: const Icon(Icons.chevron_right),
            onPressed: c.viewIndex != null ? c.stepForward : null,
          ),
          if (c.viewIndex != null)
            IconButton(
              tooltip: l.backToGame,
              icon: const Icon(Icons.last_page),
              onPressed: c.backToLive,
            ),
        ]),
      ),
    );
  }
}

/// A player's clock: big even-width digits. The running clock is filled;
/// under 10 seconds it turns red and shows tenths.
class _ClockFace extends StatefulWidget {
  final GameController controller;
  final int side;
  const _ClockFace({required this.controller, required this.side});

  @override
  State<_ClockFace> createState() => _ClockFaceState();
}

class _ClockFaceState extends State<_ClockFace> {
  Timer? _t;

  @override
  void initState() {
    super.initState();
    _t = Timer.periodic(const Duration(milliseconds: 100), (_) {
      final c = widget.controller;
      if (mounted && c.clockRunning && c.game?.position.turn == widget.side) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _t?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.controller;
    final s = Theme.of(context).colorScheme;
    final ms = c.timeLeft(widget.side);
    final running = c.clockRunning && c.game?.position.turn == widget.side;
    final low = ms < 10000;
    final String text;
    if (low) {
      text = '${ms ~/ 1000}.${(ms % 1000) ~/ 100}';
    } else {
      final total = (ms / 1000).ceil();
      text = '${total ~/ 60}:${(total % 60).toString().padLeft(2, '0')}';
    }
    final bg = running ? (low ? s.error : s.primary) : s.surfaceContainerHigh;
    final fg = running ? (low ? s.onError : s.onPrimary) : (low ? s.error : s.onSurface);
    return Container(
      constraints: const BoxConstraints(minWidth: 72),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
      child: Text(text,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
          style: TextStyle(
              color: fg,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              fontFeatures: const [FontFeature.tabularFigures()])),
    );
  }
}
