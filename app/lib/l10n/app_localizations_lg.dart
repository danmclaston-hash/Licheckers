// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ganda Luganda (`lg`).
class LLg extends L {
  LLg([String locale = 'lg']) : super(locale);

  @override
  String get appTitle => 'Licheckers';

  @override
  String get navPlay => 'Zannya';

  @override
  String get navTournaments => 'Empaka';

  @override
  String get navLearn => 'Yiga';

  @override
  String get navSettings => 'Ensengeka';

  @override
  String get infoTooltip => 'Kino kye ki?';

  @override
  String get gotIt => 'Ntegedde';

  @override
  String get cancel => 'Sazaamu';

  @override
  String get back => 'Ddayo';

  @override
  String get create => 'Tondawo';

  @override
  String get add => 'Gattako';

  @override
  String get remove => 'Ggyawo';

  @override
  String get join => 'Weegatte';

  @override
  String get white => 'Ebyeru';

  @override
  String get black => 'Ebiddugavu';

  @override
  String get you => 'Ggwe';

  @override
  String get free => 'Bwereere';

  @override
  String get none => 'Tewali';

  @override
  String get all => 'Byonna';

  @override
  String get variant_english => 'Olungereza (Amerika)';

  @override
  String get variant_international => 'Ensi yonna';

  @override
  String get variant_brazilian => 'Brazil';

  @override
  String get variant_russian => 'Russia';

  @override
  String get variant_italian => 'Italy';

  @override
  String get variant_spanish => 'Spain';

  @override
  String get variant_turkish => 'Turkey (Dama)';

  @override
  String get variant_frisian => 'Frisia';

  @override
  String get variant_canadian => 'Canada';

  @override
  String get tagFlyingKings => 'bakabaka ababuuka';

  @override
  String get tagShortKings => 'bakabaka ab\'ekifo kimu';

  @override
  String get tagStraightMoves => 'okutambula obutereevu';

  @override
  String get tagCaptures8 => 'okulya mu njuyi 8';

  @override
  String get tagMenNoKings => 'obuyinja tebulya bakabaka';

  @override
  String get tagFreeChoice => 'olonda bw\'olya';

  @override
  String get tagMenForward => 'obuyinja bulya mu maaso kyokka';

  @override
  String get tagMustTakeMost => 'olina okulya ebisinga obungi';

  @override
  String get howToPlay => 'Engeri y\'okuzannya';

  @override
  String ruleBoardDiag(int size, int count) {
    return 'Olubaawo: ${size}x$size. Buli muzannyi atandika n\'obuyinja $count ku bifo ebiddugavu.';
  }

  @override
  String ruleBoardAll(int size, int count) {
    return 'Olubaawo: ${size}x$size. Buli muzannyi atandika n\'obuyinja $count, era buli kifo kikozesebwa.';
  }

  @override
  String get ruleWhiteFirst => 'Ebyeru bye bitandika.';

  @override
  String get ruleBlackFirst => 'Ebiddugavu bye bitandika.';

  @override
  String get ruleMenMoveDiag =>
      'Akayinja katambula ekifo kimu mu maaso nga kakyamye.';

  @override
  String get ruleMenMoveStraight =>
      'Akayinja katambula ekifo kimu obutereevu mu maaso oba ku mabbali.';

  @override
  String get ruleMenCapture8 =>
      'Obuyinja bulya mu njuyi zonna 8: nga bukyamye n\'obutereevu.';

  @override
  String get ruleMenCaptureStraight =>
      'Obuyinja bulya nga bubuuka obutereevu mu maaso oba ku mabbali.';

  @override
  String get ruleMenCaptureBoth => 'Obuyinja bulya mu maaso n\'emabega.';

  @override
  String get ruleMenCaptureForward => 'Obuyinja bulya mu maaso kyokka.';

  @override
  String get ruleMenNoKings => 'Akayinja tekakkirizibwa kulya kabaka.';

  @override
  String get ruleKingsFlyDiag =>
      'Bakabaka babuuka: basobola okutambula ebifo ebyereere byonna nga bakyamye, era basobola okulya nga bali wala.';

  @override
  String get ruleKingsFlyStraight =>
      'Bakabaka babuuka: basobola okutambula ebifo ebyereere byonna obutereevu, era basobola okulya nga bali wala.';

  @override
  String get ruleKingsShort => 'Kabaka atambula ekifo kimu mu kukyama kwonna.';

  @override
  String get ruleMustCapture =>
      'Bw\'oba osobola okulya, olina okulya. Okulya okw\'omuddiring\'anwa kulina okuggwa.';

  @override
  String get rulePriorityNone =>
      'Bwe wabaawo engeri nnyingi ez\'okulya, ggwe olonda.';

  @override
  String get rulePriorityMax => 'Olina okulonda engeri erya ebisinga obungi.';

  @override
  String get rulePrioritySpanish =>
      'Olina okulya ebisinga obungi. Bwe byenkana, engeri erimu bakabaka abasinga.';

  @override
  String get rulePriorityItalian =>
      'Olina okulya ebisinga obungi. Bwe byenkana: lya ne kabaka, oluvannyuma lya bakabaka abasinga, oluvannyuma engeri esooka okusanga kabaka.';

  @override
  String get rulePriorityFrisian =>
      'Olina okulya ekisinga omuwendo (kabaka abalibwa katono wansi w\'obuyinja bubiri). Bwe byenkana, kabaka y\'alya.';

  @override
  String get ruleRemoveAsJumped =>
      'Akayinja akaliiddwa kava ku lubaawo amangu ddala nga kabuukiddwa.';

  @override
  String get ruleRemoveAfter =>
      'Obuyinja obuliiddwa buggyibwawo wamu oluvannyuma lw\'okutambula. Okutuusa olwo buziyiza ekkubo era tebuyinza kubuukibwa mirundi ebiri.';

  @override
  String get ruleNoTurnBack =>
      'Mu kulya okumu tosobola kudda mabega diguli 180.';

  @override
  String get rulePromoStop =>
      'Akayinja akatuuka ku lunyiriri olusembayo kafuuka kabaka era okutambula kukoma.';

  @override
  String get rulePromoAsMan =>
      'Akayinja kafuuka kabaka singa okutambula kwako KUKOMA ku lunyiriri olusembayo. Bwe kaluyitamu bw\'oba olya, kasigala kayinja.';

  @override
  String get rulePromoAsKing =>
      'Akayinja akatuuka ku lunyiriri olusembayo ng\'olya kafuuka kabaka amangu ago era ne kagenda mu maaso okulya nga kabaka.';

  @override
  String ruleKingLimit(int n) {
    return 'Kabaka y\'omu asobola okutambula emirundi $n gyokka omuddiring\'anwa nga talya, bw\'oba okyalina obuyinja.';
  }

  @override
  String get ruleLose =>
      'Owangulwa bw\'oba tokyalina buyinja oba tokyalina kutambula kukkirizibwa.';

  @override
  String ruleDraw(int n) {
    return 'Amaliri: embeera y\'emu emirundi esatu, oba okutambula $n buli omu awatali kulya wadde okutambuza akayinja.';
  }

  @override
  String get sectionGame => 'Omuzannyo';

  @override
  String get variantsInfoTitle => 'Ebika';

  @override
  String get variantsInfoText =>
      'Omuzannyo guno guzannyibwa n\'amateeka ag\'enjawulo mu nsi yonna. Londa kimu wano. Ggulawo Yiga osome amateeka ga buli muzannyo.';

  @override
  String get opponent => 'Omuvuganya';

  @override
  String get computer => 'Kompyuta';

  @override
  String get twoPlayers => 'Abazannyi babiri';

  @override
  String get botLevelsTitle => 'Emitendera gya kompyuta';

  @override
  String get botLevelsText =>
      'Waliwo abazannyi ba kompyuta 18. Omutendera 1 guzannya kumpi nga tegulowooza. Emitendera egya waggulu girowooza ennyo mu maaso era gikola ensobi ntono. Egya waggulu ennyo girowooza okumala sekonda ntono.';

  @override
  String levelN(int n) {
    return 'Omutendera $n';
  }

  @override
  String get passDevice => 'Wa munno essimu buli lw\'omala okutambula.';

  @override
  String get yourColour => 'Langi yo';

  @override
  String get startGame => 'Tandika omuzannyo';

  @override
  String get bot1 => 'Atambula nga tategese era ayagala okuwaayo obuyinja.';

  @override
  String get bot2 =>
      'Ali wano kunyumirwa bunyumirwa. Atera okugwa mu mitego gyo.';

  @override
  String get bot3 => 'Ayiga ebisookerwako. Amanyi nti okulya kirungi.';

  @override
  String get bot4 => 'Omuzannyi owa bulijjo. Munywevu naye amanyiddwa.';

  @override
  String get bot5 =>
      'Atandika okunoonya okulya emirundi ebiri n\'okufuga wakati.';

  @override
  String get bot6 => 'Yeegendereza nnyo. Ayagala okukuuma obuyinja emabega.';

  @override
  String get bot7 => 'Alumba nnyo. Ayagala okuwaanyisiganya.';

  @override
  String get bot8 => 'Omuzannyi owa bulijjo mu kiraabu.';

  @override
  String get bot9 => 'Asoma amateeka n\'enkola. Mukugu nnyo ku nkomerero.';

  @override
  String get bot10 => 'Nnantameggwa w\'ekitundu. Akola ensobi ntono nnyo.';

  @override
  String get bot11 => 'Alaba wala mu nkola. Ajja kukwata kabaka wo mangu.';

  @override
  String get bot12 => 'Alaba wala nnyo. Afuga entambula y\'omuzannyo.';

  @override
  String get bot13 => 'Amaanyi ag\'eggwanga lyonna. Kizibu nnyo okumuwangula.';

  @override
  String get bot14 =>
      'Ateeka obuyinja ng\'omukugu w\'ensi yonna. Buli kutambula kulina ekigendererwa.';

  @override
  String get bot15 => 'Ategeera enkola ng\'ekyuma. Takyuka.';

  @override
  String get bot16 => 'Wa maanyi nnyo. Abonereza ensobi entono ennyo.';

  @override
  String get bot17 => 'Abala nga kompyuta ennene ennyo.';

  @override
  String get bot18 =>
      'Kompyuta esinga amaanyi wano: erowooza nga bwe kisoboka mu budde.';

  @override
  String get noGame => 'Tewali muzannyo';

  @override
  String get moves => 'Entambula';

  @override
  String get mustCapture => 'Olina okulya';

  @override
  String isThinking(String name) {
    return '$name alowooza…';
  }

  @override
  String toMove(String name) {
    return 'Kati $name';
  }

  @override
  String drawBecause(String reason) {
    return 'Amaliri · $reason';
  }

  @override
  String wonBecause(String name, String reason) {
    return '$name awangudde · $reason';
  }

  @override
  String get reasonResign => 'okwewaayo';

  @override
  String get reasonNoMoves => 'tewali kutambula kukkirizibwa';

  @override
  String get reasonRepetition => 'embeera y\'emu emirundi esatu';

  @override
  String reasonNoProgress(int n) {
    return 'okutambula $n buli omu awatali nkulaakulana';
  }

  @override
  String get undo => 'Ddamu emabega';

  @override
  String get playAgain => 'Zannya nate';

  @override
  String get resign => 'Weewaayo';

  @override
  String get resignQ => 'Weewaayo mu muzannyo guno?';

  @override
  String get resignBody => 'Omuvuganya wo ajja kuwangula.';

  @override
  String get keepPlaying => 'Weeyongere okuzannya';

  @override
  String get noMovesYet => 'Tewannabaawo kutambula';

  @override
  String get language => 'Olulimi';

  @override
  String get languagePhone => 'Olulimi lw\'essimu';

  @override
  String get translationNote =>
      'Okuvvuunula kuno kupya. Ebigambo ebimu byetaaga okukeberebwa omuntu ayogera olulimi luno.';

  @override
  String get display => 'Endabika';

  @override
  String get themeSystem => 'Nga essimu';

  @override
  String get themeLight => 'Ekitangaala';

  @override
  String get themeDark => 'Ekizikiza';

  @override
  String get textSize => 'Obunene bw\'ebigambo';

  @override
  String get showInfo => 'Laga obutambi bw\'okunnyonnyola';

  @override
  String get showInfoSub => 'Obutambi obutono (i) obunnyonnyola ebintu';

  @override
  String get boardAndPieces => 'Olubaawo n\'obuyinja';

  @override
  String get yourLookTitle => 'Ku ssirini yo yokka';

  @override
  String get yourLookText =>
      'By\'olonda bikyusa ssirini yo yokka. Mu muzannyo ku mukutu, omuvuganya wo asigala n\'olubaawo lwe n\'obuyinja bwe.';

  @override
  String get board => 'Olubaawo';

  @override
  String get pieces => 'Obuyinja';

  @override
  String get squareNumbers => 'Ennamba z\'ebifo';

  @override
  String get showLegal => 'Laga entambula ezikkirizibwa';

  @override
  String get showLegalSub =>
      'Obutonnyeze awali akayinja we kasobola okugenda, n\'enkulungo ku buyinja obulina okulya';

  @override
  String get pieceAnimation => 'Entambula y\'obuyinja';

  @override
  String get animOff => 'Ggyako';

  @override
  String get animFast => 'Mangu';

  @override
  String get animNormal => 'Bulijjo';

  @override
  String get animSlow => 'Mpola';

  @override
  String get rulesOfVariants => 'Amateeka ga buli kika';

  @override
  String get rulesOfVariantsSub =>
      'Engeri buli muzannyo ku 9 gye guzannyibwamu';

  @override
  String get installApp => 'Teeka app';

  @override
  String get installAppSub =>
      'Teeka Licheckers ku ssirini y\'awaka. Ekola nga tewali mukutu.';

  @override
  String get board_walnut => 'Omuti';

  @override
  String get board_forest => 'Ekibira';

  @override
  String get board_ocean => 'Ennyanja';

  @override
  String get board_midnight => 'Ttumbi';

  @override
  String get board_sunset => 'Akawungeezi';

  @override
  String get board_clear_green => 'Kiragala ekitangaavu';

  @override
  String get board_clear_brown => 'Kitaka ekitangaavu';

  @override
  String get board_clear_blue => 'Bbululu ekitangaavu';

  @override
  String get board_clear_red => 'Myufu ekitangaavu';

  @override
  String get board_contrast => 'Enjawulo ennene';

  @override
  String get piece_classic => 'Ez\'edda';

  @override
  String get piece_wood => 'Emiti';

  @override
  String get piece_glass => 'Endabirwamu';

  @override
  String get piece_ruby => 'Amasanga ne rubi';

  @override
  String get piece_flat => 'Ezibeeseteevu';

  @override
  String get installTitle => 'Teeka Licheckers';

  @override
  String get installBody =>
      'Eggulawo mangu, ekola nga tewali mukutu, tekyetaagisa dduuka lya apps.';

  @override
  String get installNow => 'Teeka';

  @override
  String get notNow => 'Si kati';

  @override
  String get installIosTitle => 'Gattako ku ssirini y\'awaka';

  @override
  String get installIosBody =>
      'Mu Safari, nyiga ku kaama ka Share, oluvannyuma “Add to Home Screen”.';

  @override
  String get installDone => 'Licheckers eteekeddwako.';

  @override
  String get clock_bullet => 'Bullet';

  @override
  String get clock_blitz => 'Blitz';

  @override
  String get clock_rapid => 'Mangu';

  @override
  String get clock_classic => 'Bulijjo';

  @override
  String startsIn(String time) {
    return 'Etandika mu $time';
  }

  @override
  String liveEndsIn(String time) {
    return 'Kaakati: eggwaako mu $time';
  }

  @override
  String get finished => 'Ewedde';

  @override
  String leftHM(int h, int m) {
    return 'ssaawa $h ddak $m';
  }

  @override
  String leftMS(int m, int s) {
    return 'ddak $m sek $s';
  }

  @override
  String durM(int m) {
    return 'eddakiika $m';
  }

  @override
  String durH(int h) {
    return 'essaawa $h';
  }

  @override
  String durHM(int h, int m) {
    return 'essaawa $h eddakiika $m';
  }

  @override
  String place(String n) {
    String _temp0 = intl.Intl.selectLogic(n, {'other': 'ow\'$n'});
    return '$_temp0';
  }

  @override
  String get arena => 'Arena';

  @override
  String get swiss => 'Swiss';

  @override
  String get createTournament => 'Tondawo empaka';

  @override
  String get demoNote =>
      'Kya kugezesa: empaka za kyakulabirako era tewannabaawo ssente ntuufu. Okuzannya ku mukutu n\'okusasula bijja kujja ne seeva.';

  @override
  String get clockTypesTitle => 'Ebika by\'essaawa';

  @override
  String get clockTypesText =>
      'Bullet: eddakiika 1 okutuuka 2 buli omu, mangu nnyo.\nBlitz: eddakiika 3 okutuuka 5 buli omu.\nMangu: eddakiika 10 okutuuka 15 buli omu.\nBulijjo: eddakiika 20 okutuuka 30 buli omu.\n\nEnnamba ey\'okubiri nga 3+2 kitegeeza nti sekonda 2 zeyongerwako buli lw\'otambula.';

  @override
  String get noTournamentsOfType => 'Tewannabaawo mpaka za kika kino.';

  @override
  String get yours => 'Zizo';

  @override
  String get joinedTag => 'Weegasse';

  @override
  String presentedBy(String names) {
    return 'Ziretebwa $names';
  }

  @override
  String hostedBy(String host) {
    return 'Omutegesi: $host';
  }

  @override
  String get entry => 'Okuyingira';

  @override
  String get prizePool => 'Ebirabo byonna';

  @override
  String get players => 'Abazannyi';

  @override
  String get createTitle => 'Tondawo empaka';

  @override
  String get secAbout => '1. Ebikwata ku mpaka';

  @override
  String get tournamentName => 'Erinnya ly\'empaka';

  @override
  String get secFormat => '2. Enkola';

  @override
  String get arenaInfo =>
      'Weegatte essaawa yonna nga tezinnaggwa. Zannya emizannyo mingi nga bw\'osobola. Okuwangula kuwa obubonero 3, amaliri 1, okuwangulwa 0. Alina obubonero obusinga ng\'essaawa eweddeko y\'awangula.\n\nKirungi ku bantu abangi, kubanga abantu basobola okujja nga bakeerewa.';

  @override
  String get swissInfo =>
      'Emirundi egimanyiddwa. Buli mulundi ozannya n\'omuntu alina obubonero obuliraanye obubwo. Buli muntu azannya buli mulundi. Alina obubonero obusinga ku nkomerero y\'awangula.\n\nKirungi ku mpaka entono enkulu (abazannyi nga 200). Oyinza okwegatta nga omulundi ogusooka tegunnatandika kyokka.';

  @override
  String get notEnoughRounds =>
      'Obudde tebumala mirundi 3. Wangaaza empaka oba essaawa yanguye.';

  @override
  String roundsFit(int n, int max) {
    return 'Emirundi: $n (okutuuka ku $max gisoboka)';
  }

  @override
  String get secClock => '3. Essaawa';

  @override
  String get clockTitle => 'Essaawa';

  @override
  String get clockInfo =>
      'Buli muzannyo gw\'empaka gulina essaawa, omuzannyi omugayaavu aleme okulwisa empaka zonna. Ennamba ey\'okubiri ze sekonda ezeyongerwako buli lw\'otambula.';

  @override
  String minutesPerPlayer(int n) {
    return 'Eddakiika buli muzannyi: $n';
  }

  @override
  String secondsAdded(int n) {
    return 'Sekonda ezeyongerwako buli kutambula: $n';
  }

  @override
  String longGame(String clock, int n) {
    return '$clock. Omuzannyo omuwanvu gutwala eddakiika nga $n.';
  }

  @override
  String get secWhen => '4. Ddi';

  @override
  String get whenTitle => 'Okutandika n\'obuwanvu';

  @override
  String get whenInfo =>
      'Empaka nnyimpi mu bugenderevu: eddakiika 30 okutuuka ku ssaawa 4. Abazannyi balaba essaawa ebala okutuuka ku kutandika, oluvannyuma okutuuka ku nkomerero. Tewaba mizannyo mipya mu ddakiika ezisembayo; egiriko gisobola okuggwa.';

  @override
  String get in1h => 'Mu ssaawa 1';

  @override
  String get in3h => 'Mu ssaawa 3';

  @override
  String get in8h => 'Mu ssaawa 8';

  @override
  String get pickDateTime => 'Londa olunaku n\'essaawa';

  @override
  String startsAt(String time) {
    return 'Etandika: $time';
  }

  @override
  String lengthIs(String d) {
    return 'Obuwanvu: $d';
  }

  @override
  String endsAt(String time) {
    return 'Eggwaako: $time';
  }

  @override
  String roundsFitIn(int n, String d) {
    return 'Emirundi nga $n gisoboka mu $d.';
  }

  @override
  String get secMoney => '5. Abazannyi ne ssente';

  @override
  String get moneyTitle => 'Engeri ssente gye zikolamu';

  @override
  String moneyInfo(int pct) {
    return 'Osiba ebirabo byonna ng\'otondawo empaka. Abazannyi basasula ssente z\'okuyingira. Abawanguzi basasulwa okuva mu birabo by\'osibye. Ssente z\'okuyingira zizo. Omukutu gutwala $pct% ku magoba go gokka (ssente z\'okuyingira ng\'oggyeeko ebirabo). Ssente z\'okuyingira bwe zitamala birabo, omukutu tegutwala kintu.\n\nEmpaka bwe zisazibwamu nga tezinnatandika, buli muntu addizibwa ssente ze. Bwe zimala okutandika, ssente ziba nsibe.';
  }

  @override
  String get minPlayers => 'Abazannyi abatono';

  @override
  String get maxPlayers => 'Abazannyi abangi';

  @override
  String get entryFee => 'Ssente z\'okuyingira';

  @override
  String get winnerSplit => 'Okugabana ebirabo';

  @override
  String get winnerSplitInfo =>
      'Engeri ebirabo gye bigabanyizibwamu mu bifo eby\'oku ntikko. Ebisigalawo biweebwa ow\'olubereberye.';

  @override
  String get split_winner => 'Omuwanguzi atwala byonna';

  @override
  String get split_top3 => 'Abasatu abasooka';

  @override
  String get split_top5 => 'Abataano abasooka';

  @override
  String get whatIf => 'Singa abazannyi bano beegatta?';

  @override
  String get whatIfTitle => 'Ssente zo, nga zibaliddwa';

  @override
  String get whatIfInfo =>
      'Seetula akasitudde olabe ky\'onoofuna. Omugabo gw\'omukutu guggyibwa ku magoba go gokka.';

  @override
  String get feesCollected => 'Ssente z\'okuyingira ezikungaanyiziddwa';

  @override
  String get poolYouLocked => 'Ebirabo by\'osibye';

  @override
  String platformShare(int pct) {
    return 'Omugabo gw\'omukutu ($pct% ku magoba)';
  }

  @override
  String get youEndWith => 'Osigaza';

  @override
  String breakEven(int n) {
    return 'Ssente zo zikomawo ng\'abazannyi $n. Wansi wa ekyo ofiirwa ekitundu ku birabo.';
  }

  @override
  String get secBoard => '6. Olubaawo n\'obuyinja';

  @override
  String get whyOnlyThese => 'Lwaki bino byokka?';

  @override
  String get whyOnlyTheseInfo =>
      'Buli muntu mu mpaka azannyira ku lubaawo lumu, abazannyi balabe bulungi ebifo n\'obuyinja buli kiseera. Tuwaayo empawo n\'obuyinja obuyita mu bigezo byaffe eby\'okulabika bulungi byokka. Abavujjirizi tebasobola kukyusa lubaawo.';

  @override
  String piecesNamed(String name) {
    return 'Obuyinja $name';
  }

  @override
  String get check_whiteOnDark =>
      'Obuyinja obweru bulabika bulungi ku bifo ebiddugavu';

  @override
  String get check_blackOnDark =>
      'Obuyinja obuddugavu bulabika bulungi ku bifo ebiddugavu';

  @override
  String get check_sidesApart =>
      'Obuyinja obweru n\'obuddugavu bwangu okwawula';

  @override
  String get check_squaresApart =>
      'Ebifo ebitangaavu n\'ebiddugavu byangu okwawula';

  @override
  String checkLine(String label, String value, String need) {
    return '$label ($value : 1, kyetaaga $need)';
  }

  @override
  String get secSponsor => '7. Omuvujjirizi (si kya buwaze)';

  @override
  String get sponsoredTitle => 'Empaka ezivujjirirwa';

  @override
  String sponsoredInfo(String theme, String pieces) {
    return 'Omuvujjirizi akyusa endabika ya app ku mpaka zino zokka: langi, akabonero n\'olubaawo lw\'erinnya, era bw\'aba ayagala erinnya lye ku buyinja. Ebifo by\'olubaawo tebikyuka n\'akatono. Tewabaawo bulango obubuuka, vidiyo wadde amaloboozi, era tewali kibikka lubaawo oba essaawa. Omuzannyi bw\'ava mu mpaka, app eddamu okubeera nga bulijjo.\n\nBbeeyi: $theme buli muvujjirizi, ne $pieces buli muvujjirizi okuteeka erinnya lye ku buyinja. Ebifaananyi bisooka kukeberebwa, kale empaka ezivujjirirwa zirina okutandika oluvannyuma lwa ssaawa 6 okuva kati.';
  }

  @override
  String get noSponsor => 'Tewali muvujjirizi';

  @override
  String get oneSponsor => 'Omuvujjirizi omu';

  @override
  String get twoSponsors => 'Abavujjirizi babiri (kitundu buli omu)';

  @override
  String get sponsorName => 'Erinnya ly\'omuvujjirizi';

  @override
  String get sponsor1Name => 'Erinnya ly\'omuvujjirizi 1 (oludda olweru)';

  @override
  String get sponsor2Name => 'Erinnya ly\'omuvujjirizi 2 (oludda oluddugavu)';

  @override
  String get sponsor => 'Omuvujjirizi';

  @override
  String get sponsor1 => 'Omuvujjirizi 1';

  @override
  String get sponsor2 => 'Omuvujjirizi 2';

  @override
  String nameOnPieces(String price) {
    return 'Erinnya ku buyinja (+$price)';
  }

  @override
  String nameOnWhite(String price) {
    return 'Erinnya ku buyinja obweru (+$price)';
  }

  @override
  String nameOnBlack(String price) {
    return 'Erinnya ku buyinja obuddugavu (+$price)';
  }

  @override
  String upToLetters(int n) {
    return 'Ennukuta okutuuka ku $n, nga kikeberebwa okulabika';
  }

  @override
  String sponsorTotal(String price) {
    return 'Omuvujjirizi wonna awamu: $price';
  }

  @override
  String get logoRules =>
      'Obubonero: PNG, JPG oba WebP, wansi wa MB 2. Buli kabonero kakeberebwa omuntu (tekuli bya bakulu, tekuli bubonero bwa bulimba) abazannyi abalala nga tebannakiraba.';

  @override
  String get upload => 'Teekako';

  @override
  String get fromLink => 'Okuva ku link';

  @override
  String get logoColour => 'Langi okuva ku kabonero';

  @override
  String get logoAdded =>
      'Langi y\'akabonero kati ye langi y\'empaka. Akabonero kalinda okukeberebwa omuntu: okutuusa olwo ggwe wekka akalaba.';

  @override
  String get linkTitle => 'Gattako ekifaananyi okuva ku link';

  @override
  String get linkHelp =>
      'Teeka endagiriro y\'ekifaananyi kyennyini (etera okukoma ku .png oba .jpg). Emikutu egimu giziyiza apps endala okukozesa ebifaananyi byabwe. Bwe kiba bwe kityo, wanula ekifaananyi okozese Teekako.';

  @override
  String somethingWrong(String error) {
    return 'Waliwo ekitagenze bulungi: $error';
  }

  @override
  String get secOptions => '8. Eby\'okulonda';

  @override
  String get allowVoice => 'Kkiriza okwogera n\'eddoboozi mu mizannyo';

  @override
  String get allowVoiceSub =>
      'Abazannyi basigala nga balonda okwogera oba nedda';

  @override
  String get watchDelay => 'Okulwisa okulaba kaakati';

  @override
  String get watchDelayTitle => 'Okulwisa okulaba';

  @override
  String get watchDelayInfo =>
      'Abantu abalala basobola okulaba emizannyo egy\'oku ntikko kaakati. Mu mpaka ez\'okusasulira balaba nga bali emabega sekonda ntono, waleme kubaawo abuulira muzannyi kutambula okusinga.';

  @override
  String seconds(int n) {
    return 'sek $n';
  }

  @override
  String moreProblems(String first, int n) {
    return '$first  (+$n endala)';
  }

  @override
  String get youPayNow => 'Osasula kati';

  @override
  String get lockAndCreate => 'Siba ebirabo otondewo';

  @override
  String get confirmTitle => 'Osibe ebirabo otondewo?';

  @override
  String confirmPay(String total) {
    return 'Osasula $total kati:';
  }

  @override
  String confirmPool(String amount) {
    return 'Ebirabo (bisibe): $amount';
  }

  @override
  String confirmFee(String amount) {
    return 'Ssente z\'okutondawo: $amount';
  }

  @override
  String confirmSponsor(String amount) {
    return 'Endabika y\'omuvujjirizi: $amount';
  }

  @override
  String get confirmRules =>
      'Empaka bwe zisazibwamu nga tezinnatandika, buli muzannyi addizibwa ssente z\'okuyingira era ebirabo byo bikudda. Bwe zimala okutandika, ebirabo bisigala nga bisibe okutuusa abawanguzi lwe basasulwa.';

  @override
  String get demoNoMoney =>
      'Kya kugezesa: tewali ssente ntuufu ezikyusibwa kati.';

  @override
  String get p_nameShort => 'Empaka ziwe erinnya (ennukuta 3 oba okusingawo).';

  @override
  String p_clockRange(String type) {
    return 'Essaawa eri bweru wa $type.';
  }

  @override
  String get p_lengthRange =>
      'Obuwanvu bulina okuba wakati w\'eddakiika 30 ne ssaawa 4.';

  @override
  String get p_startSoon => 'Tandika oluvannyuma lw\'eddakiika 30 okuva kati.';

  @override
  String get p_sponsoredStartSoon =>
      'Empaka ezivujjirirwa zirina okutandika oluvannyuma lwa ssaawa 6 okuva kati, ebifaananyi bisobole okukeberebwa.';

  @override
  String p_swissFew(int n) {
    return 'Emirundi $n gyokka egya Swiss gye gisoboka. Wangaaza oba essaawa yanguye.';
  }

  @override
  String p_swissTooMany(int n) {
    return 'Emirundi egitasukka $n gye gisoboka mu budde buno.';
  }

  @override
  String get p_arenaTooSlow =>
      'Essaawa eno egayaala nnyo ku budde buno. Wangaaza empaka oba essaawa yanguye.';

  @override
  String get p_minPlayers => 'Weetaagibwa abazannyi waakiri 2.';

  @override
  String get p_maxBelowMin =>
      'Abazannyi abangi tebalina kuba wansi w\'abatono.';

  @override
  String p_poolTooSmall(String amount) {
    return 'Ebirabo birina okuba waakiri $amount.';
  }

  @override
  String p_prizesNeedPlayers(int n) {
    return 'Ebirabo $n byetaaga abazannyi waakiri $n.';
  }

  @override
  String get p_boardUnclear =>
      'Olubaawo luno n\'obuyinja buno tebirabika bulungi kimala. Londa ebirala.';

  @override
  String get p_sponsorName => 'Wandiika erinnya ly\'omuvujjirizi.';

  @override
  String get p_sponsor2Name => 'Wandiika erinnya ly\'omuvujjirizi ow\'okubiri.';

  @override
  String p_whiteLabel(String problem) {
    return 'Obuyinja obweru: $problem';
  }

  @override
  String p_blackLabel(String problem) {
    return 'Obuyinja obuddugavu: $problem';
  }

  @override
  String lbl_empty(int n) {
    return 'Wandiika erinnya ettono (ennukuta okutuuka ku $n).';
  }

  @override
  String lbl_tooLong(int n) {
    return 'Liwanvu nnyo: ennukuta $n zokka, engule ya kabaka erabike.';
  }

  @override
  String get lbl_unreadable =>
      'Erinnya lino lyandibadde lizibu okusoma ku buyinja buno. Londa obuyinja obulala.';

  @override
  String get e_svg =>
      'Fayiro za SVG zijja kukkirizibwa seeva bw\'eneesobola okuzikyusa mu ngeri ey\'obukuumi. Kati kozesa PNG oba JPG.';

  @override
  String get e_type => 'Kozesa ekifaananyi kya PNG, JPG oba WebP.';

  @override
  String get e_big => 'Ekifaananyi kinene nnyo. Kibeere wansi wa MB 2.';

  @override
  String get e_empty => 'Fayiro njereere.';

  @override
  String get e_https => 'Kozesa link enzijuvu etandika ne https://';

  @override
  String get e_link =>
      'Link eyo tesobodde kuggulibwa. Emikutu egimu giziyiza apps endala okukozesa ebifaananyi byabwe. Wanula ekifaananyi okozese Teekako.';

  @override
  String e_http(String code) {
    return 'Omukutu guddizza ensobi ($code).';
  }

  @override
  String get e_webpage =>
      'Link eyo lupapula lw\'omukutu, si kifaananyi. Ggulawo ekifaananyi kyennyini okoppe endagiriro yaakyo.';

  @override
  String get e_notPicture => 'Fayiro eno si kifaananyi kye tusobola okusoma.';

  @override
  String get joinForFree => 'Weegatte bwereere';

  @override
  String joinFor(String price) {
    return 'Weegatte ku $price';
  }

  @override
  String get joinForFreeQ => 'Weegatte bwereere?';

  @override
  String joinForQ(String price) {
    return 'Weegatte ku $price?';
  }

  @override
  String get refundNote =>
      'Empaka bwe zisazibwamu nga tezinnatandika, oddizibwa ssente zo ez\'okuyingira.';

  @override
  String get created =>
      'Empaka zitondeddwawo. Gabana link wansi abantu beegatte.';

  @override
  String get logoPending =>
      'Akabonero kalinda okukeberebwa: ggwe wekka akalaba';

  @override
  String fromTo(String start, String end, String d) {
    return '$start okutuuka $end  ($d)';
  }

  @override
  String get youreIn => 'Weegasse';

  @override
  String get invitePeople => 'Yita abantu';

  @override
  String get shareLinkTitle => 'Link ey\'okugabana';

  @override
  String get shareLinkInfo =>
      'Weereza link eno ku WhatsApp oba wonna. Abalina app baggulawo empaka zino. Abapya basooka kwewandiisa, oluvannyuma ne beegatta.\n\nLink ejja kutandika okukola okuzannya ku mukutu bwe kunaatandika.';

  @override
  String get copyLink => 'Koppa link';

  @override
  String get linkCopied => 'Link ekoppeddwa';

  @override
  String get prizes => 'Ebirabo';

  @override
  String joinedCount(int n, int min, int max) {
    return '$n beegasse (abatono $min, abangi $max)';
  }

  @override
  String get howItWorks => 'Engeri gye zikolamu';

  @override
  String get pointsTitle => 'Obubonero n\'okwenkana';

  @override
  String get pointsInfo =>
      'Okuwangula obubonero 3, amaliri 1, okuwangulwa 0. Abazannyi bwe benkana obubonero, alina obuwanguzi obusinga y\'asooka, oluvannyuma ebyava mu muzannyo gwabwe bombi, oluvannyuma amaanyi g\'abavuganya, oluvannyuma emizannyo emitono, oluvannyuma eyasooka okutuuka ku bubonero obwo. Kale bulijjo wabaawo ow\'olubereberye omu yekka.';

  @override
  String get arenaShort =>
      'Arena: weegatte essaawa yonna. Zannya emizannyo mingi nga bw\'osobola. Alina obubonero obusinga ng\'essaawa eweddeko y\'awangula.';

  @override
  String swissShort(int n) {
    return 'Swiss: emirundi $n. Buli mulundi ozannya n\'omuntu alina obubonero obuliraanye obubwo. Weegatte nga omulundi ogusooka tegunnatandika.';
  }

  @override
  String get pointsLine =>
      'Okuwangula = obubonero 3 · Amaliri = 1 · Okuwangulwa = 0';

  @override
  String get voiceOn =>
      'Okwogera n\'eddoboozi kukkirizibwa (abazannyi bombi bwe bakkiriza).';

  @override
  String get voiceOff => 'Okwogera n\'eddoboozi kuggyiddwako mu mpaka zino.';

  @override
  String get watchNoDelay => 'Okulaba kaakati: tekulwawo.';

  @override
  String watchDelayed(int n) {
    return 'Okulaba kaakati kulwawo sekonda $n.';
  }

  @override
  String get boardYouPlay => 'Olubaawo lw\'onoozannyirako';

  @override
  String get sameBoardTitle => 'Olubaawo lumu eri bonna';

  @override
  String get sameBoardInfo =>
      'Buli muntu mu mpaka zino alaba olubaawo luno n\'obuyinja buno, omuzannyo gubeere gwa lwatu buli kiseera. Olubaawo lwo lukomawo bw\'ova mu mpaka.';

  @override
  String get yourMoney => 'Ssente zo (omutegesi)';

  @override
  String get feesSoFar => 'Ssente z\'okuyingira okutuuka kati';

  @override
  String get poolLocked => 'Ebirabo ebisibe';

  @override
  String get youWouldEnd => 'Wandisigazza';

  @override
  String get quickEasy => 'Kyangu';

  @override
  String get quickMedium => 'Wakati';

  @override
  String get quickHard => 'Kizibu';

  @override
  String get twoPlayersSub => 'essimu emu';

  @override
  String get customTile => 'Londa wekka';

  @override
  String get customSub => 'by\'olonze';

  @override
  String get customTitle => 'Omuzannyo gw\'olonze';

  @override
  String get chooseVariant => 'Londa omuzannyo';

  @override
  String get nextTournament => 'Empaka eziddako';

  @override
  String get noClock => 'Tewali ssaawa';

  @override
  String get reasonTimeout => 'obudde buweddeko';

  @override
  String get newGame => 'Omuzannyo omupya';

  @override
  String get sounds => 'Amaloboozi n\'okukankana';

  @override
  String get soundsSub =>
      'Okutambula, okulya, bakabaka, obudde obutono n\'enkomerero';

  @override
  String get prevMove => 'Okutambula okwasooka';

  @override
  String get nextMove => 'Okutambula okuddako';

  @override
  String get backToGame => 'Ddayo ku muzannyo';
}
