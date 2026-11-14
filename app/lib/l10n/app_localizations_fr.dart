// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class LFr extends L {
  LFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Licheckers';

  @override
  String get navPlay => 'Jouer';

  @override
  String get navTournaments => 'Tournois';

  @override
  String get navLearn => 'Apprendre';

  @override
  String get navSettings => 'Réglages';

  @override
  String get infoTooltip => 'Qu\'est-ce que c\'est ?';

  @override
  String get gotIt => 'Compris';

  @override
  String get cancel => 'Annuler';

  @override
  String get back => 'Retour';

  @override
  String get create => 'Créer';

  @override
  String get add => 'Ajouter';

  @override
  String get remove => 'Retirer';

  @override
  String get join => 'Rejoindre';

  @override
  String get white => 'Blancs';

  @override
  String get black => 'Noirs';

  @override
  String get you => 'Vous';

  @override
  String get free => 'Gratuit';

  @override
  String get none => 'Aucun';

  @override
  String get all => 'Tous';

  @override
  String get variant_english => 'Anglaises (américaines)';

  @override
  String get variant_international => 'Internationales';

  @override
  String get variant_brazilian => 'Brésiliennes';

  @override
  String get variant_russian => 'Russes';

  @override
  String get variant_italian => 'Italiennes';

  @override
  String get variant_spanish => 'Espagnoles';

  @override
  String get variant_turkish => 'Turques (Dama)';

  @override
  String get variant_frisian => 'Frisonnes';

  @override
  String get variant_canadian => 'Canadiennes';

  @override
  String get tagFlyingKings => 'dames volantes';

  @override
  String get tagShortKings => 'dames courtes';

  @override
  String get tagStraightMoves => 'coups en ligne droite';

  @override
  String get tagCaptures8 => 'prises dans 8 directions';

  @override
  String get tagMenNoKings => 'les pions ne prennent pas les dames';

  @override
  String get tagFreeChoice => 'prise au choix';

  @override
  String get tagMenForward => 'les pions prennent seulement vers l\'avant';

  @override
  String get tagMustTakeMost => 'prise du plus grand nombre obligatoire';

  @override
  String get howToPlay => 'Comment jouer';

  @override
  String ruleBoardDiag(int size, int count) {
    return 'Damier : ${size}x$size. Chaque joueur commence avec $count pions sur les cases foncées.';
  }

  @override
  String ruleBoardAll(int size, int count) {
    return 'Damier : ${size}x$size. Chaque joueur commence avec $count pions, et toutes les cases sont utilisées.';
  }

  @override
  String get ruleWhiteFirst => 'Les Blancs jouent en premier.';

  @override
  String get ruleBlackFirst => 'Les Noirs jouent en premier.';

  @override
  String get ruleMenMoveDiag => 'Les pions avancent d\'une case en diagonale.';

  @override
  String get ruleMenMoveStraight =>
      'Les pions avancent d\'une case tout droit ou sur le côté.';

  @override
  String get ruleMenCapture8 =>
      'Les pions prennent dans les 8 directions : en diagonale et en ligne droite.';

  @override
  String get ruleMenCaptureStraight =>
      'Les pions prennent en sautant tout droit vers l\'avant ou sur le côté.';

  @override
  String get ruleMenCaptureBoth =>
      'Les pions prennent vers l\'avant et vers l\'arrière.';

  @override
  String get ruleMenCaptureForward =>
      'Les pions prennent seulement vers l\'avant.';

  @override
  String get ruleMenNoKings => 'Un pion n\'a pas le droit de prendre une dame.';

  @override
  String get ruleKingsFlyDiag =>
      'Les dames volent : elles glissent d\'autant de cases vides qu\'elles veulent en diagonale et peuvent prendre de loin.';

  @override
  String get ruleKingsFlyStraight =>
      'Les dames volent : elles glissent d\'autant de cases vides qu\'elles veulent en ligne droite et peuvent prendre de loin.';

  @override
  String get ruleKingsShort =>
      'Les dames avancent d\'une case dans n\'importe quelle diagonale.';

  @override
  String get ruleMustCapture =>
      'Si vous pouvez prendre, vous devez prendre. Une rafle doit être terminée.';

  @override
  String get rulePriorityNone =>
      'Si plusieurs prises sont possibles, vous choisissez laquelle.';

  @override
  String get rulePriorityMax =>
      'Vous devez choisir la prise qui enlève le plus de pièces.';

  @override
  String get rulePrioritySpanish =>
      'Vous devez prendre le plus de pièces. À égalité, la prise avec le plus de dames.';

  @override
  String get rulePriorityItalian =>
      'Vous devez prendre le plus de pièces. À égalité : prendre avec une dame, puis prendre le plus de dames, puis la rafle qui rencontre une dame en premier.';

  @override
  String get rulePriorityFrisian =>
      'Vous devez prendre la plus grande valeur (une dame vaut un peu moins que deux pions). À égalité, c\'est une dame qui doit prendre.';

  @override
  String get ruleRemoveAsJumped =>
      'Une pièce prise quitte le damier dès qu\'elle est sautée.';

  @override
  String get ruleRemoveAfter =>
      'Les pièces prises sont enlevées ensemble après le coup. Jusque-là, elles bloquent le passage et ne peuvent pas être sautées deux fois.';

  @override
  String get ruleNoTurnBack =>
      'Pendant une prise, vous ne pouvez pas faire demi-tour.';

  @override
  String get rulePromoStop =>
      'Un pion qui atteint la dernière rangée devient dame et le coup s\'arrête.';

  @override
  String get rulePromoAsMan =>
      'Un pion devient dame seulement si son coup SE TERMINE sur la dernière rangée. S\'il ne fait qu\'y passer pendant une prise, il reste pion.';

  @override
  String get rulePromoAsKing =>
      'Un pion qui atteint la dernière rangée pendant une prise devient dame tout de suite et continue de prendre comme une dame.';

  @override
  String ruleKingLimit(int n) {
    return 'La même dame ne peut faire que $n coups sans prise d\'affilée tant qu\'il vous reste des pions.';
  }

  @override
  String get ruleLose =>
      'Vous perdez si vous n\'avez plus de pièces ou plus de coup possible.';

  @override
  String ruleDraw(int n) {
    return 'Nulle : la même position trois fois, ou $n coups chacun sans prise ni mouvement de pion.';
  }

  @override
  String get sectionGame => 'Partie';

  @override
  String get variantsInfoTitle => 'Variantes';

  @override
  String get variantsInfoText =>
      'Les dames se jouent avec des règles différentes à travers le monde. Choisissez-en une ici. Ouvrez Apprendre pour lire les règles de chaque jeu.';

  @override
  String get opponent => 'Adversaire';

  @override
  String get computer => 'Ordinateur';

  @override
  String get twoPlayers => 'Deux joueurs';

  @override
  String get botLevelsTitle => 'Niveaux des robots';

  @override
  String get botLevelsText =>
      'Il y a 18 joueurs ordinateur. Le niveau 1 joue presque au hasard. Les niveaux plus élevés calculent plus loin et font moins d\'erreurs. Les meilleurs niveaux réfléchissent quelques secondes.';

  @override
  String levelN(int n) {
    return 'Niveau $n';
  }

  @override
  String get passDevice => 'Passez l\'appareil après chaque coup.';

  @override
  String get yourColour => 'Votre couleur';

  @override
  String get startGame => 'Commencer la partie';

  @override
  String get bot1 => 'Joue surtout au hasard et adore donner ses pièces.';

  @override
  String get bot2 => 'Ici pour s\'amuser. Tombe souvent dans vos prises.';

  @override
  String get bot3 => 'Apprend les bases. Sait que prendre, c\'est bien.';

  @override
  String get bot4 => 'Le joueur moyen du parc. Solide mais prévisible.';

  @override
  String get bot5 =>
      'Commence à chercher les doubles prises et le contrôle du centre.';

  @override
  String get bot6 => 'Très prudent. Préfère garder ses pièces au fond.';

  @override
  String get bot7 => 'Attaque sans arrêt. Aime forcer les échanges.';

  @override
  String get bot8 => 'Un habitué du club de dames du quartier.';

  @override
  String get bot9 => 'Étudie la théorie. Très efficace en fin de partie.';

  @override
  String get bot10 => 'Champion régional. Très peu d\'erreurs.';

  @override
  String get bot11 => 'Grande vision tactique. Piégera facilement votre dame.';

  @override
  String get bot12 => 'Voit loin. Contrôle le rythme du jeu.';

  @override
  String get bot13 =>
      'Force de niveau national. Incroyablement difficile à battre.';

  @override
  String get bot14 => 'Placement de niveau mondial. Chaque coup a un but.';

  @override
  String get bot15 => 'Reconnaît les motifs comme une machine. Inflexible.';

  @override
  String get bot16 => 'Un monstre. Punit la moindre imprécision.';

  @override
  String get bot17 => 'Calcul de niveau superordinateur.';

  @override
  String get bot18 =>
      'Le robot le plus fort : il réfléchit aussi loin que le temps le permet.';

  @override
  String get noGame => 'Aucune partie';

  @override
  String get moves => 'Coups';

  @override
  String get mustCapture => 'Vous devez prendre';

  @override
  String isThinking(String name) {
    return '$name réfléchit…';
  }

  @override
  String toMove(String name) {
    return 'Au tour de $name';
  }

  @override
  String drawBecause(String reason) {
    return 'Nulle · $reason';
  }

  @override
  String wonBecause(String name, String reason) {
    return '$name gagne · $reason';
  }

  @override
  String get reasonResign => 'abandon';

  @override
  String get reasonNoMoves => 'plus de coup possible';

  @override
  String get reasonRepetition => 'même position trois fois';

  @override
  String reasonNoProgress(int n) {
    return '$n coups chacun sans progrès';
  }

  @override
  String get undo => 'Annuler le coup';

  @override
  String get playAgain => 'Rejouer';

  @override
  String get resign => 'Abandonner';

  @override
  String get resignQ => 'Abandonner cette partie ?';

  @override
  String get resignBody => 'Votre adversaire gagne.';

  @override
  String get keepPlaying => 'Continuer';

  @override
  String get noMovesYet => 'Aucun coup pour l\'instant';

  @override
  String get language => 'Langue';

  @override
  String get languagePhone => 'Langue du téléphone';

  @override
  String get translationNote =>
      'Les traductions sont nouvelles. Certains mots doivent encore être vérifiés par un locuteur natif.';

  @override
  String get display => 'Affichage';

  @override
  String get themeSystem => 'Système';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeDark => 'Sombre';

  @override
  String get textSize => 'Taille du texte';

  @override
  String get showInfo => 'Afficher les boutons d\'info';

  @override
  String get showInfoSub => 'Les petits boutons (i) qui expliquent les choses';

  @override
  String get boardAndPieces => 'Damier et pièces';

  @override
  String get yourLookTitle => 'Seulement votre écran';

  @override
  String get yourLookText =>
      'Ces choix changent seulement votre écran. En ligne, votre adversaire garde son propre damier et ses pièces.';

  @override
  String get board => 'Damier';

  @override
  String get pieces => 'Pièces';

  @override
  String get squareNumbers => 'Numéros des cases';

  @override
  String get showLegal => 'Afficher les coups possibles';

  @override
  String get showLegalSub =>
      'Des points là où une pièce peut aller, et un anneau sur les pièces qui doivent prendre';

  @override
  String get pieceAnimation => 'Animation des pièces';

  @override
  String get animOff => 'Non';

  @override
  String get animFast => 'Rapide';

  @override
  String get animNormal => 'Normale';

  @override
  String get animSlow => 'Lente';

  @override
  String get rulesOfVariants => 'Règles de chaque variante';

  @override
  String get rulesOfVariantsSub => 'Comment se joue chacun des 9 jeux';

  @override
  String get installApp => 'Installer l\'appli';

  @override
  String get installAppSub =>
      'Mettez Licheckers sur votre écran d\'accueil. Fonctionne hors ligne.';

  @override
  String get board_walnut => 'Noyer';

  @override
  String get board_forest => 'Forêt';

  @override
  String get board_ocean => 'Océan';

  @override
  String get board_midnight => 'Minuit';

  @override
  String get board_sunset => 'Couchant';

  @override
  String get board_clear_green => 'Vert net';

  @override
  String get board_clear_brown => 'Brun net';

  @override
  String get board_clear_blue => 'Bleu net';

  @override
  String get board_clear_red => 'Rouge net';

  @override
  String get board_contrast => 'Contraste élevé';

  @override
  String get piece_classic => 'Classiques';

  @override
  String get piece_wood => 'Bois';

  @override
  String get piece_glass => 'Verre';

  @override
  String get piece_ruby => 'Ivoire et rubis';

  @override
  String get piece_flat => 'Plates';

  @override
  String get installTitle => 'Installer Licheckers';

  @override
  String get installBody =>
      'Plus rapide à ouvrir, fonctionne hors ligne, sans magasin d\'applications.';

  @override
  String get installNow => 'Installer';

  @override
  String get notNow => 'Plus tard';

  @override
  String get installIosTitle => 'Ajouter à l\'écran d\'accueil';

  @override
  String get installIosBody =>
      'Dans Safari, touchez le bouton Partager, puis « Sur l\'écran d\'accueil ».';

  @override
  String get installDone => 'Licheckers est installé.';

  @override
  String get clock_bullet => 'Bullet';

  @override
  String get clock_blitz => 'Blitz';

  @override
  String get clock_rapid => 'Rapide';

  @override
  String get clock_classic => 'Classique';

  @override
  String startsIn(String time) {
    return 'Commence dans $time';
  }

  @override
  String liveEndsIn(String time) {
    return 'En cours : finit dans $time';
  }

  @override
  String get finished => 'Terminé';

  @override
  String leftHM(int h, int m) {
    return '$h h $m min';
  }

  @override
  String leftMS(int m, int s) {
    return '$m min $s s';
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
    String _temp0 = intl.Intl.selectLogic(n, {'1': '1er', 'other': '${n}e'});
    return '$_temp0';
  }

  @override
  String get arena => 'Arène';

  @override
  String get swiss => 'Suisse';

  @override
  String get createTournament => 'Créer un tournoi';

  @override
  String get demoNote =>
      'Démo : tournois d\'exemple et pas encore d\'argent réel. Le jeu en ligne et les paiements arriveront avec le serveur.';

  @override
  String get clockTypesTitle => 'Types de pendule';

  @override
  String get clockTypesText =>
      'Bullet : 1 à 2 minutes chacun, très rapide.\nBlitz : 3 à 5 minutes chacun.\nRapide : 10 à 15 minutes chacun.\nClassique : 20 à 30 minutes chacun.\n\nUn deuxième nombre comme 3+2 veut dire que 2 secondes sont ajoutées après chaque coup.';

  @override
  String get noTournamentsOfType => 'Pas encore de tournoi de ce type.';

  @override
  String get yours => 'À vous';

  @override
  String get joinedTag => 'Inscrit';

  @override
  String presentedBy(String names) {
    return 'Présenté par $names';
  }

  @override
  String hostedBy(String host) {
    return 'Organisé par $host';
  }

  @override
  String get entry => 'Inscription';

  @override
  String get prizePool => 'Cagnotte';

  @override
  String get players => 'Joueurs';

  @override
  String get createTitle => 'Créer un tournoi';

  @override
  String get secAbout => '1. Présentation';

  @override
  String get tournamentName => 'Nom du tournoi';

  @override
  String get secFormat => '2. Format';

  @override
  String get arenaInfo =>
      'Rejoignez quand vous voulez avant la fin. Jouez autant de parties que possible. Une victoire vaut 3 points, une nulle 1, une défaite 0. Le plus de points à la fin gagne.\n\nIdéal pour les grandes foules, car on peut arriver en retard.';

  @override
  String get swissInfo =>
      'Un nombre fixe de rondes. À chaque ronde, vous jouez contre quelqu\'un qui a un score proche. Tout le monde joue chaque ronde. Le plus de points après la dernière ronde gagne.\n\nIdéal pour les petits tournois sérieux (jusqu\'à environ 200 joueurs). On ne peut s\'inscrire qu\'avant la ronde 1.';

  @override
  String get notEnoughRounds =>
      'Pas assez de temps pour 3 rondes. Allongez le tournoi ou accélérez la pendule.';

  @override
  String roundsFit(int n, int max) {
    return 'Rondes : $n (jusqu\'à $max possibles)';
  }

  @override
  String get secClock => '3. Pendule';

  @override
  String get clockTitle => 'Pendule';

  @override
  String get clockInfo =>
      'Chaque partie de tournoi a une pendule, pour qu\'un joueur lent ne bloque pas tout le tournoi. Le deuxième nombre est le temps ajouté après chaque coup.';

  @override
  String minutesPerPlayer(int n) {
    return 'Minutes par joueur : $n';
  }

  @override
  String secondsAdded(int n) {
    return 'Secondes ajoutées après chaque coup : $n';
  }

  @override
  String longGame(String clock, int n) {
    return '$clock. Une longue partie dure environ $n minutes.';
  }

  @override
  String get secWhen => '4. Quand';

  @override
  String get whenTitle => 'Début et durée';

  @override
  String get whenInfo =>
      'Les tournois sont courts exprès : de 30 minutes à 4 heures. Les joueurs voient un compte à rebours jusqu\'au début, puis jusqu\'à la fin. Aucune nouvelle partie n\'est lancée dans les dernières minutes ; les parties en cours peuvent finir.';

  @override
  String get in1h => 'Dans 1 heure';

  @override
  String get in3h => 'Dans 3 heures';

  @override
  String get in8h => 'Dans 8 heures';

  @override
  String get pickDateTime => 'Choisir la date et l\'heure';

  @override
  String startsAt(String time) {
    return 'Début : $time';
  }

  @override
  String lengthIs(String d) {
    return 'Durée : $d';
  }

  @override
  String endsAt(String time) {
    return 'Fin : $time';
  }

  @override
  String roundsFitIn(int n, String d) {
    return 'Environ $n rondes tiennent en $d.';
  }

  @override
  String get secMoney => '5. Joueurs et argent';

  @override
  String get moneyTitle => 'Comment fonctionne l\'argent';

  @override
  String moneyInfo(int pct) {
    return 'Vous bloquez toute la cagnotte en créant le tournoi. Les joueurs paient l\'inscription pour participer. Les gagnants sont payés avec votre cagnotte bloquée. Les inscriptions sont à vous. La plateforme prend $pct % de votre bénéfice seulement (inscriptions moins cagnotte). Si les inscriptions ne couvrent pas la cagnotte, la plateforme ne prend rien.\n\nSi le tournoi est annulé avant de commencer, tout le monde est remboursé. Une fois commencé, l\'argent est bloqué.';
  }

  @override
  String get minPlayers => 'Joueurs min';

  @override
  String get maxPlayers => 'Joueurs max';

  @override
  String get entryFee => 'Inscription';

  @override
  String get winnerSplit => 'Partage des prix';

  @override
  String get winnerSplitInfo =>
      'Comment la cagnotte est partagée entre les premières places. Les restes d\'arrondi vont à la première place.';

  @override
  String get split_winner => 'Tout au gagnant';

  @override
  String get split_top3 => 'Top 3';

  @override
  String get split_top5 => 'Top 5';

  @override
  String get whatIf => 'Et si ce nombre de joueurs s\'inscrit ?';

  @override
  String get whatIfTitle => 'Votre argent, calculé';

  @override
  String get whatIfInfo =>
      'Déplacez le curseur pour voir ce que vous gagneriez. La part de la plateforme est prise seulement sur votre bénéfice.';

  @override
  String get feesCollected => 'Inscriptions reçues';

  @override
  String get poolYouLocked => 'Cagnotte bloquée';

  @override
  String platformShare(int pct) {
    return 'Part de la plateforme ($pct % du bénéfice)';
  }

  @override
  String get youEndWith => 'Il vous reste';

  @override
  String breakEven(int n) {
    return 'Vous êtes à l\'équilibre à $n joueurs. En dessous, vous perdez une partie de la cagnotte.';
  }

  @override
  String get secBoard => '6. Damier et pièces';

  @override
  String get whyOnlyThese => 'Pourquoi seulement ceux-ci ?';

  @override
  String get whyOnlyTheseInfo =>
      'Tout le monde dans le tournoi joue sur le même damier, pour que chacun voie toujours bien les cases et les pièces. Seuls les damiers et pièces qui réussissent nos tests de lisibilité sont proposés. Les sponsors ne peuvent jamais changer le damier.';

  @override
  String piecesNamed(String name) {
    return 'Pièces $name';
  }

  @override
  String get check_whiteOnDark =>
      'Les pièces blanches se voient bien sur les cases foncées';

  @override
  String get check_blackOnDark =>
      'Les pièces noires se voient bien sur les cases foncées';

  @override
  String get check_sidesApart =>
      'Les pièces blanches et noires se distinguent facilement';

  @override
  String get check_squaresApart =>
      'Les cases claires et foncées se distinguent facilement';

  @override
  String checkLine(String label, String value, String need) {
    return '$label ($value : 1, minimum $need)';
  }

  @override
  String get secSponsor => '7. Sponsor (facultatif)';

  @override
  String get sponsoredTitle => 'Tournois sponsorisés';

  @override
  String sponsoredInfo(String theme, String pieces) {
    return 'Un sponsor change l\'apparence de l\'appli pour ce tournoi seulement : couleurs, logo et bandeau avec son nom, et en option son nom sur les pièces. Les cases du damier ne changent jamais. Il n\'y a jamais de pop-up, de vidéo ni de son, et rien ne cache le damier ou les pendules. Quand un joueur quitte le tournoi, l\'appli redevient normale.\n\nPrix : $theme par sponsor, plus $pieces par sponsor pour mettre son nom sur les pièces. Les images sont vérifiées d\'abord, donc un tournoi sponsorisé doit commencer au moins 6 heures plus tard.';
  }

  @override
  String get noSponsor => 'Pas de sponsor';

  @override
  String get oneSponsor => 'Un sponsor';

  @override
  String get twoSponsors => 'Deux sponsors (moitié chacun)';

  @override
  String get sponsorName => 'Nom du sponsor';

  @override
  String get sponsor1Name => 'Nom du sponsor 1 (côté blanc)';

  @override
  String get sponsor2Name => 'Nom du sponsor 2 (côté noir)';

  @override
  String get sponsor => 'Sponsor';

  @override
  String get sponsor1 => 'Sponsor 1';

  @override
  String get sponsor2 => 'Sponsor 2';

  @override
  String nameOnPieces(String price) {
    return 'Nom sur les pièces (+$price)';
  }

  @override
  String nameOnWhite(String price) {
    return 'Nom sur les pièces blanches (+$price)';
  }

  @override
  String nameOnBlack(String price) {
    return 'Nom sur les pièces noires (+$price)';
  }

  @override
  String upToLetters(int n) {
    return 'Jusqu\'à $n lettres, lisibilité vérifiée';
  }

  @override
  String sponsorTotal(String price) {
    return 'Total sponsor : $price';
  }

  @override
  String get logoRules =>
      'Logos : PNG, JPG ou WebP, moins de 2 Mo. Chaque logo est vérifié par une personne (pas de contenu adulte, pas de fausses marques) avant que d\'autres joueurs puissent le voir.';

  @override
  String get upload => 'Importer';

  @override
  String get fromLink => 'Depuis un lien';

  @override
  String get logoColour => 'Couleur du logo';

  @override
  String get logoAdded =>
      'La couleur du logo est maintenant celle du tournoi. Le logo attend une vérification par une personne : d\'ici là, vous seul pouvez le voir.';

  @override
  String get linkTitle => 'Ajouter une image depuis un lien';

  @override
  String get linkHelp =>
      'Collez l\'adresse de l\'image elle-même (elle finit souvent par .png ou .jpg). Certains sites empêchent d\'autres applis d\'utiliser leurs images. Dans ce cas, téléchargez l\'image et utilisez Importer.';

  @override
  String somethingWrong(String error) {
    return 'Un problème est survenu : $error';
  }

  @override
  String get secOptions => '8. Options';

  @override
  String get allowVoice => 'Autoriser le chat vocal en partie';

  @override
  String get allowVoiceSub =>
      'Les joueurs choisissent quand même de parler ou non';

  @override
  String get watchDelay => 'Retard de diffusion';

  @override
  String get watchDelayTitle => 'Retard de diffusion';

  @override
  String get watchDelayInfo =>
      'D\'autres personnes peuvent regarder les meilleures parties en direct. Dans les tournois payants, leur vue a quelques secondes de retard, pour que personne ne souffle le meilleur coup à un joueur.';

  @override
  String seconds(int n) {
    return '$n s';
  }

  @override
  String moreProblems(String first, int n) {
    return '$first  (+$n autres)';
  }

  @override
  String get youPayNow => 'À payer maintenant';

  @override
  String get lockAndCreate => 'Bloquer la cagnotte et créer';

  @override
  String get confirmTitle => 'Bloquer la cagnotte et créer ?';

  @override
  String confirmPay(String total) {
    return 'Vous payez $total maintenant :';
  }

  @override
  String confirmPool(String amount) {
    return 'Cagnotte (bloquée) : $amount';
  }

  @override
  String confirmFee(String amount) {
    return 'Frais de création : $amount';
  }

  @override
  String confirmSponsor(String amount) {
    return 'Habillage sponsor : $amount';
  }

  @override
  String get confirmRules =>
      'Si le tournoi est annulé avant de commencer, chaque joueur récupère son inscription et votre cagnotte vous revient. Une fois commencé, la cagnotte reste bloquée jusqu\'au paiement des gagnants.';

  @override
  String get demoNoMoney =>
      'Démo : aucun argent réel ne bouge pour l\'instant.';

  @override
  String get p_nameShort => 'Donnez un nom au tournoi (3 lettres ou plus).';

  @override
  String p_clockRange(String type) {
    return 'La pendule sort de la plage $type.';
  }

  @override
  String get p_lengthRange =>
      'La durée doit être entre 30 minutes et 4 heures.';

  @override
  String get p_startSoon => 'Commencez au moins 30 minutes plus tard.';

  @override
  String get p_sponsoredStartSoon =>
      'Les tournois sponsorisés doivent commencer au moins 6 heures plus tard, pour vérifier les images.';

  @override
  String p_swissFew(int n) {
    return 'Seulement $n rondes suisses tiennent. Allongez le tournoi ou accélérez la pendule.';
  }

  @override
  String p_swissTooMany(int n) {
    return 'Au plus $n rondes tiennent dans ce temps.';
  }

  @override
  String get p_arenaTooSlow =>
      'Cette pendule est trop lente pour cette durée. Allongez le tournoi ou accélérez la pendule.';

  @override
  String get p_minPlayers => 'Il faut au moins 2 joueurs.';

  @override
  String get p_maxBelowMin =>
      'Le maximum de joueurs doit être au moins égal au minimum.';

  @override
  String p_poolTooSmall(String amount) {
    return 'La cagnotte doit être d\'au moins $amount.';
  }

  @override
  String p_prizesNeedPlayers(int n) {
    return '$n prix demandent au moins $n joueurs.';
  }

  @override
  String get p_boardUnclear =>
      'Ce damier et ces pièces ne sont pas assez lisibles. Choisissez une autre paire.';

  @override
  String get p_sponsorName => 'Indiquez le nom du sponsor.';

  @override
  String get p_sponsor2Name => 'Indiquez le nom du deuxième sponsor.';

  @override
  String p_whiteLabel(String problem) {
    return 'Pièces blanches : $problem';
  }

  @override
  String p_blackLabel(String problem) {
    return 'Pièces noires : $problem';
  }

  @override
  String lbl_empty(int n) {
    return 'Tapez un nom court (jusqu\'à $n lettres).';
  }

  @override
  String lbl_tooLong(int n) {
    return 'Trop long : $n lettres au plus pour que la couronne de la dame reste visible.';
  }

  @override
  String get lbl_unreadable =>
      'Ce nom serait difficile à lire sur ces pièces. Choisissez d\'autres pièces.';

  @override
  String get e_svg =>
      'Les fichiers SVG seront acceptés quand le serveur pourra les convertir en toute sécurité. Pour l\'instant, utilisez PNG ou JPG.';

  @override
  String get e_type => 'Utilisez une image PNG, JPG ou WebP.';

  @override
  String get e_big => 'L\'image est trop lourde. Gardez-la sous 2 Mo.';

  @override
  String get e_empty => 'Le fichier est vide.';

  @override
  String get e_https => 'Utilisez un lien complet qui commence par https://';

  @override
  String get e_link =>
      'Impossible de charger ce lien. Certains sites empêchent d\'autres applis d\'utiliser leurs images. Téléchargez l\'image et utilisez Importer.';

  @override
  String e_http(String code) {
    return 'Le site a répondu par une erreur ($code).';
  }

  @override
  String get e_webpage =>
      'Ce lien est une page web, pas une image. Ouvrez l\'image elle-même et copiez son adresse.';

  @override
  String get e_notPicture => 'Ce fichier n\'est pas une image lisible.';

  @override
  String get joinForFree => 'Rejoindre gratuitement';

  @override
  String joinFor(String price) {
    return 'Rejoindre pour $price';
  }

  @override
  String get joinForFreeQ => 'Rejoindre gratuitement ?';

  @override
  String joinForQ(String price) {
    return 'Rejoindre pour $price ?';
  }

  @override
  String get refundNote =>
      'Si le tournoi est annulé avant de commencer, votre inscription vous est remboursée.';

  @override
  String get created =>
      'Tournoi créé. Partagez le lien ci-dessous pour que les gens s\'inscrivent.';

  @override
  String get logoPending =>
      'Logo en attente de vérification : vous seul pouvez le voir';

  @override
  String fromTo(String start, String end, String d) {
    return '$start à $end  ($d)';
  }

  @override
  String get youreIn => 'Vous êtes inscrit';

  @override
  String get invitePeople => 'Inviter des gens';

  @override
  String get shareLinkTitle => 'Lien de partage';

  @override
  String get shareLinkInfo =>
      'Envoyez ce lien sur WhatsApp ou ailleurs. Ceux qui ont déjà l\'appli ouvrent ce tournoi. Les nouveaux doivent d\'abord s\'inscrire, puis rejoindre.\n\nLe lien fonctionnera quand le jeu en ligne sera actif.';

  @override
  String get copyLink => 'Copier le lien';

  @override
  String get linkCopied => 'Lien copié';

  @override
  String get prizes => 'Prix';

  @override
  String joinedCount(int n, int min, int max) {
    return '$n inscrits (min $min, max $max)';
  }

  @override
  String get howItWorks => 'Fonctionnement';

  @override
  String get pointsTitle => 'Points et égalités';

  @override
  String get pointsInfo =>
      'Victoire 3 points, nulle 1, défaite 0. À égalité de points, le plus de victoires passe devant, puis la confrontation directe, puis la force des adversaires, puis le moins de parties, puis celui qui a atteint le score en premier. Il n\'y a donc toujours qu\'une seule première place.';

  @override
  String get arenaShort =>
      'Arène : rejoignez quand vous voulez. Jouez autant de parties que possible. Le plus de points à la fin gagne.';

  @override
  String swissShort(int n) {
    return 'Suisse : $n rondes. À chaque ronde, vous jouez contre quelqu\'un avec un score proche. Inscription avant la ronde 1.';
  }

  @override
  String get pointsLine => 'Victoire = 3 points · Nulle = 1 · Défaite = 0';

  @override
  String get voiceOn =>
      'Le chat vocal est autorisé (si les deux joueurs l\'acceptent).';

  @override
  String get voiceOff => 'Le chat vocal est désactivé dans ce tournoi.';

  @override
  String get watchNoDelay => 'Diffusion en direct : sans retard.';

  @override
  String watchDelayed(int n) {
    return 'La diffusion a $n secondes de retard.';
  }

  @override
  String get boardYouPlay => 'Le damier sur lequel vous jouerez';

  @override
  String get sameBoardTitle => 'Le même damier pour tous';

  @override
  String get sameBoardInfo =>
      'Tout le monde dans ce tournoi voit ce damier et ces pièces, pour que la partie soit toujours claire. Votre propre choix revient quand vous partez.';

  @override
  String get yourMoney => 'Votre argent (organisateur)';

  @override
  String get feesSoFar => 'Inscriptions jusqu\'ici';

  @override
  String get poolLocked => 'Cagnotte bloquée';

  @override
  String get youWouldEnd => 'Il vous resterait';
}
