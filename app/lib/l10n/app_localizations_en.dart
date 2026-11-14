// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class LEn extends L {
  LEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Licheckers';

  @override
  String get navPlay => 'Play';

  @override
  String get navTournaments => 'Tournaments';

  @override
  String get navLearn => 'Learn';

  @override
  String get navSettings => 'Settings';

  @override
  String get infoTooltip => 'What is this?';

  @override
  String get gotIt => 'Got it';

  @override
  String get cancel => 'Cancel';

  @override
  String get back => 'Back';

  @override
  String get create => 'Create';

  @override
  String get add => 'Add';

  @override
  String get remove => 'Remove';

  @override
  String get join => 'Join';

  @override
  String get white => 'White';

  @override
  String get black => 'Black';

  @override
  String get you => 'You';

  @override
  String get free => 'Free';

  @override
  String get none => 'None';

  @override
  String get all => 'All';

  @override
  String get variant_english => 'English (American)';

  @override
  String get variant_international => 'International';

  @override
  String get variant_brazilian => 'Brazilian';

  @override
  String get variant_russian => 'Russian';

  @override
  String get variant_italian => 'Italian';

  @override
  String get variant_spanish => 'Spanish';

  @override
  String get variant_turkish => 'Turkish (Dama)';

  @override
  String get variant_frisian => 'Frisian';

  @override
  String get variant_canadian => 'Canadian';

  @override
  String get tagFlyingKings => 'flying kings';

  @override
  String get tagShortKings => 'short kings';

  @override
  String get tagStraightMoves => 'straight moves';

  @override
  String get tagCaptures8 => 'captures in 8 directions';

  @override
  String get tagMenNoKings => 'men cannot take kings';

  @override
  String get tagFreeChoice => 'free choice of capture';

  @override
  String get tagMenForward => 'men capture forward only';

  @override
  String get tagMustTakeMost => 'must take the most pieces';

  @override
  String get howToPlay => 'How to play';

  @override
  String ruleBoardDiag(int size, int count) {
    return 'Board: ${size}x$size. Each player starts with $count men on the dark squares.';
  }

  @override
  String ruleBoardAll(int size, int count) {
    return 'Board: ${size}x$size. Each player starts with $count men, using every square.';
  }

  @override
  String get ruleWhiteFirst => 'White moves first.';

  @override
  String get ruleBlackFirst => 'Black moves first.';

  @override
  String get ruleMenMoveDiag => 'Men move one square diagonally forward.';

  @override
  String get ruleMenMoveStraight =>
      'Men move one square straight forward or sideways.';

  @override
  String get ruleMenCapture8 =>
      'Men capture in all 8 directions: diagonally and in straight lines.';

  @override
  String get ruleMenCaptureStraight =>
      'Men capture by jumping straight forward or sideways.';

  @override
  String get ruleMenCaptureBoth => 'Men capture forward and backward.';

  @override
  String get ruleMenCaptureForward => 'Men capture forward only.';

  @override
  String get ruleMenNoKings => 'A man is not allowed to capture a king.';

  @override
  String get ruleKingsFlyDiag =>
      'Kings fly: they slide any number of empty squares diagonally, and can capture from far away.';

  @override
  String get ruleKingsFlyStraight =>
      'Kings fly: they slide any number of empty squares in a straight line, and can capture from far away.';

  @override
  String get ruleKingsShort =>
      'Kings move one square in any diagonal direction.';

  @override
  String get ruleMustCapture =>
      'If you can capture, you must. A capture chain must be finished.';

  @override
  String get rulePriorityNone =>
      'If several captures are possible, you choose which one.';

  @override
  String get rulePriorityMax =>
      'You must choose the capture that takes the most pieces.';

  @override
  String get rulePrioritySpanish =>
      'You must take the most pieces. If equal, the capture with the most kings.';

  @override
  String get rulePriorityItalian =>
      'You must take the most pieces. If equal: capture with a king, then take the most kings, then the chain that meets a king first.';

  @override
  String get rulePriorityFrisian =>
      'You must take the highest value (a king counts a little less than two men). If equal, a king must do the capturing.';

  @override
  String get ruleRemoveAsJumped =>
      'A captured piece leaves the board the moment it is jumped.';

  @override
  String get ruleRemoveAfter =>
      'Captured pieces are lifted off together after the move. Until then they block the way and cannot be jumped twice.';

  @override
  String get ruleNoTurnBack =>
      'Inside one capture you may not turn back 180 degrees.';

  @override
  String get rulePromoStop =>
      'A man that reaches the last row becomes a king and the move ends.';

  @override
  String get rulePromoAsMan =>
      'A man becomes a king only if its move ENDS on the last row. If it passes through during a capture, it stays a man.';

  @override
  String get rulePromoAsKing =>
      'A man that reaches the last row during a capture becomes a king at once and keeps capturing as a king.';

  @override
  String ruleKingLimit(int n) {
    return 'The same king may make only $n quiet moves in a row while you still have men.';
  }

  @override
  String get ruleLose => 'You lose if you have no pieces or no legal move.';

  @override
  String ruleDraw(int n) {
    return 'Draw: the same position three times, or $n moves each with no capture and no man move.';
  }

  @override
  String get sectionGame => 'Game';

  @override
  String get variantsInfoTitle => 'Variants';

  @override
  String get variantsInfoText =>
      'Checkers is played with different rules around the world. Pick one here. Open Learn to read the rules of each game.';

  @override
  String get opponent => 'Opponent';

  @override
  String get computer => 'Computer';

  @override
  String get twoPlayers => 'Two players';

  @override
  String get botLevelsTitle => 'Bot levels';

  @override
  String get botLevelsText =>
      'There are 18 computer players. Level 1 plays almost at random. Higher levels look more moves ahead and make fewer mistakes. The top levels think for a few seconds.';

  @override
  String levelN(int n) {
    return 'Level $n';
  }

  @override
  String get passDevice => 'Pass the device after each move.';

  @override
  String get yourColour => 'Your colour';

  @override
  String get startGame => 'Start game';

  @override
  String get bot1 => 'Moves mostly at random and loves giving pieces away.';

  @override
  String get bot2 => 'Just here for a good time. Often walks into your jumps.';

  @override
  String get bot3 => 'Learning the basics. Understands that jumping is good.';

  @override
  String get bot4 => 'Your average park player. Solid but predictable.';

  @override
  String get bot5 => 'Starts looking for double jumps and center control.';

  @override
  String get bot6 => 'Very cautious. Prefers keeping pieces in the back row.';

  @override
  String get bot7 => 'Aggressively attacking. Likes to force exchanges.';

  @override
  String get bot8 => 'A regular at the local checkers club.';

  @override
  String get bot9 => 'Studies the theory. Very efficient in the endgame.';

  @override
  String get bot10 => 'A regional champion. Very few mistakes.';

  @override
  String get bot11 => 'Deep tactical vision. Will trap your king easily.';

  @override
  String get bot12 => 'Looks far ahead. Controls the board rhythm.';

  @override
  String get bot13 => 'National level strength. Incredibly hard to beat.';

  @override
  String get bot14 => 'World-class positioning. Every move has a purpose.';

  @override
  String get bot15 => 'Pattern recognition like a machine. Unyielding.';

  @override
  String get bot16 => 'A beast of a player. Punishes the slightest inaccuracy.';

  @override
  String get bot17 => 'Supercomputer-level calculation.';

  @override
  String get bot18 => 'The strongest bot here: thinks as deep as time allows.';

  @override
  String get noGame => 'No game';

  @override
  String get moves => 'Moves';

  @override
  String get mustCapture => 'You must capture';

  @override
  String isThinking(String name) {
    return '$name is thinking…';
  }

  @override
  String toMove(String name) {
    return '$name to move';
  }

  @override
  String drawBecause(String reason) {
    return 'Draw · $reason';
  }

  @override
  String wonBecause(String name, String reason) {
    return '$name won · $reason';
  }

  @override
  String get reasonResign => 'resignation';

  @override
  String get reasonNoMoves => 'no legal moves';

  @override
  String get reasonRepetition => 'same position three times';

  @override
  String reasonNoProgress(int n) {
    return '$n moves each without progress';
  }

  @override
  String get undo => 'Undo';

  @override
  String get playAgain => 'Play again';

  @override
  String get resign => 'Resign';

  @override
  String get resignQ => 'Resign this game?';

  @override
  String get resignBody => 'Your opponent wins.';

  @override
  String get keepPlaying => 'Keep playing';

  @override
  String get noMovesYet => 'No moves yet';

  @override
  String get language => 'Language';

  @override
  String get languagePhone => 'Phone language';

  @override
  String get translationNote =>
      'Translations are new. Some words may still need checking by a native speaker.';

  @override
  String get display => 'Display';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get textSize => 'Text size';

  @override
  String get showInfo => 'Show info buttons';

  @override
  String get showInfoSub => 'The small (i) buttons that explain things';

  @override
  String get boardAndPieces => 'Board and pieces';

  @override
  String get yourLookTitle => 'Your look only';

  @override
  String get yourLookText =>
      'These choices change only your screen. In an online game your opponent keeps their own board and pieces.';

  @override
  String get board => 'Board';

  @override
  String get pieces => 'Pieces';

  @override
  String get squareNumbers => 'Square numbers';

  @override
  String get showLegal => 'Show legal moves';

  @override
  String get showLegalSub =>
      'Dots where a piece can go, and a ring on pieces that must capture';

  @override
  String get pieceAnimation => 'Piece animation';

  @override
  String get animOff => 'Off';

  @override
  String get animFast => 'Fast';

  @override
  String get animNormal => 'Normal';

  @override
  String get animSlow => 'Slow';

  @override
  String get rulesOfVariants => 'Rules of every variant';

  @override
  String get rulesOfVariantsSub => 'How each of the 9 games is played';

  @override
  String get installApp => 'Install app';

  @override
  String get installAppSub =>
      'Put Licheckers on your home screen. Works offline.';

  @override
  String get board_walnut => 'Walnut';

  @override
  String get board_forest => 'Forest';

  @override
  String get board_ocean => 'Ocean';

  @override
  String get board_midnight => 'Midnight';

  @override
  String get board_sunset => 'Sunset';

  @override
  String get board_clear_green => 'Clear Green';

  @override
  String get board_clear_brown => 'Clear Brown';

  @override
  String get board_clear_blue => 'Clear Blue';

  @override
  String get board_clear_red => 'Clear Red';

  @override
  String get board_contrast => 'High contrast';

  @override
  String get piece_classic => 'Classic';

  @override
  String get piece_wood => 'Wood';

  @override
  String get piece_glass => 'Glass';

  @override
  String get piece_ruby => 'Ivory & Ruby';

  @override
  String get piece_flat => 'Flat';

  @override
  String get installTitle => 'Install Licheckers';

  @override
  String get installBody =>
      'Faster to open, works offline, no app store needed.';

  @override
  String get installNow => 'Install';

  @override
  String get notNow => 'Not now';

  @override
  String get installIosTitle => 'Add to your Home Screen';

  @override
  String get installIosBody =>
      'In Safari, tap the Share button, then “Add to Home Screen”.';

  @override
  String get installDone => 'Licheckers is installed.';

  @override
  String get clock_bullet => 'Bullet';

  @override
  String get clock_blitz => 'Blitz';

  @override
  String get clock_rapid => 'Rapid';

  @override
  String get clock_classic => 'Classic';

  @override
  String startsIn(String time) {
    return 'Starts in $time';
  }

  @override
  String liveEndsIn(String time) {
    return 'Live: ends in $time';
  }

  @override
  String get finished => 'Finished';

  @override
  String leftHM(int h, int m) {
    return '${h}h ${m}m';
  }

  @override
  String leftMS(int m, int s) {
    return '${m}m ${s}s';
  }

  @override
  String durM(int m) {
    return '$m min';
  }

  @override
  String durH(int h) {
    return '$h h';
  }

  @override
  String durHM(int h, int m) {
    return '$h h $m min';
  }

  @override
  String place(String n) {
    String _temp0 = intl.Intl.selectLogic(n, {
      '1': '1st',
      '2': '2nd',
      '3': '3rd',
      'other': '${n}th',
    });
    return '$_temp0';
  }

  @override
  String get arena => 'Arena';

  @override
  String get swiss => 'Swiss';

  @override
  String get createTournament => 'Create a tournament';

  @override
  String get demoNote =>
      'Demo: sample tournaments and no real money yet. Online play and payments come with the server.';

  @override
  String get clockTypesTitle => 'Clock types';

  @override
  String get clockTypesText =>
      'Bullet: 1 to 2 minutes each, very fast.\nBlitz: 3 to 5 minutes each.\nRapid: 10 to 15 minutes each.\nClassic: 20 to 30 minutes each.\n\nA second number like 3+2 means 2 seconds are added after every move.';

  @override
  String get noTournamentsOfType => 'No tournaments of this type yet.';

  @override
  String get yours => 'Yours';

  @override
  String get joinedTag => 'Joined';

  @override
  String presentedBy(String names) {
    return 'Presented by $names';
  }

  @override
  String hostedBy(String host) {
    return 'Hosted by $host';
  }

  @override
  String get entry => 'Entry';

  @override
  String get prizePool => 'Prize pool';

  @override
  String get players => 'Players';

  @override
  String get createTitle => 'Create tournament';

  @override
  String get secAbout => '1. About';

  @override
  String get tournamentName => 'Tournament name';

  @override
  String get secFormat => '2. Format';

  @override
  String get arenaInfo =>
      'Join any time before the end. Play as many games as you can. A win is 3 points, a draw 1, a loss 0. Most points when the clock ends wins.\n\nBest for big crowds, because people can arrive late.';

  @override
  String get swissInfo =>
      'A fixed number of rounds. Each round you are matched with someone who has a similar score. Everyone plays every round. Most points after the last round wins.\n\nBest for smaller, serious events (up to about 200 players). You can only join before round 1 starts.';

  @override
  String get notEnoughRounds =>
      'Not enough time for 3 rounds. Make the tournament longer or the clock faster.';

  @override
  String roundsFit(int n, int max) {
    return 'Rounds: $n (up to $max fit)';
  }

  @override
  String get secClock => '3. Clock';

  @override
  String get clockTitle => 'Clock';

  @override
  String get clockInfo =>
      'Every tournament game has a clock, so a slow player cannot stall the whole event. The second number is extra seconds added after every move.';

  @override
  String minutesPerPlayer(int n) {
    return 'Minutes per player: $n';
  }

  @override
  String secondsAdded(int n) {
    return 'Seconds added after each move: $n';
  }

  @override
  String longGame(String clock, int n) {
    return '$clock. A long game lasts about $n minutes.';
  }

  @override
  String get secWhen => '4. When';

  @override
  String get whenTitle => 'Start and length';

  @override
  String get whenInfo =>
      'Tournaments are short on purpose: 30 minutes to 4 hours. Players see a live countdown to the start, then to the end. No new games are paired in the last minutes; games already running may finish.';

  @override
  String get in1h => 'In 1 hour';

  @override
  String get in3h => 'In 3 hours';

  @override
  String get in8h => 'In 8 hours';

  @override
  String get pickDateTime => 'Pick date and time';

  @override
  String startsAt(String time) {
    return 'Starts: $time';
  }

  @override
  String lengthIs(String d) {
    return 'Length: $d';
  }

  @override
  String endsAt(String time) {
    return 'Ends: $time';
  }

  @override
  String roundsFitIn(int n, String d) {
    return 'About $n rounds fit in $d.';
  }

  @override
  String get secMoney => '5. Players and money';

  @override
  String get moneyTitle => 'How the money works';

  @override
  String moneyInfo(int pct) {
    return 'You lock the whole prize pool when you create the tournament. Players pay the entry fee to join. Winners are paid from your locked prize pool. The entry fees are yours. The platform takes $pct% of your profit only (entry fees minus prize pool). If the entries do not cover the pool, the platform takes nothing.\n\nIf the tournament is cancelled before it starts, everyone is refunded. Once it starts, the money is locked.';
  }

  @override
  String get minPlayers => 'Min players';

  @override
  String get maxPlayers => 'Max players';

  @override
  String get entryFee => 'Entry fee';

  @override
  String get winnerSplit => 'Winner split';

  @override
  String get winnerSplitInfo =>
      'How the prize pool is shared between the top places. Rounding leftovers go to first place.';

  @override
  String get split_winner => 'Winner takes all';

  @override
  String get split_top3 => 'Top 3';

  @override
  String get split_top5 => 'Top 5';

  @override
  String get whatIf => 'What if this many players join?';

  @override
  String get whatIfTitle => 'Your money, worked out';

  @override
  String get whatIfInfo =>
      'Move the slider to see what you would earn. The platform cut is taken from your profit only.';

  @override
  String get feesCollected => 'Entry fees collected';

  @override
  String get poolYouLocked => 'Prize pool you locked';

  @override
  String platformShare(int pct) {
    return 'Platform share ($pct% of profit)';
  }

  @override
  String get youEndWith => 'You end with';

  @override
  String breakEven(int n) {
    return 'You break even at $n players. Below that you lose part of the pool.';
  }

  @override
  String get secBoard => '6. Board and pieces';

  @override
  String get whyOnlyThese => 'Why only these?';

  @override
  String get whyOnlyTheseInfo =>
      'Everyone in the tournament plays on the same board, so players can always see the squares and pieces clearly. Only boards and pieces that pass our readability tests are offered. Sponsors can never change the board.';

  @override
  String piecesNamed(String name) {
    return '$name pieces';
  }

  @override
  String get check_whiteOnDark =>
      'White pieces stand out from the dark squares';

  @override
  String get check_blackOnDark =>
      'Black pieces stand out from the dark squares';

  @override
  String get check_sidesApart =>
      'White and black pieces are easy to tell apart';

  @override
  String get check_squaresApart =>
      'Light and dark squares are easy to tell apart';

  @override
  String checkLine(String label, String value, String need) {
    return '$label ($value : 1, needs $need)';
  }

  @override
  String get secSponsor => '7. Sponsor (optional)';

  @override
  String get sponsoredTitle => 'Sponsored tournaments';

  @override
  String sponsoredInfo(String theme, String pieces) {
    return 'A sponsor changes the look of the app for this tournament only: colours, a logo and a name strip, and optionally their name on the pieces. The board squares never change. There are never pop-ups, videos or sounds, and nothing ever covers the board or the clocks. When a player leaves the tournament, the app looks normal again.\n\nPrice: $theme per sponsor, plus $pieces per sponsor to put their name on the pieces. Artwork is checked first, so a sponsored tournament must start at least 6 hours from now.';
  }

  @override
  String get noSponsor => 'No sponsor';

  @override
  String get oneSponsor => 'One sponsor';

  @override
  String get twoSponsors => 'Two sponsors (half each)';

  @override
  String get sponsorName => 'Sponsor name';

  @override
  String get sponsor1Name => 'Sponsor 1 name (white side)';

  @override
  String get sponsor2Name => 'Sponsor 2 name (black side)';

  @override
  String get sponsor => 'Sponsor';

  @override
  String get sponsor1 => 'Sponsor 1';

  @override
  String get sponsor2 => 'Sponsor 2';

  @override
  String nameOnPieces(String price) {
    return 'Name on pieces (+$price)';
  }

  @override
  String nameOnWhite(String price) {
    return 'Name on white pieces (+$price)';
  }

  @override
  String nameOnBlack(String price) {
    return 'Name on black pieces (+$price)';
  }

  @override
  String upToLetters(int n) {
    return 'Up to $n letters, checked for readability';
  }

  @override
  String sponsorTotal(String price) {
    return 'Sponsor total: $price';
  }

  @override
  String get logoRules =>
      'Logos: PNG, JPG or WebP, under 2 MB. Every logo is checked by a person (no adult content, no fake brands) before other players can see it.';

  @override
  String get upload => 'Upload';

  @override
  String get fromLink => 'From a link';

  @override
  String get logoColour => 'Colour from the logo';

  @override
  String get logoAdded =>
      'The logo colour is now the tournament colour. The logo waits for a safety check by a person: until then only you can see it.';

  @override
  String get linkTitle => 'Add a picture from a link';

  @override
  String get linkHelp =>
      'Paste the address of the picture itself (it usually ends in .png or .jpg). Some websites block other apps from using their pictures. If that happens, download the picture and use Upload instead.';

  @override
  String somethingWrong(String error) {
    return 'Something went wrong: $error';
  }

  @override
  String get secOptions => '8. Options';

  @override
  String get allowVoice => 'Allow voice chat in games';

  @override
  String get allowVoiceSub => 'Players can still choose to talk or not';

  @override
  String get watchDelay => 'Live watching delay';

  @override
  String get watchDelayTitle => 'Watching delay';

  @override
  String get watchDelayInfo =>
      'Other people can watch the top games live. In paid tournaments their view is a few seconds late, so nobody can pass the best move to a player.';

  @override
  String seconds(int n) {
    return '$n s';
  }

  @override
  String moreProblems(String first, int n) {
    return '$first  (+$n more)';
  }

  @override
  String get youPayNow => 'You pay now';

  @override
  String get lockAndCreate => 'Lock prize pool and create';

  @override
  String get confirmTitle => 'Lock the prize pool and create?';

  @override
  String confirmPay(String total) {
    return 'You pay $total now:';
  }

  @override
  String confirmPool(String amount) {
    return 'Prize pool (locked): $amount';
  }

  @override
  String confirmFee(String amount) {
    return 'Creation fee: $amount';
  }

  @override
  String confirmSponsor(String amount) {
    return 'Sponsor look: $amount';
  }

  @override
  String get confirmRules =>
      'If the tournament is cancelled before it starts, every player gets their entry fee back and your prize pool returns to you. Once it starts, the prize pool stays locked until the winners are paid.';

  @override
  String get demoNoMoney => 'Demo: no real money moves yet.';

  @override
  String get p_nameShort => 'Give the tournament a name (3+ letters).';

  @override
  String p_clockRange(String type) {
    return 'The clock is outside the $type range.';
  }

  @override
  String get p_lengthRange => 'Length must be between 30 minutes and 4 hours.';

  @override
  String get p_startSoon => 'Start at least 30 minutes from now.';

  @override
  String get p_sponsoredStartSoon =>
      'Sponsored tournaments must start at least 6 hours from now, so the artwork can be checked.';

  @override
  String p_swissFew(int n) {
    return 'Only $n Swiss rounds fit. Make it longer or the clock faster.';
  }

  @override
  String p_swissTooMany(int n) {
    return 'At most $n rounds fit in this time.';
  }

  @override
  String get p_arenaTooSlow =>
      'This clock is too slow for this time window. Make the tournament longer or the clock faster.';

  @override
  String get p_minPlayers => 'At least 2 players are needed.';

  @override
  String get p_maxBelowMin => 'Maximum players must be at least the minimum.';

  @override
  String p_poolTooSmall(String amount) {
    return 'The prize pool must be at least $amount.';
  }

  @override
  String p_prizesNeedPlayers(int n) {
    return '$n prizes need at least $n players.';
  }

  @override
  String get p_boardUnclear =>
      'This board and piece pair is not clear enough. Pick another pair.';

  @override
  String get p_sponsorName => 'Enter the sponsor name.';

  @override
  String get p_sponsor2Name => 'Enter the second sponsor name.';

  @override
  String p_whiteLabel(String problem) {
    return 'White pieces: $problem';
  }

  @override
  String p_blackLabel(String problem) {
    return 'Black pieces: $problem';
  }

  @override
  String lbl_empty(int n) {
    return 'Type a short name (up to $n letters).';
  }

  @override
  String lbl_tooLong(int n) {
    return 'Too long: at most $n letters so the king crown stays visible.';
  }

  @override
  String get lbl_unreadable =>
      'This name would be hard to read on these pieces. Pick other pieces.';

  @override
  String get e_svg =>
      'SVG files will be accepted once the server can convert them safely. For now please use PNG or JPG.';

  @override
  String get e_type => 'Please use a PNG, JPG or WebP picture.';

  @override
  String get e_big => 'The picture is too big. Keep it under 2 MB.';

  @override
  String get e_empty => 'The file is empty.';

  @override
  String get e_https => 'Use a full link that starts with https://';

  @override
  String get e_link =>
      'Could not load that link. Some websites block other apps from using their pictures. Download the picture and use Upload instead.';

  @override
  String e_http(String code) {
    return 'The website answered with an error ($code).';
  }

  @override
  String get e_webpage =>
      'That link is a web page, not a picture. Open the picture itself and copy its address.';

  @override
  String get e_notPicture => 'This file is not a picture we can read.';

  @override
  String get joinForFree => 'Join for free';

  @override
  String joinFor(String price) {
    return 'Join for $price';
  }

  @override
  String get joinForFreeQ => 'Join for free?';

  @override
  String joinForQ(String price) {
    return 'Join for $price?';
  }

  @override
  String get refundNote =>
      'If the tournament is cancelled before it starts, you get your entry fee back.';

  @override
  String get created =>
      'Tournament created. Share the link below so people can join.';

  @override
  String get logoPending =>
      'Logo waiting for safety check: only you can see it';

  @override
  String fromTo(String start, String end, String d) {
    return '$start to $end  ($d)';
  }

  @override
  String get youreIn => 'You\'re in';

  @override
  String get invitePeople => 'Invite people';

  @override
  String get shareLinkTitle => 'Share link';

  @override
  String get shareLinkInfo =>
      'Send this link on WhatsApp or anywhere. People who already have the app open this tournament. New people are asked to sign up first, then join.\n\nThe link starts working when online play is live.';

  @override
  String get copyLink => 'Copy link';

  @override
  String get linkCopied => 'Link copied';

  @override
  String get prizes => 'Prizes';

  @override
  String joinedCount(int n, int min, int max) {
    return '$n joined (min $min, max $max)';
  }

  @override
  String get howItWorks => 'How it works';

  @override
  String get pointsTitle => 'Points and ties';

  @override
  String get pointsInfo =>
      'Win 3 points, draw 1, loss 0. If players have the same points, more wins ranks higher, then the head-to-head result, then the strength of opponents, then fewer games, then who reached the score first. So there is always only one first place.';

  @override
  String get arenaShort =>
      'Arena: join any time. Play as many games as you can. Most points when the clock ends wins.';

  @override
  String swissShort(int n) {
    return 'Swiss: $n rounds. Each round you meet someone with a similar score. Join before round 1.';
  }

  @override
  String get pointsLine => 'Win = 3 points · Draw = 1 · Loss = 0';

  @override
  String get voiceOn => 'Voice chat is allowed (opt-in for both players).';

  @override
  String get voiceOff => 'Voice chat is off in this tournament.';

  @override
  String get watchNoDelay => 'Live watching: no delay.';

  @override
  String watchDelayed(int n) {
    return 'Live watching is $n seconds late.';
  }

  @override
  String get boardYouPlay => 'The board you will play on';

  @override
  String get sameBoardTitle => 'Same board for everyone';

  @override
  String get sameBoardInfo =>
      'Everyone in this tournament sees this board and these pieces, so the game is always clear. Your own board choice returns when you leave.';

  @override
  String get yourMoney => 'Your money (host)';

  @override
  String get feesSoFar => 'Entry fees so far';

  @override
  String get poolLocked => 'Prize pool locked';

  @override
  String get youWouldEnd => 'You would end with';

  @override
  String get quickEasy => 'Easy';

  @override
  String get quickMedium => 'Medium';

  @override
  String get quickHard => 'Hard';

  @override
  String get twoPlayersSub => 'one device';

  @override
  String get customTile => 'Custom';

  @override
  String get customSub => 'your choices';

  @override
  String get customTitle => 'Custom game';

  @override
  String get chooseVariant => 'Choose a game';

  @override
  String get nextTournament => 'Next tournament';

  @override
  String get noClock => 'No clock';

  @override
  String get reasonTimeout => 'time ran out';

  @override
  String get newGame => 'New game';

  @override
  String get sounds => 'Sounds and vibration';

  @override
  String get soundsSub => 'Moves, captures, kings, low time and game end';

  @override
  String get prevMove => 'Previous move';

  @override
  String get nextMove => 'Next move';

  @override
  String get backToGame => 'Back to the game';
}
