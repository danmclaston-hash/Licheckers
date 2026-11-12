import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'tournament_rules.dart';

class Tournament {
  final String id;
  final TournamentDraft d;
  final String host;
  final bool mine;
  final int joined;
  final bool iJoined;
  const Tournament(this.id, this.d, this.host,
      {this.mine = false, this.joined = 0, this.iJoined = false});

  Tournament copyWith({int? joined, bool? iJoined}) => Tournament(id, d, host,
      mine: mine, joined: joined ?? this.joined, iJoined: iJoined ?? this.iJoined);

  /// Demo link. It becomes a real invite link when the server exists.
  String get shareLink => 'https://licheckers.app/t/$id';
}

/// Tournaments on this device. Demo data until the online server exists.
class TournamentStore extends Notifier<List<Tournament>> {
  @override
  List<Tournament> build() {
    final now = DateTime.now();
    TournamentDraft base(String name, int startInMin) => TournamentDraft(now: now)
      ..name = name
      ..start = now.add(Duration(minutes: startInMin));

    final sponsored = base('Example Telecom Rapid Cup', 400)
      ..variantId = 'international'
      ..format = TFormat.swiss
      ..clock = ClockType.rapid
      ..baseMin = 10
      ..incSec = 5
      ..durationMin = 180
      ..rounds = 6
      ..feeUgx = 10000
      ..poolUgx = 300000
      ..sponsor = SponsorMode.single
      ..sponsorA = 'Example'
      ..colourA = 'Amber'
      ..piecesA = true
      ..boardId = 'clear-brown';
    final half = base('City Derby: Alpha vs Beta', 540)
      ..variantId = 'russian'
      ..clock = ClockType.blitz
      ..baseMin = 5
      ..incSec = 3
      ..durationMin = 120
      ..feeUgx = 5000
      ..poolUgx = 150000
      ..sponsor = SponsorMode.half
      ..sponsorA = 'ALPHA'
      ..sponsorB = 'BETA'
      ..colourA = 'Blue'
      ..colourB = 'Red'
      ..piecesA = true
      ..piecesB = true
      ..boardId = 'clear-green';
    return [
      Tournament('KB7Q2', base('Friday Night Blitz', 95), 'Kato Chess Club',
          joined: 23),
      Tournament('RP4X9', sponsored, 'Example Telecom', joined: 61),
      Tournament('DR2M5', half, 'Kampala Draughts League', joined: 40),
      Tournament(
          'BU8L1',
          base('Bullet Blast', 25)
            ..clock = ClockType.bullet
            ..baseMin = 1
            ..incSec = 0
            ..durationMin = 60
            ..feeUgx = 2000
            ..poolUgx = 50000,
          'Nakato',
          joined: 12),
    ];
  }

  void add(Tournament t) => state = [t, ...state];

  void join(String id) => state = [
        for (final t in state)
          if (t.id == id && !t.iJoined)
            t.copyWith(joined: t.joined + 1, iJoined: true)
          else
            t
      ];
}

final tournamentsProvider =
    NotifierProvider<TournamentStore, List<Tournament>>(TournamentStore.new);
