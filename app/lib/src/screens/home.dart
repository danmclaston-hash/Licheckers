import 'package:flutter/material.dart';

import '../i18n.dart';
import '../install/install_banner.dart';
import '../layout.dart';
import '../tournament/tournaments_screen.dart';
import 'learn_screen.dart';
import 'play_home.dart';
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

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final items = [
      (Icons.sports_esports_outlined, Icons.sports_esports, l.navPlay),
      (Icons.emoji_events_outlined, Icons.emoji_events, l.navTournaments),
      (Icons.school_outlined, Icons.school, l.navLearn),
      (Icons.settings_outlined, Icons.settings, l.navSettings),
    ];
    final wide = MediaQuery.sizeOf(context).width >= kWideBreakpoint;
    final page = IndexedStack(index: _tab, children: const [
      PlayHome(),
      TournamentsScreen(),
      LearnScreen(),
      SettingsScreen(),
    ]);
    final scheme = Theme.of(context).colorScheme;
    if (wide) {
      return Scaffold(
        body: Column(children: [
          const InstallBanner(),
          Expanded(child: Row(children: [
          NavigationRail(
            backgroundColor: scheme.surfaceContainer,
            selectedIndex: _tab,
            onDestinationSelected: (i) => setState(() => _tab = i),
            labelType: NavigationRailLabelType.all,
            leading: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: const Image(
                    image: AssetImage('assets/icon-64.png'), width: 40, height: 40),
              ),
            ),
            destinations: [
              for (final (icon, sel, label) in items)
                NavigationRailDestination(
                    icon: Icon(icon), selectedIcon: Icon(sel), label: Text(label)),
            ],
          ),
          Expanded(child: page),
          ])),
        ]),
      );
    }
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          const InstallBanner(),
          Expanded(child: page),
        ]),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (i) => setState(() => _tab = i),
        destinations: [
          for (final (icon, sel, label) in items)
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
