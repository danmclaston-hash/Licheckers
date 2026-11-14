import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_lg.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_sw.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of L
/// returned by `L.of(context)`.
///
/// Applications need to include `L.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: L.localizationsDelegates,
///   supportedLocales: L.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the L.supportedLocales
/// property.
abstract class L {
  L(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static L of(BuildContext context) {
    return Localizations.of<L>(context, L)!;
  }

  static const LocalizationsDelegate<L> delegate = _LDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('lg'),
    Locale('pt'),
    Locale('sw'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Licheckers'**
  String get appTitle;

  /// No description provided for @navPlay.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get navPlay;

  /// No description provided for @navTournaments.
  ///
  /// In en, this message translates to:
  /// **'Tournaments'**
  String get navTournaments;

  /// No description provided for @navLearn.
  ///
  /// In en, this message translates to:
  /// **'Learn'**
  String get navLearn;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @infoTooltip.
  ///
  /// In en, this message translates to:
  /// **'What is this?'**
  String get infoTooltip;

  /// No description provided for @gotIt.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get gotIt;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @join.
  ///
  /// In en, this message translates to:
  /// **'Join'**
  String get join;

  /// No description provided for @white.
  ///
  /// In en, this message translates to:
  /// **'White'**
  String get white;

  /// No description provided for @black.
  ///
  /// In en, this message translates to:
  /// **'Black'**
  String get black;

  /// No description provided for @you.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get you;

  /// No description provided for @free.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get free;

  /// No description provided for @none.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get none;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @variant_english.
  ///
  /// In en, this message translates to:
  /// **'English (American)'**
  String get variant_english;

  /// No description provided for @variant_international.
  ///
  /// In en, this message translates to:
  /// **'International'**
  String get variant_international;

  /// No description provided for @variant_brazilian.
  ///
  /// In en, this message translates to:
  /// **'Brazilian'**
  String get variant_brazilian;

  /// No description provided for @variant_russian.
  ///
  /// In en, this message translates to:
  /// **'Russian'**
  String get variant_russian;

  /// No description provided for @variant_italian.
  ///
  /// In en, this message translates to:
  /// **'Italian'**
  String get variant_italian;

  /// No description provided for @variant_spanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get variant_spanish;

  /// No description provided for @variant_turkish.
  ///
  /// In en, this message translates to:
  /// **'Turkish (Dama)'**
  String get variant_turkish;

  /// No description provided for @variant_frisian.
  ///
  /// In en, this message translates to:
  /// **'Frisian'**
  String get variant_frisian;

  /// No description provided for @variant_canadian.
  ///
  /// In en, this message translates to:
  /// **'Canadian'**
  String get variant_canadian;

  /// No description provided for @tagFlyingKings.
  ///
  /// In en, this message translates to:
  /// **'flying kings'**
  String get tagFlyingKings;

  /// No description provided for @tagShortKings.
  ///
  /// In en, this message translates to:
  /// **'short kings'**
  String get tagShortKings;

  /// No description provided for @tagStraightMoves.
  ///
  /// In en, this message translates to:
  /// **'straight moves'**
  String get tagStraightMoves;

  /// No description provided for @tagCaptures8.
  ///
  /// In en, this message translates to:
  /// **'captures in 8 directions'**
  String get tagCaptures8;

  /// No description provided for @tagMenNoKings.
  ///
  /// In en, this message translates to:
  /// **'men cannot take kings'**
  String get tagMenNoKings;

  /// No description provided for @tagFreeChoice.
  ///
  /// In en, this message translates to:
  /// **'free choice of capture'**
  String get tagFreeChoice;

  /// No description provided for @tagMenForward.
  ///
  /// In en, this message translates to:
  /// **'men capture forward only'**
  String get tagMenForward;

  /// No description provided for @tagMustTakeMost.
  ///
  /// In en, this message translates to:
  /// **'must take the most pieces'**
  String get tagMustTakeMost;

  /// No description provided for @howToPlay.
  ///
  /// In en, this message translates to:
  /// **'How to play'**
  String get howToPlay;

  /// No description provided for @ruleBoardDiag.
  ///
  /// In en, this message translates to:
  /// **'Board: {size}x{size}. Each player starts with {count} men on the dark squares.'**
  String ruleBoardDiag(int size, int count);

  /// No description provided for @ruleBoardAll.
  ///
  /// In en, this message translates to:
  /// **'Board: {size}x{size}. Each player starts with {count} men, using every square.'**
  String ruleBoardAll(int size, int count);

  /// No description provided for @ruleWhiteFirst.
  ///
  /// In en, this message translates to:
  /// **'White moves first.'**
  String get ruleWhiteFirst;

  /// No description provided for @ruleBlackFirst.
  ///
  /// In en, this message translates to:
  /// **'Black moves first.'**
  String get ruleBlackFirst;

  /// No description provided for @ruleMenMoveDiag.
  ///
  /// In en, this message translates to:
  /// **'Men move one square diagonally forward.'**
  String get ruleMenMoveDiag;

  /// No description provided for @ruleMenMoveStraight.
  ///
  /// In en, this message translates to:
  /// **'Men move one square straight forward or sideways.'**
  String get ruleMenMoveStraight;

  /// No description provided for @ruleMenCapture8.
  ///
  /// In en, this message translates to:
  /// **'Men capture in all 8 directions: diagonally and in straight lines.'**
  String get ruleMenCapture8;

  /// No description provided for @ruleMenCaptureStraight.
  ///
  /// In en, this message translates to:
  /// **'Men capture by jumping straight forward or sideways.'**
  String get ruleMenCaptureStraight;

  /// No description provided for @ruleMenCaptureBoth.
  ///
  /// In en, this message translates to:
  /// **'Men capture forward and backward.'**
  String get ruleMenCaptureBoth;

  /// No description provided for @ruleMenCaptureForward.
  ///
  /// In en, this message translates to:
  /// **'Men capture forward only.'**
  String get ruleMenCaptureForward;

  /// No description provided for @ruleMenNoKings.
  ///
  /// In en, this message translates to:
  /// **'A man is not allowed to capture a king.'**
  String get ruleMenNoKings;

  /// No description provided for @ruleKingsFlyDiag.
  ///
  /// In en, this message translates to:
  /// **'Kings fly: they slide any number of empty squares diagonally, and can capture from far away.'**
  String get ruleKingsFlyDiag;

  /// No description provided for @ruleKingsFlyStraight.
  ///
  /// In en, this message translates to:
  /// **'Kings fly: they slide any number of empty squares in a straight line, and can capture from far away.'**
  String get ruleKingsFlyStraight;

  /// No description provided for @ruleKingsShort.
  ///
  /// In en, this message translates to:
  /// **'Kings move one square in any diagonal direction.'**
  String get ruleKingsShort;

  /// No description provided for @ruleMustCapture.
  ///
  /// In en, this message translates to:
  /// **'If you can capture, you must. A capture chain must be finished.'**
  String get ruleMustCapture;

  /// No description provided for @rulePriorityNone.
  ///
  /// In en, this message translates to:
  /// **'If several captures are possible, you choose which one.'**
  String get rulePriorityNone;

  /// No description provided for @rulePriorityMax.
  ///
  /// In en, this message translates to:
  /// **'You must choose the capture that takes the most pieces.'**
  String get rulePriorityMax;

  /// No description provided for @rulePrioritySpanish.
  ///
  /// In en, this message translates to:
  /// **'You must take the most pieces. If equal, the capture with the most kings.'**
  String get rulePrioritySpanish;

  /// No description provided for @rulePriorityItalian.
  ///
  /// In en, this message translates to:
  /// **'You must take the most pieces. If equal: capture with a king, then take the most kings, then the chain that meets a king first.'**
  String get rulePriorityItalian;

  /// No description provided for @rulePriorityFrisian.
  ///
  /// In en, this message translates to:
  /// **'You must take the highest value (a king counts a little less than two men). If equal, a king must do the capturing.'**
  String get rulePriorityFrisian;

  /// No description provided for @ruleRemoveAsJumped.
  ///
  /// In en, this message translates to:
  /// **'A captured piece leaves the board the moment it is jumped.'**
  String get ruleRemoveAsJumped;

  /// No description provided for @ruleRemoveAfter.
  ///
  /// In en, this message translates to:
  /// **'Captured pieces are lifted off together after the move. Until then they block the way and cannot be jumped twice.'**
  String get ruleRemoveAfter;

  /// No description provided for @ruleNoTurnBack.
  ///
  /// In en, this message translates to:
  /// **'Inside one capture you may not turn back 180 degrees.'**
  String get ruleNoTurnBack;

  /// No description provided for @rulePromoStop.
  ///
  /// In en, this message translates to:
  /// **'A man that reaches the last row becomes a king and the move ends.'**
  String get rulePromoStop;

  /// No description provided for @rulePromoAsMan.
  ///
  /// In en, this message translates to:
  /// **'A man becomes a king only if its move ENDS on the last row. If it passes through during a capture, it stays a man.'**
  String get rulePromoAsMan;

  /// No description provided for @rulePromoAsKing.
  ///
  /// In en, this message translates to:
  /// **'A man that reaches the last row during a capture becomes a king at once and keeps capturing as a king.'**
  String get rulePromoAsKing;

  /// No description provided for @ruleKingLimit.
  ///
  /// In en, this message translates to:
  /// **'The same king may make only {n} quiet moves in a row while you still have men.'**
  String ruleKingLimit(int n);

  /// No description provided for @ruleLose.
  ///
  /// In en, this message translates to:
  /// **'You lose if you have no pieces or no legal move.'**
  String get ruleLose;

  /// No description provided for @ruleDraw.
  ///
  /// In en, this message translates to:
  /// **'Draw: the same position three times, or {n} moves each with no capture and no man move.'**
  String ruleDraw(int n);

  /// No description provided for @sectionGame.
  ///
  /// In en, this message translates to:
  /// **'Game'**
  String get sectionGame;

  /// No description provided for @variantsInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Variants'**
  String get variantsInfoTitle;

  /// No description provided for @variantsInfoText.
  ///
  /// In en, this message translates to:
  /// **'Checkers is played with different rules around the world. Pick one here. Open Learn to read the rules of each game.'**
  String get variantsInfoText;

  /// No description provided for @opponent.
  ///
  /// In en, this message translates to:
  /// **'Opponent'**
  String get opponent;

  /// No description provided for @computer.
  ///
  /// In en, this message translates to:
  /// **'Computer'**
  String get computer;

  /// No description provided for @twoPlayers.
  ///
  /// In en, this message translates to:
  /// **'Two players'**
  String get twoPlayers;

  /// No description provided for @botLevelsTitle.
  ///
  /// In en, this message translates to:
  /// **'Bot levels'**
  String get botLevelsTitle;

  /// No description provided for @botLevelsText.
  ///
  /// In en, this message translates to:
  /// **'There are 18 computer players. Level 1 plays almost at random. Higher levels look more moves ahead and make fewer mistakes. The top levels think for a few seconds.'**
  String get botLevelsText;

  /// No description provided for @levelN.
  ///
  /// In en, this message translates to:
  /// **'Level {n}'**
  String levelN(int n);

  /// No description provided for @passDevice.
  ///
  /// In en, this message translates to:
  /// **'Pass the device after each move.'**
  String get passDevice;

  /// No description provided for @yourColour.
  ///
  /// In en, this message translates to:
  /// **'Your colour'**
  String get yourColour;

  /// No description provided for @startGame.
  ///
  /// In en, this message translates to:
  /// **'Start game'**
  String get startGame;

  /// No description provided for @bot1.
  ///
  /// In en, this message translates to:
  /// **'Moves mostly at random and loves giving pieces away.'**
  String get bot1;

  /// No description provided for @bot2.
  ///
  /// In en, this message translates to:
  /// **'Just here for a good time. Often walks into your jumps.'**
  String get bot2;

  /// No description provided for @bot3.
  ///
  /// In en, this message translates to:
  /// **'Learning the basics. Understands that jumping is good.'**
  String get bot3;

  /// No description provided for @bot4.
  ///
  /// In en, this message translates to:
  /// **'Your average park player. Solid but predictable.'**
  String get bot4;

  /// No description provided for @bot5.
  ///
  /// In en, this message translates to:
  /// **'Starts looking for double jumps and center control.'**
  String get bot5;

  /// No description provided for @bot6.
  ///
  /// In en, this message translates to:
  /// **'Very cautious. Prefers keeping pieces in the back row.'**
  String get bot6;

  /// No description provided for @bot7.
  ///
  /// In en, this message translates to:
  /// **'Aggressively attacking. Likes to force exchanges.'**
  String get bot7;

  /// No description provided for @bot8.
  ///
  /// In en, this message translates to:
  /// **'A regular at the local checkers club.'**
  String get bot8;

  /// No description provided for @bot9.
  ///
  /// In en, this message translates to:
  /// **'Studies the theory. Very efficient in the endgame.'**
  String get bot9;

  /// No description provided for @bot10.
  ///
  /// In en, this message translates to:
  /// **'A regional champion. Very few mistakes.'**
  String get bot10;

  /// No description provided for @bot11.
  ///
  /// In en, this message translates to:
  /// **'Deep tactical vision. Will trap your king easily.'**
  String get bot11;

  /// No description provided for @bot12.
  ///
  /// In en, this message translates to:
  /// **'Looks far ahead. Controls the board rhythm.'**
  String get bot12;

  /// No description provided for @bot13.
  ///
  /// In en, this message translates to:
  /// **'National level strength. Incredibly hard to beat.'**
  String get bot13;

  /// No description provided for @bot14.
  ///
  /// In en, this message translates to:
  /// **'World-class positioning. Every move has a purpose.'**
  String get bot14;

  /// No description provided for @bot15.
  ///
  /// In en, this message translates to:
  /// **'Pattern recognition like a machine. Unyielding.'**
  String get bot15;

  /// No description provided for @bot16.
  ///
  /// In en, this message translates to:
  /// **'A beast of a player. Punishes the slightest inaccuracy.'**
  String get bot16;

  /// No description provided for @bot17.
  ///
  /// In en, this message translates to:
  /// **'Supercomputer-level calculation.'**
  String get bot17;

  /// No description provided for @bot18.
  ///
  /// In en, this message translates to:
  /// **'The strongest bot here: thinks as deep as time allows.'**
  String get bot18;

  /// No description provided for @noGame.
  ///
  /// In en, this message translates to:
  /// **'No game'**
  String get noGame;

  /// No description provided for @moves.
  ///
  /// In en, this message translates to:
  /// **'Moves'**
  String get moves;

  /// No description provided for @mustCapture.
  ///
  /// In en, this message translates to:
  /// **'You must capture'**
  String get mustCapture;

  /// No description provided for @isThinking.
  ///
  /// In en, this message translates to:
  /// **'{name} is thinking…'**
  String isThinking(String name);

  /// No description provided for @toMove.
  ///
  /// In en, this message translates to:
  /// **'{name} to move'**
  String toMove(String name);

  /// No description provided for @drawBecause.
  ///
  /// In en, this message translates to:
  /// **'Draw · {reason}'**
  String drawBecause(String reason);

  /// No description provided for @wonBecause.
  ///
  /// In en, this message translates to:
  /// **'{name} won · {reason}'**
  String wonBecause(String name, String reason);

  /// No description provided for @reasonResign.
  ///
  /// In en, this message translates to:
  /// **'resignation'**
  String get reasonResign;

  /// No description provided for @reasonNoMoves.
  ///
  /// In en, this message translates to:
  /// **'no legal moves'**
  String get reasonNoMoves;

  /// No description provided for @reasonRepetition.
  ///
  /// In en, this message translates to:
  /// **'same position three times'**
  String get reasonRepetition;

  /// No description provided for @reasonNoProgress.
  ///
  /// In en, this message translates to:
  /// **'{n} moves each without progress'**
  String reasonNoProgress(int n);

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// No description provided for @playAgain.
  ///
  /// In en, this message translates to:
  /// **'Play again'**
  String get playAgain;

  /// No description provided for @resign.
  ///
  /// In en, this message translates to:
  /// **'Resign'**
  String get resign;

  /// No description provided for @resignQ.
  ///
  /// In en, this message translates to:
  /// **'Resign this game?'**
  String get resignQ;

  /// No description provided for @resignBody.
  ///
  /// In en, this message translates to:
  /// **'Your opponent wins.'**
  String get resignBody;

  /// No description provided for @keepPlaying.
  ///
  /// In en, this message translates to:
  /// **'Keep playing'**
  String get keepPlaying;

  /// No description provided for @noMovesYet.
  ///
  /// In en, this message translates to:
  /// **'No moves yet'**
  String get noMovesYet;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languagePhone.
  ///
  /// In en, this message translates to:
  /// **'Phone language'**
  String get languagePhone;

  /// No description provided for @translationNote.
  ///
  /// In en, this message translates to:
  /// **'Translations are new. Some words may still need checking by a native speaker.'**
  String get translationNote;

  /// No description provided for @display.
  ///
  /// In en, this message translates to:
  /// **'Display'**
  String get display;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @textSize.
  ///
  /// In en, this message translates to:
  /// **'Text size'**
  String get textSize;

  /// No description provided for @showInfo.
  ///
  /// In en, this message translates to:
  /// **'Show info buttons'**
  String get showInfo;

  /// No description provided for @showInfoSub.
  ///
  /// In en, this message translates to:
  /// **'The small (i) buttons that explain things'**
  String get showInfoSub;

  /// No description provided for @boardAndPieces.
  ///
  /// In en, this message translates to:
  /// **'Board and pieces'**
  String get boardAndPieces;

  /// No description provided for @yourLookTitle.
  ///
  /// In en, this message translates to:
  /// **'Your look only'**
  String get yourLookTitle;

  /// No description provided for @yourLookText.
  ///
  /// In en, this message translates to:
  /// **'These choices change only your screen. In an online game your opponent keeps their own board and pieces.'**
  String get yourLookText;

  /// No description provided for @board.
  ///
  /// In en, this message translates to:
  /// **'Board'**
  String get board;

  /// No description provided for @pieces.
  ///
  /// In en, this message translates to:
  /// **'Pieces'**
  String get pieces;

  /// No description provided for @squareNumbers.
  ///
  /// In en, this message translates to:
  /// **'Square numbers'**
  String get squareNumbers;

  /// No description provided for @showLegal.
  ///
  /// In en, this message translates to:
  /// **'Show legal moves'**
  String get showLegal;

  /// No description provided for @showLegalSub.
  ///
  /// In en, this message translates to:
  /// **'Dots where a piece can go, and a ring on pieces that must capture'**
  String get showLegalSub;

  /// No description provided for @pieceAnimation.
  ///
  /// In en, this message translates to:
  /// **'Piece animation'**
  String get pieceAnimation;

  /// No description provided for @animOff.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get animOff;

  /// No description provided for @animFast.
  ///
  /// In en, this message translates to:
  /// **'Fast'**
  String get animFast;

  /// No description provided for @animNormal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get animNormal;

  /// No description provided for @animSlow.
  ///
  /// In en, this message translates to:
  /// **'Slow'**
  String get animSlow;

  /// No description provided for @rulesOfVariants.
  ///
  /// In en, this message translates to:
  /// **'Rules of every variant'**
  String get rulesOfVariants;

  /// No description provided for @rulesOfVariantsSub.
  ///
  /// In en, this message translates to:
  /// **'How each of the 9 games is played'**
  String get rulesOfVariantsSub;

  /// No description provided for @installApp.
  ///
  /// In en, this message translates to:
  /// **'Install app'**
  String get installApp;

  /// No description provided for @installAppSub.
  ///
  /// In en, this message translates to:
  /// **'Put Licheckers on your home screen. Works offline.'**
  String get installAppSub;

  /// No description provided for @board_walnut.
  ///
  /// In en, this message translates to:
  /// **'Walnut'**
  String get board_walnut;

  /// No description provided for @board_forest.
  ///
  /// In en, this message translates to:
  /// **'Forest'**
  String get board_forest;

  /// No description provided for @board_ocean.
  ///
  /// In en, this message translates to:
  /// **'Ocean'**
  String get board_ocean;

  /// No description provided for @board_midnight.
  ///
  /// In en, this message translates to:
  /// **'Midnight'**
  String get board_midnight;

  /// No description provided for @board_sunset.
  ///
  /// In en, this message translates to:
  /// **'Sunset'**
  String get board_sunset;

  /// No description provided for @board_clear_green.
  ///
  /// In en, this message translates to:
  /// **'Clear Green'**
  String get board_clear_green;

  /// No description provided for @board_clear_brown.
  ///
  /// In en, this message translates to:
  /// **'Clear Brown'**
  String get board_clear_brown;

  /// No description provided for @board_clear_blue.
  ///
  /// In en, this message translates to:
  /// **'Clear Blue'**
  String get board_clear_blue;

  /// No description provided for @board_clear_red.
  ///
  /// In en, this message translates to:
  /// **'Clear Red'**
  String get board_clear_red;

  /// No description provided for @board_contrast.
  ///
  /// In en, this message translates to:
  /// **'High contrast'**
  String get board_contrast;

  /// No description provided for @piece_classic.
  ///
  /// In en, this message translates to:
  /// **'Classic'**
  String get piece_classic;

  /// No description provided for @piece_wood.
  ///
  /// In en, this message translates to:
  /// **'Wood'**
  String get piece_wood;

  /// No description provided for @piece_glass.
  ///
  /// In en, this message translates to:
  /// **'Glass'**
  String get piece_glass;

  /// No description provided for @piece_ruby.
  ///
  /// In en, this message translates to:
  /// **'Ivory & Ruby'**
  String get piece_ruby;

  /// No description provided for @piece_flat.
  ///
  /// In en, this message translates to:
  /// **'Flat'**
  String get piece_flat;

  /// No description provided for @installTitle.
  ///
  /// In en, this message translates to:
  /// **'Install Licheckers'**
  String get installTitle;

  /// No description provided for @installBody.
  ///
  /// In en, this message translates to:
  /// **'Faster to open, works offline, no app store needed.'**
  String get installBody;

  /// No description provided for @installNow.
  ///
  /// In en, this message translates to:
  /// **'Install'**
  String get installNow;

  /// No description provided for @notNow.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get notNow;

  /// No description provided for @installIosTitle.
  ///
  /// In en, this message translates to:
  /// **'Add to your Home Screen'**
  String get installIosTitle;

  /// No description provided for @installIosBody.
  ///
  /// In en, this message translates to:
  /// **'In Safari, tap the Share button, then “Add to Home Screen”.'**
  String get installIosBody;

  /// No description provided for @installDone.
  ///
  /// In en, this message translates to:
  /// **'Licheckers is installed.'**
  String get installDone;

  /// No description provided for @clock_bullet.
  ///
  /// In en, this message translates to:
  /// **'Bullet'**
  String get clock_bullet;

  /// No description provided for @clock_blitz.
  ///
  /// In en, this message translates to:
  /// **'Blitz'**
  String get clock_blitz;

  /// No description provided for @clock_rapid.
  ///
  /// In en, this message translates to:
  /// **'Rapid'**
  String get clock_rapid;

  /// No description provided for @clock_classic.
  ///
  /// In en, this message translates to:
  /// **'Classic'**
  String get clock_classic;

  /// No description provided for @startsIn.
  ///
  /// In en, this message translates to:
  /// **'Starts in {time}'**
  String startsIn(String time);

  /// No description provided for @liveEndsIn.
  ///
  /// In en, this message translates to:
  /// **'Live: ends in {time}'**
  String liveEndsIn(String time);

  /// No description provided for @finished.
  ///
  /// In en, this message translates to:
  /// **'Finished'**
  String get finished;

  /// No description provided for @leftHM.
  ///
  /// In en, this message translates to:
  /// **'{h}h {m}m'**
  String leftHM(int h, int m);

  /// No description provided for @leftMS.
  ///
  /// In en, this message translates to:
  /// **'{m}m {s}s'**
  String leftMS(int m, int s);

  /// No description provided for @durM.
  ///
  /// In en, this message translates to:
  /// **'{m} min'**
  String durM(int m);

  /// No description provided for @durH.
  ///
  /// In en, this message translates to:
  /// **'{h} h'**
  String durH(int h);

  /// No description provided for @durHM.
  ///
  /// In en, this message translates to:
  /// **'{h} h {m} min'**
  String durHM(int h, int m);

  /// No description provided for @place.
  ///
  /// In en, this message translates to:
  /// **'{n, select, 1{1st} 2{2nd} 3{3rd} other{{n}th}}'**
  String place(String n);

  /// No description provided for @arena.
  ///
  /// In en, this message translates to:
  /// **'Arena'**
  String get arena;

  /// No description provided for @swiss.
  ///
  /// In en, this message translates to:
  /// **'Swiss'**
  String get swiss;

  /// No description provided for @createTournament.
  ///
  /// In en, this message translates to:
  /// **'Create a tournament'**
  String get createTournament;

  /// No description provided for @demoNote.
  ///
  /// In en, this message translates to:
  /// **'Demo: sample tournaments and no real money yet. Online play and payments come with the server.'**
  String get demoNote;

  /// No description provided for @clockTypesTitle.
  ///
  /// In en, this message translates to:
  /// **'Clock types'**
  String get clockTypesTitle;

  /// No description provided for @clockTypesText.
  ///
  /// In en, this message translates to:
  /// **'Bullet: 1 to 2 minutes each, very fast.\nBlitz: 3 to 5 minutes each.\nRapid: 10 to 15 minutes each.\nClassic: 20 to 30 minutes each.\n\nA second number like 3+2 means 2 seconds are added after every move.'**
  String get clockTypesText;

  /// No description provided for @noTournamentsOfType.
  ///
  /// In en, this message translates to:
  /// **'No tournaments of this type yet.'**
  String get noTournamentsOfType;

  /// No description provided for @yours.
  ///
  /// In en, this message translates to:
  /// **'Yours'**
  String get yours;

  /// No description provided for @joinedTag.
  ///
  /// In en, this message translates to:
  /// **'Joined'**
  String get joinedTag;

  /// No description provided for @presentedBy.
  ///
  /// In en, this message translates to:
  /// **'Presented by {names}'**
  String presentedBy(String names);

  /// No description provided for @hostedBy.
  ///
  /// In en, this message translates to:
  /// **'Hosted by {host}'**
  String hostedBy(String host);

  /// No description provided for @entry.
  ///
  /// In en, this message translates to:
  /// **'Entry'**
  String get entry;

  /// No description provided for @prizePool.
  ///
  /// In en, this message translates to:
  /// **'Prize pool'**
  String get prizePool;

  /// No description provided for @players.
  ///
  /// In en, this message translates to:
  /// **'Players'**
  String get players;

  /// No description provided for @createTitle.
  ///
  /// In en, this message translates to:
  /// **'Create tournament'**
  String get createTitle;

  /// No description provided for @secAbout.
  ///
  /// In en, this message translates to:
  /// **'1. About'**
  String get secAbout;

  /// No description provided for @tournamentName.
  ///
  /// In en, this message translates to:
  /// **'Tournament name'**
  String get tournamentName;

  /// No description provided for @secFormat.
  ///
  /// In en, this message translates to:
  /// **'2. Format'**
  String get secFormat;

  /// No description provided for @arenaInfo.
  ///
  /// In en, this message translates to:
  /// **'Join any time before the end. Play as many games as you can. A win is 3 points, a draw 1, a loss 0. Most points when the clock ends wins.\n\nBest for big crowds, because people can arrive late.'**
  String get arenaInfo;

  /// No description provided for @swissInfo.
  ///
  /// In en, this message translates to:
  /// **'A fixed number of rounds. Each round you are matched with someone who has a similar score. Everyone plays every round. Most points after the last round wins.\n\nBest for smaller, serious events (up to about 200 players). You can only join before round 1 starts.'**
  String get swissInfo;

  /// No description provided for @notEnoughRounds.
  ///
  /// In en, this message translates to:
  /// **'Not enough time for 3 rounds. Make the tournament longer or the clock faster.'**
  String get notEnoughRounds;

  /// No description provided for @roundsFit.
  ///
  /// In en, this message translates to:
  /// **'Rounds: {n} (up to {max} fit)'**
  String roundsFit(int n, int max);

  /// No description provided for @secClock.
  ///
  /// In en, this message translates to:
  /// **'3. Clock'**
  String get secClock;

  /// No description provided for @clockTitle.
  ///
  /// In en, this message translates to:
  /// **'Clock'**
  String get clockTitle;

  /// No description provided for @clockInfo.
  ///
  /// In en, this message translates to:
  /// **'Every tournament game has a clock, so a slow player cannot stall the whole event. The second number is extra seconds added after every move.'**
  String get clockInfo;

  /// No description provided for @minutesPerPlayer.
  ///
  /// In en, this message translates to:
  /// **'Minutes per player: {n}'**
  String minutesPerPlayer(int n);

  /// No description provided for @secondsAdded.
  ///
  /// In en, this message translates to:
  /// **'Seconds added after each move: {n}'**
  String secondsAdded(int n);

  /// No description provided for @longGame.
  ///
  /// In en, this message translates to:
  /// **'{clock}. A long game lasts about {n} minutes.'**
  String longGame(String clock, int n);

  /// No description provided for @secWhen.
  ///
  /// In en, this message translates to:
  /// **'4. When'**
  String get secWhen;

  /// No description provided for @whenTitle.
  ///
  /// In en, this message translates to:
  /// **'Start and length'**
  String get whenTitle;

  /// No description provided for @whenInfo.
  ///
  /// In en, this message translates to:
  /// **'Tournaments are short on purpose: 30 minutes to 4 hours. Players see a live countdown to the start, then to the end. No new games are paired in the last minutes; games already running may finish.'**
  String get whenInfo;

  /// No description provided for @in1h.
  ///
  /// In en, this message translates to:
  /// **'In 1 hour'**
  String get in1h;

  /// No description provided for @in3h.
  ///
  /// In en, this message translates to:
  /// **'In 3 hours'**
  String get in3h;

  /// No description provided for @in8h.
  ///
  /// In en, this message translates to:
  /// **'In 8 hours'**
  String get in8h;

  /// No description provided for @pickDateTime.
  ///
  /// In en, this message translates to:
  /// **'Pick date and time'**
  String get pickDateTime;

  /// No description provided for @startsAt.
  ///
  /// In en, this message translates to:
  /// **'Starts: {time}'**
  String startsAt(String time);

  /// No description provided for @lengthIs.
  ///
  /// In en, this message translates to:
  /// **'Length: {d}'**
  String lengthIs(String d);

  /// No description provided for @endsAt.
  ///
  /// In en, this message translates to:
  /// **'Ends: {time}'**
  String endsAt(String time);

  /// No description provided for @roundsFitIn.
  ///
  /// In en, this message translates to:
  /// **'About {n} rounds fit in {d}.'**
  String roundsFitIn(int n, String d);

  /// No description provided for @secMoney.
  ///
  /// In en, this message translates to:
  /// **'5. Players and money'**
  String get secMoney;

  /// No description provided for @moneyTitle.
  ///
  /// In en, this message translates to:
  /// **'How the money works'**
  String get moneyTitle;

  /// No description provided for @moneyInfo.
  ///
  /// In en, this message translates to:
  /// **'You lock the whole prize pool when you create the tournament. Players pay the entry fee to join. Winners are paid from your locked prize pool. The entry fees are yours. The platform takes {pct}% of your profit only (entry fees minus prize pool). If the entries do not cover the pool, the platform takes nothing.\n\nIf the tournament is cancelled before it starts, everyone is refunded. Once it starts, the money is locked.'**
  String moneyInfo(int pct);

  /// No description provided for @minPlayers.
  ///
  /// In en, this message translates to:
  /// **'Min players'**
  String get minPlayers;

  /// No description provided for @maxPlayers.
  ///
  /// In en, this message translates to:
  /// **'Max players'**
  String get maxPlayers;

  /// No description provided for @entryFee.
  ///
  /// In en, this message translates to:
  /// **'Entry fee'**
  String get entryFee;

  /// No description provided for @winnerSplit.
  ///
  /// In en, this message translates to:
  /// **'Winner split'**
  String get winnerSplit;

  /// No description provided for @winnerSplitInfo.
  ///
  /// In en, this message translates to:
  /// **'How the prize pool is shared between the top places. Rounding leftovers go to first place.'**
  String get winnerSplitInfo;

  /// No description provided for @split_winner.
  ///
  /// In en, this message translates to:
  /// **'Winner takes all'**
  String get split_winner;

  /// No description provided for @split_top3.
  ///
  /// In en, this message translates to:
  /// **'Top 3'**
  String get split_top3;

  /// No description provided for @split_top5.
  ///
  /// In en, this message translates to:
  /// **'Top 5'**
  String get split_top5;

  /// No description provided for @whatIf.
  ///
  /// In en, this message translates to:
  /// **'What if this many players join?'**
  String get whatIf;

  /// No description provided for @whatIfTitle.
  ///
  /// In en, this message translates to:
  /// **'Your money, worked out'**
  String get whatIfTitle;

  /// No description provided for @whatIfInfo.
  ///
  /// In en, this message translates to:
  /// **'Move the slider to see what you would earn. The platform cut is taken from your profit only.'**
  String get whatIfInfo;

  /// No description provided for @feesCollected.
  ///
  /// In en, this message translates to:
  /// **'Entry fees collected'**
  String get feesCollected;

  /// No description provided for @poolYouLocked.
  ///
  /// In en, this message translates to:
  /// **'Prize pool you locked'**
  String get poolYouLocked;

  /// No description provided for @platformShare.
  ///
  /// In en, this message translates to:
  /// **'Platform share ({pct}% of profit)'**
  String platformShare(int pct);

  /// No description provided for @youEndWith.
  ///
  /// In en, this message translates to:
  /// **'You end with'**
  String get youEndWith;

  /// No description provided for @breakEven.
  ///
  /// In en, this message translates to:
  /// **'You break even at {n} players. Below that you lose part of the pool.'**
  String breakEven(int n);

  /// No description provided for @secBoard.
  ///
  /// In en, this message translates to:
  /// **'6. Board and pieces'**
  String get secBoard;

  /// No description provided for @whyOnlyThese.
  ///
  /// In en, this message translates to:
  /// **'Why only these?'**
  String get whyOnlyThese;

  /// No description provided for @whyOnlyTheseInfo.
  ///
  /// In en, this message translates to:
  /// **'Everyone in the tournament plays on the same board, so players can always see the squares and pieces clearly. Only boards and pieces that pass our readability tests are offered. Sponsors can never change the board.'**
  String get whyOnlyTheseInfo;

  /// No description provided for @piecesNamed.
  ///
  /// In en, this message translates to:
  /// **'{name} pieces'**
  String piecesNamed(String name);

  /// No description provided for @check_whiteOnDark.
  ///
  /// In en, this message translates to:
  /// **'White pieces stand out from the dark squares'**
  String get check_whiteOnDark;

  /// No description provided for @check_blackOnDark.
  ///
  /// In en, this message translates to:
  /// **'Black pieces stand out from the dark squares'**
  String get check_blackOnDark;

  /// No description provided for @check_sidesApart.
  ///
  /// In en, this message translates to:
  /// **'White and black pieces are easy to tell apart'**
  String get check_sidesApart;

  /// No description provided for @check_squaresApart.
  ///
  /// In en, this message translates to:
  /// **'Light and dark squares are easy to tell apart'**
  String get check_squaresApart;

  /// No description provided for @checkLine.
  ///
  /// In en, this message translates to:
  /// **'{label} ({value} : 1, needs {need})'**
  String checkLine(String label, String value, String need);

  /// No description provided for @secSponsor.
  ///
  /// In en, this message translates to:
  /// **'7. Sponsor (optional)'**
  String get secSponsor;

  /// No description provided for @sponsoredTitle.
  ///
  /// In en, this message translates to:
  /// **'Sponsored tournaments'**
  String get sponsoredTitle;

  /// No description provided for @sponsoredInfo.
  ///
  /// In en, this message translates to:
  /// **'A sponsor changes the look of the app for this tournament only: colours, a logo and a name strip, and optionally their name on the pieces. The board squares never change. There are never pop-ups, videos or sounds, and nothing ever covers the board or the clocks. When a player leaves the tournament, the app looks normal again.\n\nPrice: {theme} per sponsor, plus {pieces} per sponsor to put their name on the pieces. Artwork is checked first, so a sponsored tournament must start at least 6 hours from now.'**
  String sponsoredInfo(String theme, String pieces);

  /// No description provided for @noSponsor.
  ///
  /// In en, this message translates to:
  /// **'No sponsor'**
  String get noSponsor;

  /// No description provided for @oneSponsor.
  ///
  /// In en, this message translates to:
  /// **'One sponsor'**
  String get oneSponsor;

  /// No description provided for @twoSponsors.
  ///
  /// In en, this message translates to:
  /// **'Two sponsors (half each)'**
  String get twoSponsors;

  /// No description provided for @sponsorName.
  ///
  /// In en, this message translates to:
  /// **'Sponsor name'**
  String get sponsorName;

  /// No description provided for @sponsor1Name.
  ///
  /// In en, this message translates to:
  /// **'Sponsor 1 name (white side)'**
  String get sponsor1Name;

  /// No description provided for @sponsor2Name.
  ///
  /// In en, this message translates to:
  /// **'Sponsor 2 name (black side)'**
  String get sponsor2Name;

  /// No description provided for @sponsor.
  ///
  /// In en, this message translates to:
  /// **'Sponsor'**
  String get sponsor;

  /// No description provided for @sponsor1.
  ///
  /// In en, this message translates to:
  /// **'Sponsor 1'**
  String get sponsor1;

  /// No description provided for @sponsor2.
  ///
  /// In en, this message translates to:
  /// **'Sponsor 2'**
  String get sponsor2;

  /// No description provided for @nameOnPieces.
  ///
  /// In en, this message translates to:
  /// **'Name on pieces (+{price})'**
  String nameOnPieces(String price);

  /// No description provided for @nameOnWhite.
  ///
  /// In en, this message translates to:
  /// **'Name on white pieces (+{price})'**
  String nameOnWhite(String price);

  /// No description provided for @nameOnBlack.
  ///
  /// In en, this message translates to:
  /// **'Name on black pieces (+{price})'**
  String nameOnBlack(String price);

  /// No description provided for @upToLetters.
  ///
  /// In en, this message translates to:
  /// **'Up to {n} letters, checked for readability'**
  String upToLetters(int n);

  /// No description provided for @sponsorTotal.
  ///
  /// In en, this message translates to:
  /// **'Sponsor total: {price}'**
  String sponsorTotal(String price);

  /// No description provided for @logoRules.
  ///
  /// In en, this message translates to:
  /// **'Logos: PNG, JPG or WebP, under 2 MB. Every logo is checked by a person (no adult content, no fake brands) before other players can see it.'**
  String get logoRules;

  /// No description provided for @upload.
  ///
  /// In en, this message translates to:
  /// **'Upload'**
  String get upload;

  /// No description provided for @fromLink.
  ///
  /// In en, this message translates to:
  /// **'From a link'**
  String get fromLink;

  /// No description provided for @logoColour.
  ///
  /// In en, this message translates to:
  /// **'Colour from the logo'**
  String get logoColour;

  /// No description provided for @logoAdded.
  ///
  /// In en, this message translates to:
  /// **'The logo colour is now the tournament colour. The logo waits for a safety check by a person: until then only you can see it.'**
  String get logoAdded;

  /// No description provided for @linkTitle.
  ///
  /// In en, this message translates to:
  /// **'Add a picture from a link'**
  String get linkTitle;

  /// No description provided for @linkHelp.
  ///
  /// In en, this message translates to:
  /// **'Paste the address of the picture itself (it usually ends in .png or .jpg). Some websites block other apps from using their pictures. If that happens, download the picture and use Upload instead.'**
  String get linkHelp;

  /// No description provided for @somethingWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong: {error}'**
  String somethingWrong(String error);

  /// No description provided for @secOptions.
  ///
  /// In en, this message translates to:
  /// **'8. Options'**
  String get secOptions;

  /// No description provided for @allowVoice.
  ///
  /// In en, this message translates to:
  /// **'Allow voice chat in games'**
  String get allowVoice;

  /// No description provided for @allowVoiceSub.
  ///
  /// In en, this message translates to:
  /// **'Players can still choose to talk or not'**
  String get allowVoiceSub;

  /// No description provided for @watchDelay.
  ///
  /// In en, this message translates to:
  /// **'Live watching delay'**
  String get watchDelay;

  /// No description provided for @watchDelayTitle.
  ///
  /// In en, this message translates to:
  /// **'Watching delay'**
  String get watchDelayTitle;

  /// No description provided for @watchDelayInfo.
  ///
  /// In en, this message translates to:
  /// **'Other people can watch the top games live. In paid tournaments their view is a few seconds late, so nobody can pass the best move to a player.'**
  String get watchDelayInfo;

  /// No description provided for @seconds.
  ///
  /// In en, this message translates to:
  /// **'{n} s'**
  String seconds(int n);

  /// No description provided for @moreProblems.
  ///
  /// In en, this message translates to:
  /// **'{first}  (+{n} more)'**
  String moreProblems(String first, int n);

  /// No description provided for @youPayNow.
  ///
  /// In en, this message translates to:
  /// **'You pay now'**
  String get youPayNow;

  /// No description provided for @lockAndCreate.
  ///
  /// In en, this message translates to:
  /// **'Lock prize pool and create'**
  String get lockAndCreate;

  /// No description provided for @confirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Lock the prize pool and create?'**
  String get confirmTitle;

  /// No description provided for @confirmPay.
  ///
  /// In en, this message translates to:
  /// **'You pay {total} now:'**
  String confirmPay(String total);

  /// No description provided for @confirmPool.
  ///
  /// In en, this message translates to:
  /// **'Prize pool (locked): {amount}'**
  String confirmPool(String amount);

  /// No description provided for @confirmFee.
  ///
  /// In en, this message translates to:
  /// **'Creation fee: {amount}'**
  String confirmFee(String amount);

  /// No description provided for @confirmSponsor.
  ///
  /// In en, this message translates to:
  /// **'Sponsor look: {amount}'**
  String confirmSponsor(String amount);

  /// No description provided for @confirmRules.
  ///
  /// In en, this message translates to:
  /// **'If the tournament is cancelled before it starts, every player gets their entry fee back and your prize pool returns to you. Once it starts, the prize pool stays locked until the winners are paid.'**
  String get confirmRules;

  /// No description provided for @demoNoMoney.
  ///
  /// In en, this message translates to:
  /// **'Demo: no real money moves yet.'**
  String get demoNoMoney;

  /// No description provided for @p_nameShort.
  ///
  /// In en, this message translates to:
  /// **'Give the tournament a name (3+ letters).'**
  String get p_nameShort;

  /// No description provided for @p_clockRange.
  ///
  /// In en, this message translates to:
  /// **'The clock is outside the {type} range.'**
  String p_clockRange(String type);

  /// No description provided for @p_lengthRange.
  ///
  /// In en, this message translates to:
  /// **'Length must be between 30 minutes and 4 hours.'**
  String get p_lengthRange;

  /// No description provided for @p_startSoon.
  ///
  /// In en, this message translates to:
  /// **'Start at least 30 minutes from now.'**
  String get p_startSoon;

  /// No description provided for @p_sponsoredStartSoon.
  ///
  /// In en, this message translates to:
  /// **'Sponsored tournaments must start at least 6 hours from now, so the artwork can be checked.'**
  String get p_sponsoredStartSoon;

  /// No description provided for @p_swissFew.
  ///
  /// In en, this message translates to:
  /// **'Only {n} Swiss rounds fit. Make it longer or the clock faster.'**
  String p_swissFew(int n);

  /// No description provided for @p_swissTooMany.
  ///
  /// In en, this message translates to:
  /// **'At most {n} rounds fit in this time.'**
  String p_swissTooMany(int n);

  /// No description provided for @p_arenaTooSlow.
  ///
  /// In en, this message translates to:
  /// **'This clock is too slow for this time window. Make the tournament longer or the clock faster.'**
  String get p_arenaTooSlow;

  /// No description provided for @p_minPlayers.
  ///
  /// In en, this message translates to:
  /// **'At least 2 players are needed.'**
  String get p_minPlayers;

  /// No description provided for @p_maxBelowMin.
  ///
  /// In en, this message translates to:
  /// **'Maximum players must be at least the minimum.'**
  String get p_maxBelowMin;

  /// No description provided for @p_poolTooSmall.
  ///
  /// In en, this message translates to:
  /// **'The prize pool must be at least {amount}.'**
  String p_poolTooSmall(String amount);

  /// No description provided for @p_prizesNeedPlayers.
  ///
  /// In en, this message translates to:
  /// **'{n} prizes need at least {n} players.'**
  String p_prizesNeedPlayers(int n);

  /// No description provided for @p_boardUnclear.
  ///
  /// In en, this message translates to:
  /// **'This board and piece pair is not clear enough. Pick another pair.'**
  String get p_boardUnclear;

  /// No description provided for @p_sponsorName.
  ///
  /// In en, this message translates to:
  /// **'Enter the sponsor name.'**
  String get p_sponsorName;

  /// No description provided for @p_sponsor2Name.
  ///
  /// In en, this message translates to:
  /// **'Enter the second sponsor name.'**
  String get p_sponsor2Name;

  /// No description provided for @p_whiteLabel.
  ///
  /// In en, this message translates to:
  /// **'White pieces: {problem}'**
  String p_whiteLabel(String problem);

  /// No description provided for @p_blackLabel.
  ///
  /// In en, this message translates to:
  /// **'Black pieces: {problem}'**
  String p_blackLabel(String problem);

  /// No description provided for @lbl_empty.
  ///
  /// In en, this message translates to:
  /// **'Type a short name (up to {n} letters).'**
  String lbl_empty(int n);

  /// No description provided for @lbl_tooLong.
  ///
  /// In en, this message translates to:
  /// **'Too long: at most {n} letters so the king crown stays visible.'**
  String lbl_tooLong(int n);

  /// No description provided for @lbl_unreadable.
  ///
  /// In en, this message translates to:
  /// **'This name would be hard to read on these pieces. Pick other pieces.'**
  String get lbl_unreadable;

  /// No description provided for @e_svg.
  ///
  /// In en, this message translates to:
  /// **'SVG files will be accepted once the server can convert them safely. For now please use PNG or JPG.'**
  String get e_svg;

  /// No description provided for @e_type.
  ///
  /// In en, this message translates to:
  /// **'Please use a PNG, JPG or WebP picture.'**
  String get e_type;

  /// No description provided for @e_big.
  ///
  /// In en, this message translates to:
  /// **'The picture is too big. Keep it under 2 MB.'**
  String get e_big;

  /// No description provided for @e_empty.
  ///
  /// In en, this message translates to:
  /// **'The file is empty.'**
  String get e_empty;

  /// No description provided for @e_https.
  ///
  /// In en, this message translates to:
  /// **'Use a full link that starts with https://'**
  String get e_https;

  /// No description provided for @e_link.
  ///
  /// In en, this message translates to:
  /// **'Could not load that link. Some websites block other apps from using their pictures. Download the picture and use Upload instead.'**
  String get e_link;

  /// No description provided for @e_http.
  ///
  /// In en, this message translates to:
  /// **'The website answered with an error ({code}).'**
  String e_http(String code);

  /// No description provided for @e_webpage.
  ///
  /// In en, this message translates to:
  /// **'That link is a web page, not a picture. Open the picture itself and copy its address.'**
  String get e_webpage;

  /// No description provided for @e_notPicture.
  ///
  /// In en, this message translates to:
  /// **'This file is not a picture we can read.'**
  String get e_notPicture;

  /// No description provided for @joinForFree.
  ///
  /// In en, this message translates to:
  /// **'Join for free'**
  String get joinForFree;

  /// No description provided for @joinFor.
  ///
  /// In en, this message translates to:
  /// **'Join for {price}'**
  String joinFor(String price);

  /// No description provided for @joinForFreeQ.
  ///
  /// In en, this message translates to:
  /// **'Join for free?'**
  String get joinForFreeQ;

  /// No description provided for @joinForQ.
  ///
  /// In en, this message translates to:
  /// **'Join for {price}?'**
  String joinForQ(String price);

  /// No description provided for @refundNote.
  ///
  /// In en, this message translates to:
  /// **'If the tournament is cancelled before it starts, you get your entry fee back.'**
  String get refundNote;

  /// No description provided for @created.
  ///
  /// In en, this message translates to:
  /// **'Tournament created. Share the link below so people can join.'**
  String get created;

  /// No description provided for @logoPending.
  ///
  /// In en, this message translates to:
  /// **'Logo waiting for safety check: only you can see it'**
  String get logoPending;

  /// No description provided for @fromTo.
  ///
  /// In en, this message translates to:
  /// **'{start} to {end}  ({d})'**
  String fromTo(String start, String end, String d);

  /// No description provided for @youreIn.
  ///
  /// In en, this message translates to:
  /// **'You\'re in'**
  String get youreIn;

  /// No description provided for @invitePeople.
  ///
  /// In en, this message translates to:
  /// **'Invite people'**
  String get invitePeople;

  /// No description provided for @shareLinkTitle.
  ///
  /// In en, this message translates to:
  /// **'Share link'**
  String get shareLinkTitle;

  /// No description provided for @shareLinkInfo.
  ///
  /// In en, this message translates to:
  /// **'Send this link on WhatsApp or anywhere. People who already have the app open this tournament. New people are asked to sign up first, then join.\n\nThe link starts working when online play is live.'**
  String get shareLinkInfo;

  /// No description provided for @copyLink.
  ///
  /// In en, this message translates to:
  /// **'Copy link'**
  String get copyLink;

  /// No description provided for @linkCopied.
  ///
  /// In en, this message translates to:
  /// **'Link copied'**
  String get linkCopied;

  /// No description provided for @prizes.
  ///
  /// In en, this message translates to:
  /// **'Prizes'**
  String get prizes;

  /// No description provided for @joinedCount.
  ///
  /// In en, this message translates to:
  /// **'{n} joined (min {min}, max {max})'**
  String joinedCount(int n, int min, int max);

  /// No description provided for @howItWorks.
  ///
  /// In en, this message translates to:
  /// **'How it works'**
  String get howItWorks;

  /// No description provided for @pointsTitle.
  ///
  /// In en, this message translates to:
  /// **'Points and ties'**
  String get pointsTitle;

  /// No description provided for @pointsInfo.
  ///
  /// In en, this message translates to:
  /// **'Win 3 points, draw 1, loss 0. If players have the same points, more wins ranks higher, then the head-to-head result, then the strength of opponents, then fewer games, then who reached the score first. So there is always only one first place.'**
  String get pointsInfo;

  /// No description provided for @arenaShort.
  ///
  /// In en, this message translates to:
  /// **'Arena: join any time. Play as many games as you can. Most points when the clock ends wins.'**
  String get arenaShort;

  /// No description provided for @swissShort.
  ///
  /// In en, this message translates to:
  /// **'Swiss: {n} rounds. Each round you meet someone with a similar score. Join before round 1.'**
  String swissShort(int n);

  /// No description provided for @pointsLine.
  ///
  /// In en, this message translates to:
  /// **'Win = 3 points · Draw = 1 · Loss = 0'**
  String get pointsLine;

  /// No description provided for @voiceOn.
  ///
  /// In en, this message translates to:
  /// **'Voice chat is allowed (opt-in for both players).'**
  String get voiceOn;

  /// No description provided for @voiceOff.
  ///
  /// In en, this message translates to:
  /// **'Voice chat is off in this tournament.'**
  String get voiceOff;

  /// No description provided for @watchNoDelay.
  ///
  /// In en, this message translates to:
  /// **'Live watching: no delay.'**
  String get watchNoDelay;

  /// No description provided for @watchDelayed.
  ///
  /// In en, this message translates to:
  /// **'Live watching is {n} seconds late.'**
  String watchDelayed(int n);

  /// No description provided for @boardYouPlay.
  ///
  /// In en, this message translates to:
  /// **'The board you will play on'**
  String get boardYouPlay;

  /// No description provided for @sameBoardTitle.
  ///
  /// In en, this message translates to:
  /// **'Same board for everyone'**
  String get sameBoardTitle;

  /// No description provided for @sameBoardInfo.
  ///
  /// In en, this message translates to:
  /// **'Everyone in this tournament sees this board and these pieces, so the game is always clear. Your own board choice returns when you leave.'**
  String get sameBoardInfo;

  /// No description provided for @yourMoney.
  ///
  /// In en, this message translates to:
  /// **'Your money (host)'**
  String get yourMoney;

  /// No description provided for @feesSoFar.
  ///
  /// In en, this message translates to:
  /// **'Entry fees so far'**
  String get feesSoFar;

  /// No description provided for @poolLocked.
  ///
  /// In en, this message translates to:
  /// **'Prize pool locked'**
  String get poolLocked;

  /// No description provided for @youWouldEnd.
  ///
  /// In en, this message translates to:
  /// **'You would end with'**
  String get youWouldEnd;

  /// No description provided for @quickEasy.
  ///
  /// In en, this message translates to:
  /// **'Easy'**
  String get quickEasy;

  /// No description provided for @quickMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get quickMedium;

  /// No description provided for @quickHard.
  ///
  /// In en, this message translates to:
  /// **'Hard'**
  String get quickHard;

  /// No description provided for @twoPlayersSub.
  ///
  /// In en, this message translates to:
  /// **'one device'**
  String get twoPlayersSub;

  /// No description provided for @customTile.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get customTile;

  /// No description provided for @customSub.
  ///
  /// In en, this message translates to:
  /// **'your choices'**
  String get customSub;

  /// No description provided for @customTitle.
  ///
  /// In en, this message translates to:
  /// **'Custom game'**
  String get customTitle;

  /// No description provided for @chooseVariant.
  ///
  /// In en, this message translates to:
  /// **'Choose a game'**
  String get chooseVariant;

  /// No description provided for @nextTournament.
  ///
  /// In en, this message translates to:
  /// **'Next tournament'**
  String get nextTournament;

  /// No description provided for @noClock.
  ///
  /// In en, this message translates to:
  /// **'No clock'**
  String get noClock;

  /// No description provided for @reasonTimeout.
  ///
  /// In en, this message translates to:
  /// **'time ran out'**
  String get reasonTimeout;

  /// No description provided for @newGame.
  ///
  /// In en, this message translates to:
  /// **'New game'**
  String get newGame;

  /// No description provided for @sounds.
  ///
  /// In en, this message translates to:
  /// **'Sounds and vibration'**
  String get sounds;

  /// No description provided for @soundsSub.
  ///
  /// In en, this message translates to:
  /// **'Moves, captures, kings, low time and game end'**
  String get soundsSub;

  /// No description provided for @prevMove.
  ///
  /// In en, this message translates to:
  /// **'Previous move'**
  String get prevMove;

  /// No description provided for @nextMove.
  ///
  /// In en, this message translates to:
  /// **'Next move'**
  String get nextMove;

  /// No description provided for @backToGame.
  ///
  /// In en, this message translates to:
  /// **'Back to the game'**
  String get backToGame;
}

class _LDelegate extends LocalizationsDelegate<L> {
  const _LDelegate();

  @override
  Future<L> load(Locale locale) {
    return SynchronousFuture<L>(lookupL(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'en',
    'es',
    'fr',
    'lg',
    'pt',
    'sw',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_LDelegate old) => false;
}

L lookupL(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return LAr();
    case 'en':
      return LEn();
    case 'es':
      return LEs();
    case 'fr':
      return LFr();
    case 'lg':
      return LLg();
    case 'pt':
      return LPt();
    case 'sw':
      return LSw();
  }

  throw FlutterError(
    'L.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
