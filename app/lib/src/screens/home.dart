import 'package:flutter/material.dart';

import '../tournament/tournaments_screen.dart';
import 'learn_screen.dart';
import 'play_setup.dart';
import 'settings_screen.dart';

/// The shell: a slim rail on wide screens, a bottom bar on phones.
/// Only finished sections are shown, so nothing here is a dead end.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tab = 0;

  static const _items = [
    (Icons.sports_esports_outlined, Icons.sports_esports, 'Play'),
    (Icons.emoji_events_outlined, Icons.emoji_events, 'Tournaments'),
    (Icons.school_outlined, Icons.school, 'Learn'),
    (Icons.settings_outlined, Icons.settings, 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 800;
    final page = IndexedStack(index: _tab, children: const [
      PlaySetupScreen(),
      TournamentsScreen(),
      LearnScreen(),
      SettingsScreen(),
    ]);
    final scheme = Theme.of(context).colorScheme;
    if (wide) {
      return Scaffold(
        body: Row(children: [
          NavigationRail(
            backgroundColor: scheme.surfaceContainer,
            selectedIndex: _tab,
            onDestinationSelected: (i) => setState(() => _tab = i),
            labelType: NavigationRailLabelType.all,
            leading: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Icon(Icons.blur_circular, color: scheme.primary, size: 32),
            ),
            destinations: [
              for (final (icon, sel, label) in _items)
                NavigationRailDestination(
                    icon: Icon(icon), selectedIcon: Icon(sel), label: Text(label)),
            ],
          ),
          Expanded(child: page),
        ]),
      );
    }
    return Scaffold(
      body: SafeArea(child: page),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (i) => setState(() => _tab = i),
        destinations: [
          for (final (icon, sel, label) in _items)
            NavigationDestination(
                icon: Icon(icon), selectedIcon: Icon(sel), label: label),
        ],
      ),
    );
  }
}

/// Page title + centred, width-limited content.
class PageBody extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const PageBody({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
            children: [
              Text(title,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 16),
              ...children,
            ],
          ),
        ),
      );
}

class SectionCard extends StatelessWidget {
  final String? title;
  final Widget? trailing;
  final Widget child;
  const SectionCard({super.key, this.title, this.trailing, required this.child});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null)
                  Row(children: [
                    Expanded(
                      child: Text(title!,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600)),
                    ),
                    ?trailing,
                  ]),
                if (title != null) const SizedBox(height: 10),
                child,
              ],
            ),
          ),
        ),
      );
}
