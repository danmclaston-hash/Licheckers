import 'package:checkers_core/checkers_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../board_view.dart';
import '../game_controller.dart';
import '../settings.dart';
import '../theme.dart';

/// The game. Focus mode: only the two players, the board and one slim row
/// of buttons. The move list opens only when you ask for it (phones) or
/// sits in a side panel (wide screens).
class GameScreen extends ConsumerWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = ref.watch(gameProvider);
    final s = ref.watch(settingsProvider);
    final game = c.game, setup = c.setup;
    if (game == null || setup == null) {
      return const Scaffold(body: Center(child: Text('No game')));
    }
    c.animMs = s.animMs;
    final vsBot = setup.bot != null;
    // Against the computer your side is at the bottom. With two players on
    // one device the board stays still.
    final bottom = vsBot ? setup.humanSide : white;
    final over = c.result != GameResult.ongoing;

    final board = BoardView(
      position: game.position,
      previous: c.prevPosition,
      lastMove: c.lastMove,
      moveSerial: c.moveSerial,
      flipped: bottom == black,
      theme: boardThemeById(s.boardTheme),
      style: pieceStyleById(s.pieceStyle),
      animMs: s.animMs,
      showCoords: s.showCoords,
      selected: c.selected,
      targets: s.showLegalMoves ? c.targets : const {},
      mustMove: s.showLegalMoves ? c.mustMove : const {},
      onTap: over ? null : c.tap,
    );

    String name(int side) => vsBot
        ? (side == setup.humanSide ? 'You' : setup.bot!.name)
        : (side == white ? 'White' : 'Black');

    Widget bar(int side) => _PlayerBar(
          name: name(side),
          side: side,
          style: pieceStyleById(s.pieceStyle),
          active: !over && game.position.turn == side,
          thinking: c.thinking && game.position.turn == side,
          taken: _startCount(setup.rules) -
              game.position.count(side == white ? bMan : wMan) -
              game.position.count(side == white ? bKing : wKing),
        );

    final status = _StatusLine(controller: c, name: name);
    final actions = _Actions(controller: c);

    return Scaffold(
      appBar: AppBar(
        title: Text(setup.rules.name),
        actions: [
          IconButton(
            tooltip: 'Moves',
            icon: const Icon(Icons.format_list_numbered),
            onPressed: () => showModalBottomSheet<void>(
              context: context,
              showDragHandle: true,
              builder: (_) => SizedBox(
                  height: 360, child: _MoveList(game: game)),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(builder: (context, box) {
          final wide = box.maxWidth >= 900;
          // Players sit right above and below the board, like at a table.
          final column = Column(children: [
            Expanded(
              child: Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  bar(1 - bottom),
                  const SizedBox(height: 6),
                  Flexible(child: board),
                  const SizedBox(height: 6),
                  bar(bottom),
                ]),
              ),
            ),
            status,
            if (!wide) actions,
          ]);
          if (!wide) {
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: column);
          }
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Row(children: [
              Expanded(child: column),
              const SizedBox(width: 16),
              SizedBox(
                width: 300,
                child: Card(
                  child: Column(children: [
                    Expanded(child: _MoveList(game: game)),
                    const Divider(height: 1),
                    actions,
                  ]),
                ),
              ),
            ]),
          );
        }),
      ),
    );
  }

  static int _startCount(VariantRules r) => Position.initial(r).count(wMan);
}

class _PlayerBar extends StatelessWidget {
  final String name;
  final int side, taken;
  final bool active, thinking;
  final PieceStyle style;
  const _PlayerBar({
    required this.name,
    required this.side,
    required this.taken,
    required this.active,
    required this.thinking,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: active ? t.colorScheme.surfaceContainerHigh : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(children: [
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: side == white ? style.whiteA : style.blackB,
            border: Border.all(color: t.colorScheme.outline),
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
            padding: EdgeInsets.only(right: 10),
            child: SizedBox(
                width: 14,
                height: 14,
                child: CircularProgressIndicator(strokeWidth: 2)),
          ),
        if (taken > 0)
          Text('+$taken',
              style: t.textTheme.labelLarge
                  ?.copyWith(color: t.colorScheme.onSurfaceVariant)),
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
    final String text;
    switch (c.result) {
      case GameResult.ongoing:
        text = c.mustMove.isNotEmpty
            ? 'You must capture'
            : (c.thinking ? '${name(g.position.turn)} is thinking…' : '${name(g.position.turn)} to move');
      case GameResult.draw:
        text = 'Draw · ${c.resultReason}';
      case GameResult.whiteWins:
        text = '${name(white)} won · ${c.resultReason}';
      case GameResult.blackWins:
        text = '${name(black)} won · ${c.resultReason}';
    }
    final over = c.result != GameResult.ongoing;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(text,
          textAlign: TextAlign.center,
          style: (over ? t.textTheme.titleMedium : t.textTheme.bodyMedium)
              ?.copyWith(
                  fontWeight: over ? FontWeight.w700 : FontWeight.w400,
                  color: over
                      ? t.colorScheme.secondary
                      : t.colorScheme.onSurfaceVariant)),
    );
  }
}

class _Actions extends StatelessWidget {
  final GameController controller;
  const _Actions({required this.controller});

  @override
  Widget build(BuildContext context) {
    final c = controller;
    final over = c.result != GameResult.ongoing;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        TextButton.icon(
          onPressed: c.canUndo && !over ? c.undo : null,
          icon: const Icon(Icons.undo),
          label: const Text('Undo'),
        ),
        if (over)
          FilledButton.icon(
            onPressed: c.rematch,
            icon: const Icon(Icons.replay),
            label: const Text('Play again'),
          )
        else
          TextButton.icon(
            onPressed: () async {
              final yes = await showDialog<bool>(
                context: context,
                builder: (d) => AlertDialog(
                  title: const Text('Resign this game?'),
                  content: const Text('Your opponent wins.'),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(d, false),
                        child: const Text('Keep playing')),
                    FilledButton(
                        onPressed: () => Navigator.pop(d, true),
                        child: const Text('Resign')),
                  ],
                ),
              );
              if (yes == true) c.resign();
            },
            icon: const Icon(Icons.flag_outlined),
            label: const Text('Resign'),
          ),
      ]),
    );
  }
}

class _MoveList extends StatelessWidget {
  final Game game;
  const _MoveList({required this.game});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final moves = game.moves;
    if (moves.isEmpty) {
      return Center(
          child: Text('No moves yet', style: t.textTheme.bodySmall));
    }
    final rows = (moves.length + 1) ~/ 2;
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: rows,
      itemBuilder: (_, i) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(children: [
          SizedBox(
              width: 34,
              child: Text('${i + 1}.',
                  style: t.textTheme.bodySmall
                      ?.copyWith(color: t.colorScheme.onSurfaceVariant))),
          Expanded(child: Text(moveText(game.rules, moves[2 * i]))),
          Expanded(
              child: Text(2 * i + 1 < moves.length
                  ? moveText(game.rules, moves[2 * i + 1])
                  : '')),
        ]),
      ),
    );
  }
}
