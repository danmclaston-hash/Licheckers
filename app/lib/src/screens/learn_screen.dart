import 'package:checkers_core/checkers_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../board_view.dart';
import '../i18n.dart';
import '../settings.dart';
import '../theme.dart';
import 'home.dart';

/// The rules of every variant, in plain words. Works offline.
class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      PageBody(title: context.l.navLearn, children: const [VariantList()]);
}

/// The 9 variants; tap one to read its rules. Used in Learn and in Settings.
class VariantList extends StatelessWidget {
  const VariantList({super.key});

  @override
  Widget build(BuildContext context) => Column(children: [
        for (final v in Variants.all)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                title: Text(variantName(context.l, v.id),
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text(tagline(context.l, v)),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.of(context).push(MaterialPageRoute<void>(
                    builder: (_) => VariantRulesScreen(rules: v))),
              ),
            ),
          ),
      ]);
}

class VariantRulesScreen extends ConsumerWidget {
  final VariantRules rules;
  const VariantRulesScreen({super.key, required this.rules});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(settingsProvider);
    final t = Theme.of(context);
    final l = context.l;
    return Scaffold(
      appBar: AppBar(title: Text(variantName(l, rules.id))),
      body: PageBody(title: l.howToPlay, children: [
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 340),
            child: BoardView(
              position: Position.initial(rules),
              theme: boardThemeById(s.boardTheme),
              style: pieceStyleById(s.pieceStyle),
              showCoords: s.showCoords,
            ),
          ),
        ),
        const SizedBox(height: 20),
        for (final (i, line) in describeRules(l, rules).indexed)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                width: 28,
                child: Text('${i + 1}.',
                    style: t.textTheme.bodyMedium?.copyWith(
                        color: t.colorScheme.primary,
                        fontWeight: FontWeight.w700)),
              ),
              Expanded(child: Text(line)),
            ]),
          ),
      ]),
    );
  }
}
