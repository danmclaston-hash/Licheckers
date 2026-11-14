import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../i18n.dart';
import '../settings.dart';
import 'install_prompt.dart';

/// A polite "Install Licheckers" card at the top of the main tabs.
///
/// Rules, so it never feels like spam:
/// - only on the website, and only if the app is not installed yet;
/// - never during a game (it lives on the home tabs, not the game screen);
/// - not on someone's first moments: from the 2nd visit, or after 45 s;
/// - "Not now" hides it for 14 days; installing hides it for good;
/// - it never covers anything: it pushes the page down, no pop-up.
class InstallBanner extends ConsumerStatefulWidget {
  const InstallBanner({super.key});

  @override
  ConsumerState<InstallBanner> createState() => _InstallBannerState();
}

const _visitsKey = 'install.visits';
const _snoozeKey = 'install.snoozeUntil';
const snoozeDays = 14;
const firstVisitDelay = Duration(seconds: 45);
bool _countedThisRun = false;

/// The whole "is it polite to ask now?" decision, in one testable place.
bool shouldOfferInstall({
  required bool installed,
  required bool browserOffers, // install event received, or iPhone Safari
  required int visits,
  required Duration sinceOpened,
  required DateTime now,
  required int snoozeUntilMs,
}) {
  if (installed || !browserOffers) return false;
  if (now.millisecondsSinceEpoch < snoozeUntilMs) return false; // "Not now"
  return visits >= 2 || sinceOpened >= firstVisitDelay;
}

class _InstallBannerState extends ConsumerState<InstallBanner> {
  final _opened = DateTime.now();
  Timer? _timer;
  bool _show = false;

  @override
  void initState() {
    super.initState();
    if (!installSupported) return;
    final prefs = ref.read(prefsProvider);
    if (!_countedThisRun) {
      _countedThisRun = true;
      prefs.setInt(_visitsKey, (prefs.getInt(_visitsKey) ?? 0) + 1);
    }
    // The browser's install offer can arrive a few seconds after start,
    // so check again every few seconds until we know.
    _check();
    _timer = Timer.periodic(const Duration(seconds: 5), (_) => _check());
  }

  void _check() {
    if (!mounted) return;
    final prefs = ref.read(prefsProvider);
    final now = DateTime.now();
    final snoozeUntil = prefs.getInt(_snoozeKey) ?? 0;
    final snoozed = now.millisecondsSinceEpoch < snoozeUntil;
    final show = shouldOfferInstall(
      installed: isInstalled(),
      browserOffers: canPromptInstall() || isIosSafari(),
      visits: prefs.getInt(_visitsKey) ?? 1,
      sinceOpened: now.difference(_opened),
      now: now,
      snoozeUntilMs: snoozeUntil,
    );
    if (show != _show) setState(() => _show = show);
    if (snoozed || isInstalled()) _timer?.cancel();
  }

  void _notNow() {
    ref.read(prefsProvider).setInt(
        _snoozeKey,
        DateTime.now().add(const Duration(days: snoozeDays)).millisecondsSinceEpoch);
    setState(() => _show = false);
    _timer?.cancel();
  }

  Future<void> _install() async {
    final yes = await promptInstall();
    if (!mounted) return;
    if (yes) {
      setState(() => _show = false);
      _timer?.cancel();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(context.l.installDone)));
    } else {
      _notNow();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final t = Theme.of(context);
    final ios = isIosSafari() && !canPromptInstall();
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      child: !_show
          ? const SizedBox(width: double.infinity)
          : Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
              child: Card(
                color: t.colorScheme.primaryContainer,
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(14, 12, 8, 8),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: const Image(
                            image: AssetImage('assets/icon-64.png'), width: 40, height: 40),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(ios ? l.installIosTitle : l.installTitle,
                              style: t.textTheme.titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w700)),
                          const SizedBox(height: 2),
                          Text(ios ? l.installIosBody : l.installBody,
                              style: t.textTheme.bodySmall),
                        ]),
                      ),
                    ]),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Wrap(spacing: 8, children: [
                        TextButton(onPressed: _notNow, child: Text(ios ? l.gotIt : l.notNow)),
                        if (!ios)
                          FilledButton(onPressed: _install, child: Text(l.installNow)),
                      ]),
                    ),
                  ]),
                ),
              ),
            ),
    );
  }
}

/// The same offer, on demand, from Settings (for people who said "Not now").
class InstallTile extends StatelessWidget {
  const InstallTile({super.key});

  @override
  Widget build(BuildContext context) {
    if (!installSupported || isInstalled()) return const SizedBox.shrink();
    final l = context.l;
    final ios = isIosSafari() && !canPromptInstall();
    if (!ios && !canPromptInstall()) return const SizedBox.shrink();
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.install_mobile),
      title: Text(l.installApp),
      subtitle: Text(l.installAppSub),
      onTap: () async {
        if (ios) {
          await showDialog<void>(
            context: context,
            builder: (c) => AlertDialog(
              title: Text(l.installIosTitle),
              content: Text(l.installIosBody),
              actions: [
                TextButton(onPressed: () => Navigator.pop(c), child: Text(l.gotIt)),
              ],
            ),
          );
        } else if (await promptInstall() && context.mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(l.installDone)));
        }
      },
    );
  }
}
