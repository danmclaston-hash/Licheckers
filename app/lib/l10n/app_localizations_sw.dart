// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swahili (`sw`).
class LSw extends L {
  LSw([String locale = 'sw']) : super(locale);

  @override
  String get appTitle => 'Licheckers';

  @override
  String get navPlay => 'Cheza';

  @override
  String get navTournaments => 'Mashindano';

  @override
  String get navLearn => 'Jifunze';

  @override
  String get navSettings => 'Mipangilio';

  @override
  String get infoTooltip => 'Hii ni nini?';

  @override
  String get gotIt => 'Nimeelewa';

  @override
  String get cancel => 'Ghairi';

  @override
  String get back => 'Rudi';

  @override
  String get create => 'Unda';

  @override
  String get add => 'Ongeza';

  @override
  String get remove => 'Ondoa';

  @override
  String get join => 'Jiunge';

  @override
  String get white => 'Nyeupe';

  @override
  String get black => 'Nyeusi';

  @override
  String get you => 'Wewe';

  @override
  String get free => 'Bure';

  @override
  String get none => 'Hakuna';

  @override
  String get all => 'Zote';

  @override
  String get variant_english => 'Kiingereza (Kimarekani)';

  @override
  String get variant_international => 'Kimataifa';

  @override
  String get variant_brazilian => 'Kibrazili';

  @override
  String get variant_russian => 'Kirusi';

  @override
  String get variant_italian => 'Kiitaliano';

  @override
  String get variant_spanish => 'Kihispania';

  @override
  String get variant_turkish => 'Kituruki (Dama)';

  @override
  String get variant_frisian => 'Kifrisia';

  @override
  String get variant_canadian => 'Kikanada';

  @override
  String get tagFlyingKings => 'mafalme wanaoruka';

  @override
  String get tagShortKings => 'mafalme wa hatua moja';

  @override
  String get tagStraightMoves => 'hatua za mstari ulionyooka';

  @override
  String get tagCaptures8 => 'kula pande 8';

  @override
  String get tagMenNoKings => 'vipande havili mafalme';

  @override
  String get tagFreeChoice => 'chaguo huru la kula';

  @override
  String get tagMenForward => 'vipande hula mbele tu';

  @override
  String get tagMustTakeMost => 'lazima ule vipande vingi zaidi';

  @override
  String get howToPlay => 'Jinsi ya kucheza';

  @override
  String ruleBoardDiag(int size, int count) {
    return 'Ubao: ${size}x$size. Kila mchezaji anaanza na vipande $count kwenye miraba myeusi.';
  }

  @override
  String ruleBoardAll(int size, int count) {
    return 'Ubao: ${size}x$size. Kila mchezaji anaanza na vipande $count, na kila mraba hutumika.';
  }

  @override
  String get ruleWhiteFirst => 'Nyeupe huanza.';

  @override
  String get ruleBlackFirst => 'Nyeusi huanza.';

  @override
  String get ruleMenMoveDiag =>
      'Vipande husogea mraba mmoja kwa mshazari kwenda mbele.';

  @override
  String get ruleMenMoveStraight =>
      'Vipande husogea mraba mmoja moja kwa moja mbele au pembeni.';

  @override
  String get ruleMenCapture8 =>
      'Vipande hula pande zote 8: kwa mshazari na kwa mistari iliyonyooka.';

  @override
  String get ruleMenCaptureStraight =>
      'Vipande hula kwa kuruka moja kwa moja mbele au pembeni.';

  @override
  String get ruleMenCaptureBoth => 'Vipande hula mbele na nyuma.';

  @override
  String get ruleMenCaptureForward => 'Vipande hula mbele tu.';

  @override
  String get ruleMenNoKings => 'Kipande hakiruhusiwi kula mfalme.';

  @override
  String get ruleKingsFlyDiag =>
      'Mafalme huruka: huteleza miraba mitupu yoyote kwa mshazari, na wanaweza kula kutoka mbali.';

  @override
  String get ruleKingsFlyStraight =>
      'Mafalme huruka: huteleza miraba mitupu yoyote kwa mstari ulionyooka, na wanaweza kula kutoka mbali.';

  @override
  String get ruleKingsShort =>
      'Mafalme husogea mraba mmoja kwa mshazari wowote.';

  @override
  String get ruleMustCapture =>
      'Ukiweza kula, lazima ule. Mfululizo wa kula lazima ukamilike.';

  @override
  String get rulePriorityNone =>
      'Kama kuna njia kadhaa za kula, unachagua mwenyewe.';

  @override
  String get rulePriorityMax =>
      'Lazima uchague njia inayokula vipande vingi zaidi.';

  @override
  String get rulePrioritySpanish =>
      'Lazima ule vipande vingi zaidi. Vikilingana, njia yenye mafalme wengi zaidi.';

  @override
  String get rulePriorityItalian =>
      'Lazima ule vipande vingi zaidi. Vikilingana: kula kwa mfalme, kisha ule mafalme wengi zaidi, kisha njia inayokutana na mfalme kwanza.';

  @override
  String get rulePriorityFrisian =>
      'Lazima ule thamani kubwa zaidi (mfalme ni kidogo chini ya vipande viwili). Vikilingana, mfalme ndiye anayekula.';

  @override
  String get ruleRemoveAsJumped =>
      'Kipande kilicholiwa huondoka ubaoni mara tu kinaporukwa.';

  @override
  String get ruleRemoveAfter =>
      'Vipande vilivyoliwa huondolewa pamoja baada ya hatua. Hadi hapo huzuia njia na haviwezi kurukwa mara mbili.';

  @override
  String get ruleNoTurnBack =>
      'Ndani ya mfululizo mmoja wa kula huwezi kurudi nyuma digrii 180.';

  @override
  String get rulePromoStop =>
      'Kipande kinachofika safu ya mwisho kinakuwa mfalme na hatua inaishia hapo.';

  @override
  String get rulePromoAsMan =>
      'Kipande kinakuwa mfalme tu kama hatua yake INAISHIA kwenye safu ya mwisho. Kikipita tu wakati wa kula, kinabaki kipande.';

  @override
  String get rulePromoAsKing =>
      'Kipande kinachofika safu ya mwisho wakati wa kula kinakuwa mfalme papo hapo na kuendelea kula kama mfalme.';

  @override
  String ruleKingLimit(int n) {
    return 'Mfalme yule yule anaweza kufanya hatua $n tu mfululizo bila kula wakati bado una vipande.';
  }

  @override
  String get ruleLose => 'Unashindwa ukikosa vipande au ukikosa hatua halali.';

  @override
  String ruleDraw(int n) {
    return 'Sare: nafasi ile ile mara tatu, au hatua $n kila mmoja bila kula na bila kusogeza kipande.';
  }

  @override
  String get sectionGame => 'Mchezo';

  @override
  String get variantsInfoTitle => 'Aina za mchezo';

  @override
  String get variantsInfoText =>
      'Drafti huchezwa kwa sheria tofauti duniani kote. Chagua moja hapa. Fungua Jifunze kusoma sheria za kila mchezo.';

  @override
  String get opponent => 'Mpinzani';

  @override
  String get computer => 'Kompyuta';

  @override
  String get twoPlayers => 'Wachezaji wawili';

  @override
  String get botLevelsTitle => 'Viwango vya roboti';

  @override
  String get botLevelsText =>
      'Kuna wachezaji 18 wa kompyuta. Kiwango cha 1 hucheza karibu ovyo. Viwango vya juu huona hatua nyingi mbele na hukosea kidogo. Viwango vya juu kabisa hufikiri kwa sekunde chache.';

  @override
  String levelN(int n) {
    return 'Kiwango $n';
  }

  @override
  String get passDevice => 'Mpe mwenzako kifaa baada ya kila hatua.';

  @override
  String get yourColour => 'Rangi yako';

  @override
  String get startGame => 'Anza mchezo';

  @override
  String get bot1 => 'Husogea ovyo na hupenda kutoa vipande.';

  @override
  String get bot2 =>
      'Yupo kujifurahisha tu. Mara nyingi huingia kwenye mitego yako.';

  @override
  String get bot3 => 'Anajifunza misingi. Anajua kula ni jambo zuri.';

  @override
  String get bot4 =>
      'Mchezaji wa kawaida wa bustanini. Imara lakini anatabirika.';

  @override
  String get bot5 => 'Anaanza kutafuta kula mara mbili na kudhibiti katikati.';

  @override
  String get bot6 => 'Mwangalifu sana. Hupenda kuacha vipande safu ya nyuma.';

  @override
  String get bot7 =>
      'Hushambulia kwa nguvu. Hupenda kulazimisha kubadilishana.';

  @override
  String get bot8 => 'Mchezaji wa kawaida wa klabu ya drafti mtaani.';

  @override
  String get bot9 => 'Husoma nadharia. Hodari sana mwishoni mwa mchezo.';

  @override
  String get bot10 => 'Bingwa wa kanda. Hukosea mara chache sana.';

  @override
  String get bot11 =>
      'Ana uoni mkubwa wa mbinu. Atamnasa mfalme wako kwa urahisi.';

  @override
  String get bot12 => 'Huona mbali. Hudhibiti mwendo wa mchezo.';

  @override
  String get bot13 => 'Nguvu ya kitaifa. Ni vigumu sana kumshinda.';

  @override
  String get bot14 => 'Upangaji wa kiwango cha dunia. Kila hatua ina lengo.';

  @override
  String get bot15 => 'Hutambua mifumo kama mashine. Hayumbi.';

  @override
  String get bot16 => 'Mnyama wa mchezo. Huadhibu kosa dogo kabisa.';

  @override
  String get bot17 => 'Hesabu za kiwango cha kompyuta kubwa.';

  @override
  String get bot18 =>
      'Roboti hodari zaidi hapa: hufikiri kwa kina kadri muda unavyoruhusu.';

  @override
  String get noGame => 'Hakuna mchezo';

  @override
  String get moves => 'Hatua';

  @override
  String get mustCapture => 'Lazima ule';

  @override
  String isThinking(String name) {
    return '$name anafikiri…';
  }

  @override
  String toMove(String name) {
    return 'Zamu ya $name';
  }

  @override
  String drawBecause(String reason) {
    return 'Sare · $reason';
  }

  @override
  String wonBecause(String name, String reason) {
    return '$name ameshinda · $reason';
  }

  @override
  String get reasonResign => 'kujisalimisha';

  @override
  String get reasonNoMoves => 'hakuna hatua halali';

  @override
  String get reasonRepetition => 'nafasi ile ile mara tatu';

  @override
  String reasonNoProgress(int n) {
    return 'hatua $n kila mmoja bila maendeleo';
  }

  @override
  String get undo => 'Tendua';

  @override
  String get playAgain => 'Cheza tena';

  @override
  String get resign => 'Jisalimishe';

  @override
  String get resignQ => 'Ujisalimishe mchezo huu?';

  @override
  String get resignBody => 'Mpinzani wako atashinda.';

  @override
  String get keepPlaying => 'Endelea kucheza';

  @override
  String get noMovesYet => 'Bado hakuna hatua';

  @override
  String get language => 'Lugha';

  @override
  String get languagePhone => 'Lugha ya simu';

  @override
  String get translationNote =>
      'Tafsiri ni mpya. Baadhi ya maneno bado yanahitaji kukaguliwa na mzawa wa lugha.';

  @override
  String get display => 'Mwonekano';

  @override
  String get themeSystem => 'Mfumo';

  @override
  String get themeLight => 'Mwanga';

  @override
  String get themeDark => 'Giza';

  @override
  String get textSize => 'Ukubwa wa maandishi';

  @override
  String get showInfo => 'Onyesha vitufe vya maelezo';

  @override
  String get showInfoSub => 'Vitufe vidogo (i) vinavyoeleza mambo';

  @override
  String get boardAndPieces => 'Ubao na vipande';

  @override
  String get yourLookTitle => 'Skrini yako tu';

  @override
  String get yourLookText =>
      'Machaguo haya hubadilisha skrini yako tu. Kwenye mchezo wa mtandaoni mpinzani wako anabaki na ubao na vipande vyake.';

  @override
  String get board => 'Ubao';

  @override
  String get pieces => 'Vipande';

  @override
  String get squareNumbers => 'Namba za miraba';

  @override
  String get showLegal => 'Onyesha hatua halali';

  @override
  String get showLegalSub =>
      'Nukta pale kipande kinapoweza kwenda, na pete kwenye vipande vinavyolazimika kula';

  @override
  String get pieceAnimation => 'Mwendo wa vipande';

  @override
  String get animOff => 'Zima';

  @override
  String get animFast => 'Haraka';

  @override
  String get animNormal => 'Kawaida';

  @override
  String get animSlow => 'Polepole';

  @override
  String get rulesOfVariants => 'Sheria za kila aina';

  @override
  String get rulesOfVariantsSub => 'Jinsi kila moja ya michezo 9 inavyochezwa';

  @override
  String get installApp => 'Sakinisha programu';

  @override
  String get installAppSub =>
      'Weka Licheckers kwenye skrini ya mwanzo. Inafanya kazi bila mtandao.';

  @override
  String get board_walnut => 'Mkoko';

  @override
  String get board_forest => 'Msitu';

  @override
  String get board_ocean => 'Bahari';

  @override
  String get board_midnight => 'Usiku wa manane';

  @override
  String get board_sunset => 'Machweo';

  @override
  String get board_clear_green => 'Kijani safi';

  @override
  String get board_clear_brown => 'Kahawia safi';

  @override
  String get board_clear_blue => 'Bluu safi';

  @override
  String get board_clear_red => 'Nyekundu safi';

  @override
  String get board_contrast => 'Tofauti kubwa';

  @override
  String get piece_classic => 'Asili';

  @override
  String get piece_wood => 'Mbao';

  @override
  String get piece_glass => 'Kioo';

  @override
  String get piece_ruby => 'Pembe na rubi';

  @override
  String get piece_flat => 'Bapa';

  @override
  String get installTitle => 'Sakinisha Licheckers';

  @override
  String get installBody =>
      'Hufunguka haraka, hufanya kazi bila mtandao, bila duka la programu.';

  @override
  String get installNow => 'Sakinisha';

  @override
  String get notNow => 'Si sasa';

  @override
  String get installIosTitle => 'Ongeza kwenye skrini ya mwanzo';

  @override
  String get installIosBody =>
      'Kwenye Safari, gusa kitufe cha Shiriki, kisha “Ongeza kwenye Skrini ya Mwanzo”.';

  @override
  String get installDone => 'Licheckers imesakinishwa.';

  @override
  String get clock_bullet => 'Risasi';

  @override
  String get clock_blitz => 'Blitz';

  @override
  String get clock_rapid => 'Haraka';

  @override
  String get clock_classic => 'Kawaida';

  @override
  String startsIn(String time) {
    return 'Inaanza baada ya $time';
  }

  @override
  String liveEndsIn(String time) {
    return 'Mubashara: inaisha baada ya $time';
  }

  @override
  String get finished => 'Imekwisha';

  @override
  String leftHM(int h, int m) {
    return 'saa $h dk $m';
  }

  @override
  String leftMS(int m, int s) {
    return 'dk $m sek $s';
  }

  @override
  String durM(int m) {
    return 'dakika $m';
  }

  @override
  String durH(int h) {
    return 'saa $h';
  }

  @override
  String durHM(int h, int m) {
    return 'saa $h dakika $m';
  }

  @override
  String place(String n) {
    String _temp0 = intl.Intl.selectLogic(n, {'other': 'wa $n'});
    return '$_temp0';
  }

  @override
  String get arena => 'Uwanja';

  @override
  String get swiss => 'Kiswisi';

  @override
  String get createTournament => 'Unda mashindano';

  @override
  String get demoNote =>
      'Majaribio: mashindano ya mfano na bado hakuna pesa halisi. Kucheza mtandaoni na malipo vitakuja pamoja na seva.';

  @override
  String get clockTypesTitle => 'Aina za saa';

  @override
  String get clockTypesText =>
      'Risasi: dakika 1 hadi 2 kila mmoja, haraka sana.\nBlitz: dakika 3 hadi 5 kila mmoja.\nHaraka: dakika 10 hadi 15 kila mmoja.\nKawaida: dakika 20 hadi 30 kila mmoja.\n\nNamba ya pili kama 3+2 inamaanisha sekunde 2 huongezwa baada ya kila hatua.';

  @override
  String get noTournamentsOfType => 'Bado hakuna mashindano ya aina hii.';

  @override
  String get yours => 'Yako';

  @override
  String get joinedTag => 'Umejiunga';

  @override
  String presentedBy(String names) {
    return 'Imeletwa na $names';
  }

  @override
  String hostedBy(String host) {
    return 'Mwenyeji: $host';
  }

  @override
  String get entry => 'Kiingilio';

  @override
  String get prizePool => 'Zawadi jumla';

  @override
  String get players => 'Wachezaji';

  @override
  String get createTitle => 'Unda mashindano';

  @override
  String get secAbout => '1. Kuhusu';

  @override
  String get tournamentName => 'Jina la mashindano';

  @override
  String get secFormat => '2. Mfumo';

  @override
  String get arenaInfo =>
      'Jiunge wakati wowote kabla ya mwisho. Cheza michezo mingi kadri uwezavyo. Ushindi ni pointi 3, sare 1, kushindwa 0. Mwenye pointi nyingi saa ikiisha anashinda.\n\nNzuri kwa umati mkubwa, kwa sababu watu wanaweza kuchelewa.';

  @override
  String get swissInfo =>
      'Idadi maalum ya raundi. Kila raundi unakutanishwa na mtu mwenye alama zinazokaribiana. Kila mtu hucheza kila raundi. Mwenye pointi nyingi baada ya raundi ya mwisho anashinda.\n\nNzuri kwa mashindano madogo ya umakini (hadi wachezaji 200 hivi). Unaweza kujiunga kabla ya raundi ya 1 tu.';

  @override
  String get notEnoughRounds =>
      'Muda hautoshi kwa raundi 3. Ongeza muda wa mashindano au fanya saa iwe ya haraka.';

  @override
  String roundsFit(int n, int max) {
    return 'Raundi: $n (hadi $max zinatosha)';
  }

  @override
  String get secClock => '3. Saa';

  @override
  String get clockTitle => 'Saa';

  @override
  String get clockInfo =>
      'Kila mchezo wa mashindano una saa, ili mchezaji wa polepole asisimamishe mashindano yote. Namba ya pili ni sekunde za ziada baada ya kila hatua.';

  @override
  String minutesPerPlayer(int n) {
    return 'Dakika kwa kila mchezaji: $n';
  }

  @override
  String secondsAdded(int n) {
    return 'Sekunde zinazoongezwa kila hatua: $n';
  }

  @override
  String longGame(String clock, int n) {
    return '$clock. Mchezo mrefu huchukua karibu dakika $n.';
  }

  @override
  String get secWhen => '4. Lini';

  @override
  String get whenTitle => 'Kuanza na urefu';

  @override
  String get whenInfo =>
      'Mashindano ni mafupi kwa makusudi: dakika 30 hadi saa 4. Wachezaji wanaona muda unaohesabu kurudi nyuma hadi kuanza, kisha hadi mwisho. Hakuna michezo mipya katika dakika za mwisho; michezo inayoendelea inaweza kumalizika.';

  @override
  String get in1h => 'Baada ya saa 1';

  @override
  String get in3h => 'Baada ya saa 3';

  @override
  String get in8h => 'Baada ya saa 8';

  @override
  String get pickDateTime => 'Chagua tarehe na saa';

  @override
  String startsAt(String time) {
    return 'Inaanza: $time';
  }

  @override
  String lengthIs(String d) {
    return 'Urefu: $d';
  }

  @override
  String endsAt(String time) {
    return 'Inaisha: $time';
  }

  @override
  String roundsFitIn(int n, String d) {
    return 'Karibu raundi $n zinatosha ndani ya $d.';
  }

  @override
  String get secMoney => '5. Wachezaji na pesa';

  @override
  String get moneyTitle => 'Jinsi pesa zinavyofanya kazi';

  @override
  String moneyInfo(int pct) {
    return 'Unafunga zawadi yote unapounda mashindano. Wachezaji hulipa kiingilio ili kujiunga. Washindi hulipwa kutoka kwenye zawadi uliyofunga. Viingilio ni vyako. Jukwaa huchukua $pct% ya faida yako tu (viingilio ukitoa zawadi). Viingilio visipotosha zawadi, jukwaa halichukui chochote.\n\nMashindano yakighairiwa kabla ya kuanza, kila mtu anarudishiwa pesa. Yakishaanza, pesa zimefungwa.';
  }

  @override
  String get minPlayers => 'Wachezaji wa chini';

  @override
  String get maxPlayers => 'Wachezaji wa juu';

  @override
  String get entryFee => 'Kiingilio';

  @override
  String get winnerSplit => 'Mgawanyo wa zawadi';

  @override
  String get winnerSplitInfo =>
      'Jinsi zawadi inavyogawanywa kati ya nafasi za juu. Mabaki ya kukadiria huenda kwa wa kwanza.';

  @override
  String get split_winner => 'Mshindi anachukua yote';

  @override
  String get split_top3 => 'Watatu wa juu';

  @override
  String get split_top5 => 'Watano wa juu';

  @override
  String get whatIf => 'Je, wachezaji hawa wakijiunga?';

  @override
  String get whatIfTitle => 'Pesa zako, zimehesabiwa';

  @override
  String get whatIfInfo =>
      'Sogeza kitelezi kuona utakachopata. Sehemu ya jukwaa huchukuliwa kutoka kwenye faida yako tu.';

  @override
  String get feesCollected => 'Viingilio vilivyokusanywa';

  @override
  String get poolYouLocked => 'Zawadi uliyofunga';

  @override
  String platformShare(int pct) {
    return 'Sehemu ya jukwaa ($pct% ya faida)';
  }

  @override
  String get youEndWith => 'Unabaki na';

  @override
  String breakEven(int n) {
    return 'Unarudisha pesa zako kwa wachezaji $n. Chini ya hapo unapoteza sehemu ya zawadi.';
  }

  @override
  String get secBoard => '6. Ubao na vipande';

  @override
  String get whyOnlyThese => 'Kwa nini hizi tu?';

  @override
  String get whyOnlyTheseInfo =>
      'Kila mtu kwenye mashindano anacheza kwenye ubao ule ule, ili wachezaji waone miraba na vipande vizuri kila wakati. Tunatoa tu ubao na vipande vinavyopita majaribio yetu ya usomekaji. Wadhamini hawawezi kubadilisha ubao kamwe.';

  @override
  String piecesNamed(String name) {
    return 'Vipande $name';
  }

  @override
  String get check_whiteOnDark =>
      'Vipande vyeupe vinaonekana vizuri kwenye miraba myeusi';

  @override
  String get check_blackOnDark =>
      'Vipande vyeusi vinaonekana vizuri kwenye miraba myeusi';

  @override
  String get check_sidesApart =>
      'Vipande vyeupe na vyeusi vinatofautiana kwa urahisi';

  @override
  String get check_squaresApart =>
      'Miraba myeupe na myeusi inatofautiana kwa urahisi';

  @override
  String checkLine(String label, String value, String need) {
    return '$label ($value : 1, inahitaji $need)';
  }

  @override
  String get secSponsor => '7. Mdhamini (hiari)';

  @override
  String get sponsoredTitle => 'Mashindano yenye wadhamini';

  @override
  String sponsoredInfo(String theme, String pieces) {
    return 'Mdhamini hubadilisha mwonekano wa programu kwa mashindano haya tu: rangi, nembo na ukanda wa jina, na kwa hiari jina lake kwenye vipande. Miraba ya ubao haibadiliki kamwe. Hakuna matangazo yanayoibuka, video wala sauti, na hakuna kitu kinachofunika ubao au saa. Mchezaji akitoka kwenye mashindano, programu inarudi kawaida.\n\nBei: $theme kwa kila mdhamini, pamoja na $pieces kwa kila mdhamini kuweka jina lake kwenye vipande. Picha hukaguliwa kwanza, kwa hiyo mashindano yenye mdhamini lazima yaanze angalau saa 6 kuanzia sasa.';
  }

  @override
  String get noSponsor => 'Bila mdhamini';

  @override
  String get oneSponsor => 'Mdhamini mmoja';

  @override
  String get twoSponsors => 'Wadhamini wawili (nusu kila mmoja)';

  @override
  String get sponsorName => 'Jina la mdhamini';

  @override
  String get sponsor1Name => 'Jina la mdhamini 1 (upande mweupe)';

  @override
  String get sponsor2Name => 'Jina la mdhamini 2 (upande mweusi)';

  @override
  String get sponsor => 'Mdhamini';

  @override
  String get sponsor1 => 'Mdhamini 1';

  @override
  String get sponsor2 => 'Mdhamini 2';

  @override
  String nameOnPieces(String price) {
    return 'Jina kwenye vipande (+$price)';
  }

  @override
  String nameOnWhite(String price) {
    return 'Jina kwenye vipande vyeupe (+$price)';
  }

  @override
  String nameOnBlack(String price) {
    return 'Jina kwenye vipande vyeusi (+$price)';
  }

  @override
  String upToLetters(int n) {
    return 'Hadi herufi $n, usomekaji unakaguliwa';
  }

  @override
  String sponsorTotal(String price) {
    return 'Jumla ya mdhamini: $price';
  }

  @override
  String get logoRules =>
      'Nembo: PNG, JPG au WebP, chini ya MB 2. Kila nembo hukaguliwa na mtu (bila maudhui ya watu wazima, bila chapa bandia) kabla wachezaji wengine hawajaiona.';

  @override
  String get upload => 'Pakia';

  @override
  String get fromLink => 'Kutoka kiungo';

  @override
  String get logoColour => 'Rangi kutoka kwenye nembo';

  @override
  String get logoAdded =>
      'Rangi ya nembo sasa ndiyo rangi ya mashindano. Nembo inasubiri ukaguzi wa usalama na mtu: hadi hapo ni wewe tu unayeiona.';

  @override
  String get linkTitle => 'Ongeza picha kutoka kiungo';

  @override
  String get linkHelp =>
      'Bandika anwani ya picha yenyewe (mara nyingi huishia na .png au .jpg). Baadhi ya tovuti huzuia programu nyingine kutumia picha zao. Ikitokea hivyo, pakua picha kisha tumia Pakia.';

  @override
  String somethingWrong(String error) {
    return 'Kuna tatizo: $error';
  }

  @override
  String get secOptions => '8. Machaguo';

  @override
  String get allowVoice => 'Ruhusu mazungumzo ya sauti kwenye michezo';

  @override
  String get allowVoiceSub => 'Wachezaji bado wanachagua kuongea au la';

  @override
  String get watchDelay => 'Kuchelewesha matangazo mubashara';

  @override
  String get watchDelayTitle => 'Kuchelewesha matangazo';

  @override
  String get watchDelayInfo =>
      'Watu wengine wanaweza kutazama michezo ya juu mubashara. Kwenye mashindano ya kulipia wanaona sekunde chache nyuma, ili mtu asimpe mchezaji hatua bora.';

  @override
  String seconds(int n) {
    return 'sek $n';
  }

  @override
  String moreProblems(String first, int n) {
    return '$first  (+$n zaidi)';
  }

  @override
  String get youPayNow => 'Unalipa sasa';

  @override
  String get lockAndCreate => 'Funga zawadi na unda';

  @override
  String get confirmTitle => 'Ufunge zawadi na uunde?';

  @override
  String confirmPay(String total) {
    return 'Unalipa $total sasa:';
  }

  @override
  String confirmPool(String amount) {
    return 'Zawadi (imefungwa): $amount';
  }

  @override
  String confirmFee(String amount) {
    return 'Ada ya kuunda: $amount';
  }

  @override
  String confirmSponsor(String amount) {
    return 'Mwonekano wa mdhamini: $amount';
  }

  @override
  String get confirmRules =>
      'Mashindano yakighairiwa kabla ya kuanza, kila mchezaji anarudishiwa kiingilio na zawadi yako inarudi kwako. Yakishaanza, zawadi inabaki imefungwa hadi washindi walipwe.';

  @override
  String get demoNoMoney => 'Majaribio: bado hakuna pesa halisi inayohamishwa.';

  @override
  String get p_nameShort => 'Yape mashindano jina (herufi 3 au zaidi).';

  @override
  String p_clockRange(String type) {
    return 'Saa iko nje ya kiwango cha $type.';
  }

  @override
  String get p_lengthRange => 'Urefu lazima uwe kati ya dakika 30 na saa 4.';

  @override
  String get p_startSoon => 'Anza angalau dakika 30 kuanzia sasa.';

  @override
  String get p_sponsoredStartSoon =>
      'Mashindano yenye mdhamini lazima yaanze angalau saa 6 kuanzia sasa, ili picha zikaguliwe.';

  @override
  String p_swissFew(int n) {
    return 'Raundi $n tu za Kiswisi zinatosha. Ongeza muda au fanya saa iwe ya haraka.';
  }

  @override
  String p_swissTooMany(int n) {
    return 'Raundi zisizozidi $n ndizo zinatosha kwa muda huu.';
  }

  @override
  String get p_arenaTooSlow =>
      'Saa hii ni ya polepole mno kwa muda huu. Ongeza muda wa mashindano au fanya saa iwe ya haraka.';

  @override
  String get p_minPlayers => 'Wanahitajika angalau wachezaji 2.';

  @override
  String get p_maxBelowMin =>
      'Idadi ya juu ya wachezaji isiwe chini ya idadi ya chini.';

  @override
  String p_poolTooSmall(String amount) {
    return 'Zawadi lazima iwe angalau $amount.';
  }

  @override
  String p_prizesNeedPlayers(int n) {
    return 'Zawadi $n zinahitaji angalau wachezaji $n.';
  }

  @override
  String get p_boardUnclear =>
      'Ubao huu na vipande hivi havionekani vizuri vya kutosha. Chagua jozi nyingine.';

  @override
  String get p_sponsorName => 'Andika jina la mdhamini.';

  @override
  String get p_sponsor2Name => 'Andika jina la mdhamini wa pili.';

  @override
  String p_whiteLabel(String problem) {
    return 'Vipande vyeupe: $problem';
  }

  @override
  String p_blackLabel(String problem) {
    return 'Vipande vyeusi: $problem';
  }

  @override
  String lbl_empty(int n) {
    return 'Andika jina fupi (hadi herufi $n).';
  }

  @override
  String lbl_tooLong(int n) {
    return 'Ni refu mno: herufi $n zaidi ili taji la mfalme lionekane.';
  }

  @override
  String get lbl_unreadable =>
      'Jina hili lingekuwa gumu kusoma kwenye vipande hivi. Chagua vipande vingine.';

  @override
  String get e_svg =>
      'Faili za SVG zitakubaliwa seva ikiweza kuzibadilisha kwa usalama. Kwa sasa tumia PNG au JPG.';

  @override
  String get e_type => 'Tafadhali tumia picha ya PNG, JPG au WebP.';

  @override
  String get e_big => 'Picha ni kubwa mno. Iwe chini ya MB 2.';

  @override
  String get e_empty => 'Faili ni tupu.';

  @override
  String get e_https => 'Tumia kiungo kamili kinachoanza na https://';

  @override
  String get e_link =>
      'Imeshindikana kupakia kiungo hicho. Baadhi ya tovuti huzuia programu nyingine kutumia picha zao. Pakua picha kisha tumia Pakia.';

  @override
  String e_http(String code) {
    return 'Tovuti imejibu kwa hitilafu ($code).';
  }

  @override
  String get e_webpage =>
      'Kiungo hicho ni ukurasa wa tovuti, si picha. Fungua picha yenyewe na unakili anwani yake.';

  @override
  String get e_notPicture => 'Faili hii si picha tunayoweza kusoma.';

  @override
  String get joinForFree => 'Jiunge bure';

  @override
  String joinFor(String price) {
    return 'Jiunge kwa $price';
  }

  @override
  String get joinForFreeQ => 'Ujiunge bure?';

  @override
  String joinForQ(String price) {
    return 'Ujiunge kwa $price?';
  }

  @override
  String get refundNote =>
      'Mashindano yakighairiwa kabla ya kuanza, unarudishiwa kiingilio chako.';

  @override
  String get created =>
      'Mashindano yameundwa. Shiriki kiungo hapa chini ili watu wajiunge.';

  @override
  String get logoPending =>
      'Nembo inasubiri ukaguzi wa usalama: ni wewe tu unayeiona';

  @override
  String fromTo(String start, String end, String d) {
    return '$start hadi $end  ($d)';
  }

  @override
  String get youreIn => 'Umejiunga';

  @override
  String get invitePeople => 'Alika watu';

  @override
  String get shareLinkTitle => 'Kiungo cha kushiriki';

  @override
  String get shareLinkInfo =>
      'Tuma kiungo hiki kwa WhatsApp au popote. Walio na programu tayari hufungua mashindano haya. Watu wapya huombwa kujisajili kwanza, kisha wajiunge.\n\nKiungo kitaanza kufanya kazi kucheza mtandaoni kukianza.';

  @override
  String get copyLink => 'Nakili kiungo';

  @override
  String get linkCopied => 'Kiungo kimenakiliwa';

  @override
  String get prizes => 'Zawadi';

  @override
  String joinedCount(int n, int min, int max) {
    return '$n wamejiunga (chini $min, juu $max)';
  }

  @override
  String get howItWorks => 'Jinsi inavyofanya kazi';

  @override
  String get pointsTitle => 'Pointi na sare';

  @override
  String get pointsInfo =>
      'Ushindi pointi 3, sare 1, kushindwa 0. Wachezaji wakiwa na pointi sawa, mwenye ushindi mwingi anatangulia, kisha matokeo yao wenyewe kwa wenyewe, kisha nguvu za wapinzani, kisha michezo michache, kisha aliyefikia alama kwanza. Kwa hiyo daima kuna mshindi mmoja tu wa kwanza.';

  @override
  String get arenaShort =>
      'Uwanja: jiunge wakati wowote. Cheza michezo mingi kadri uwezavyo. Mwenye pointi nyingi saa ikiisha anashinda.';

  @override
  String swissShort(int n) {
    return 'Kiswisi: raundi $n. Kila raundi unakutana na mtu mwenye alama zinazokaribiana. Jiunge kabla ya raundi ya 1.';
  }

  @override
  String get pointsLine => 'Ushindi = pointi 3 · Sare = 1 · Kushindwa = 0';

  @override
  String get voiceOn =>
      'Mazungumzo ya sauti yanaruhusiwa (wachezaji wote wawili wakikubali).';

  @override
  String get voiceOff =>
      'Mazungumzo ya sauti yamezimwa kwenye mashindano haya.';

  @override
  String get watchNoDelay => 'Kutazama mubashara: bila kuchelewa.';

  @override
  String watchDelayed(int n) {
    return 'Kutazama mubashara kunachelewa sekunde $n.';
  }

  @override
  String get boardYouPlay => 'Ubao utakaochezea';

  @override
  String get sameBoardTitle => 'Ubao mmoja kwa wote';

  @override
  String get sameBoardInfo =>
      'Kila mtu kwenye mashindano haya anaona ubao huu na vipande hivi, ili mchezo uwe wazi kila wakati. Ubao wako mwenyewe unarudi ukiondoka.';

  @override
  String get yourMoney => 'Pesa zako (mwenyeji)';

  @override
  String get feesSoFar => 'Viingilio hadi sasa';

  @override
  String get poolLocked => 'Zawadi iliyofungwa';

  @override
  String get youWouldEnd => 'Ungebaki na';

  @override
  String get quickEasy => 'Rahisi';

  @override
  String get quickMedium => 'Wastani';

  @override
  String get quickHard => 'Ngumu';

  @override
  String get twoPlayersSub => 'kifaa kimoja';

  @override
  String get customTile => 'Chagua mwenyewe';

  @override
  String get customSub => 'machaguo yako';

  @override
  String get customTitle => 'Mchezo wa machaguo yako';

  @override
  String get chooseVariant => 'Chagua mchezo';

  @override
  String get nextTournament => 'Mashindano yajayo';

  @override
  String get noClock => 'Bila saa';

  @override
  String get reasonTimeout => 'muda umekwisha';

  @override
  String get newGame => 'Mchezo mpya';

  @override
  String get sounds => 'Sauti na mtetemo';

  @override
  String get soundsSub =>
      'Hatua, kula, mafalme, muda mfupi na mwisho wa mchezo';

  @override
  String get prevMove => 'Hatua iliyopita';

  @override
  String get nextMove => 'Hatua inayofuata';

  @override
  String get backToGame => 'Rudi kwenye mchezo';
}
