// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class LAr extends L {
  LAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'Licheckers';

  @override
  String get navPlay => 'العب';

  @override
  String get navTournaments => 'البطولات';

  @override
  String get navLearn => 'تعلّم';

  @override
  String get navSettings => 'الإعدادات';

  @override
  String get infoTooltip => 'ما هذا؟';

  @override
  String get gotIt => 'فهمت';

  @override
  String get cancel => 'إلغاء';

  @override
  String get back => 'رجوع';

  @override
  String get create => 'إنشاء';

  @override
  String get add => 'إضافة';

  @override
  String get remove => 'إزالة';

  @override
  String get join => 'انضم';

  @override
  String get white => 'الأبيض';

  @override
  String get black => 'الأسود';

  @override
  String get you => 'أنت';

  @override
  String get free => 'مجاني';

  @override
  String get none => 'لا شيء';

  @override
  String get all => 'الكل';

  @override
  String get variant_english => 'الإنجليزية (الأمريكية)';

  @override
  String get variant_international => 'الدولية';

  @override
  String get variant_brazilian => 'البرازيلية';

  @override
  String get variant_russian => 'الروسية';

  @override
  String get variant_italian => 'الإيطالية';

  @override
  String get variant_spanish => 'الإسبانية';

  @override
  String get variant_turkish => 'التركية (داما)';

  @override
  String get variant_frisian => 'الفريزية';

  @override
  String get variant_canadian => 'الكندية';

  @override
  String get tagFlyingKings => 'ملوك طائرة';

  @override
  String get tagShortKings => 'ملوك بخطوة واحدة';

  @override
  String get tagStraightMoves => 'حركات مستقيمة';

  @override
  String get tagCaptures8 => 'أكل في 8 اتجاهات';

  @override
  String get tagMenNoKings => 'الجنود لا يأكلون الملوك';

  @override
  String get tagFreeChoice => 'حرية اختيار الأكل';

  @override
  String get tagMenForward => 'الجنود يأكلون للأمام فقط';

  @override
  String get tagMustTakeMost => 'يجب أكل أكبر عدد';

  @override
  String get howToPlay => 'طريقة اللعب';

  @override
  String ruleBoardDiag(int size, int count) {
    return 'الرقعة: ${size}x$size. يبدأ كل لاعب بـ $count جنديًا على المربعات الداكنة.';
  }

  @override
  String ruleBoardAll(int size, int count) {
    return 'الرقعة: ${size}x$size. يبدأ كل لاعب بـ $count جنديًا، وتُستخدم كل المربعات.';
  }

  @override
  String get ruleWhiteFirst => 'الأبيض يبدأ أولًا.';

  @override
  String get ruleBlackFirst => 'الأسود يبدأ أولًا.';

  @override
  String get ruleMenMoveDiag => 'يتحرك الجندي مربعًا واحدًا قطريًا إلى الأمام.';

  @override
  String get ruleMenMoveStraight =>
      'يتحرك الجندي مربعًا واحدًا مستقيمًا إلى الأمام أو إلى الجانب.';

  @override
  String get ruleMenCapture8 =>
      'يأكل الجنود في الاتجاهات الثمانية كلها: قطريًا وفي خطوط مستقيمة.';

  @override
  String get ruleMenCaptureStraight =>
      'يأكل الجنود بالقفز مستقيمًا إلى الأمام أو إلى الجانب.';

  @override
  String get ruleMenCaptureBoth => 'يأكل الجنود إلى الأمام وإلى الخلف.';

  @override
  String get ruleMenCaptureForward => 'يأكل الجنود إلى الأمام فقط.';

  @override
  String get ruleMenNoKings => 'لا يُسمح للجندي بأكل الملك.';

  @override
  String get ruleKingsFlyDiag =>
      'الملوك تطير: تنزلق أي عدد من المربعات الفارغة قطريًا، ويمكنها الأكل من بعيد.';

  @override
  String get ruleKingsFlyStraight =>
      'الملوك تطير: تنزلق أي عدد من المربعات الفارغة في خط مستقيم، ويمكنها الأكل من بعيد.';

  @override
  String get ruleKingsShort => 'يتحرك الملك مربعًا واحدًا في أي اتجاه قطري.';

  @override
  String get ruleMustCapture =>
      'إذا استطعت الأكل فيجب عليك ذلك. ويجب إكمال سلسلة الأكل.';

  @override
  String get rulePriorityNone => 'إذا كان هناك أكثر من أكل ممكن، فأنت تختار.';

  @override
  String get rulePriorityMax =>
      'يجب أن تختار الأكل الذي يأخذ أكبر عدد من القطع.';

  @override
  String get rulePrioritySpanish =>
      'يجب أن تأكل أكبر عدد من القطع. عند التساوي، الأكل الذي فيه أكبر عدد من الملوك.';

  @override
  String get rulePriorityItalian =>
      'يجب أن تأكل أكبر عدد من القطع. عند التساوي: الأكل بالملك، ثم أكل أكبر عدد من الملوك، ثم السلسلة التي تصادف ملكًا أولًا.';

  @override
  String get rulePriorityFrisian =>
      'يجب أن تأكل أعلى قيمة (الملك يساوي أقل قليلًا من جنديين). عند التساوي، يجب أن يأكل الملك.';

  @override
  String get ruleRemoveAsJumped =>
      'تغادر القطعة المأكولة الرقعة لحظة القفز فوقها.';

  @override
  String get ruleRemoveAfter =>
      'تُرفع القطع المأكولة معًا بعد الحركة. وحتى ذلك الحين تسد الطريق ولا يمكن القفز فوقها مرتين.';

  @override
  String get ruleNoTurnBack =>
      'داخل الأكل الواحد لا يجوز الرجوع للخلف 180 درجة.';

  @override
  String get rulePromoStop =>
      'الجندي الذي يصل إلى الصف الأخير يصبح ملكًا وتنتهي الحركة.';

  @override
  String get rulePromoAsMan =>
      'يصبح الجندي ملكًا فقط إذا انتهت حركته على الصف الأخير. إذا مر به أثناء الأكل يبقى جنديًا.';

  @override
  String get rulePromoAsKing =>
      'الجندي الذي يصل إلى الصف الأخير أثناء الأكل يصبح ملكًا فورًا ويواصل الأكل كملك.';

  @override
  String ruleKingLimit(int n) {
    return 'لا يجوز للملك نفسه أن يقوم بأكثر من $n حركات هادئة متتالية ما دام لديك جنود.';
  }

  @override
  String get ruleLose =>
      'تخسر إذا لم تبقَ لديك قطع أو لم تبقَ لديك حركة مسموحة.';

  @override
  String ruleDraw(int n) {
    return 'التعادل: الوضع نفسه ثلاث مرات، أو $n حركات لكل لاعب دون أكل ودون تحريك جندي.';
  }

  @override
  String get sectionGame => 'اللعبة';

  @override
  String get variantsInfoTitle => 'الأنواع';

  @override
  String get variantsInfoText =>
      'تُلعب الداما بقواعد مختلفة حول العالم. اختر واحدة هنا. افتح «تعلّم» لقراءة قواعد كل لعبة.';

  @override
  String get opponent => 'الخصم';

  @override
  String get computer => 'الحاسوب';

  @override
  String get twoPlayers => 'لاعبان';

  @override
  String get botLevelsTitle => 'مستويات الحاسوب';

  @override
  String get botLevelsText =>
      'هناك 18 لاعبًا آليًا. المستوى 1 يلعب عشوائيًا تقريبًا. المستويات الأعلى ترى حركات أبعد وتخطئ أقل. أعلى المستويات تفكر بضع ثوانٍ.';

  @override
  String levelN(int n) {
    return 'المستوى $n';
  }

  @override
  String get passDevice => 'مرّر الجهاز بعد كل حركة.';

  @override
  String get yourColour => 'لونك';

  @override
  String get startGame => 'ابدأ اللعبة';

  @override
  String get bot1 => 'يتحرك عشوائيًا غالبًا ويحب التخلي عن قطعه.';

  @override
  String get bot2 => 'هنا للتسلية فقط. كثيرًا ما يقع في أكلاتك.';

  @override
  String get bot3 => 'يتعلم الأساسيات. يعرف أن الأكل أمر جيد.';

  @override
  String get bot4 => 'لاعب الحديقة العادي. ثابت لكنه متوقَّع.';

  @override
  String get bot5 => 'يبدأ بالبحث عن الأكل المزدوج والسيطرة على الوسط.';

  @override
  String get bot6 => 'حذر جدًا. يفضّل إبقاء القطع في الصف الخلفي.';

  @override
  String get bot7 => 'هجومي جدًا. يحب فرض التبادلات.';

  @override
  String get bot8 => 'لاعب دائم في نادي الداما المحلي.';

  @override
  String get bot9 => 'يدرس النظريات. فعّال جدًا في نهاية اللعبة.';

  @override
  String get bot10 => 'بطل إقليمي. أخطاؤه قليلة جدًا.';

  @override
  String get bot11 => 'رؤية تكتيكية عميقة. سيحاصر ملكك بسهولة.';

  @override
  String get bot12 => 'يرى بعيدًا. يتحكم في إيقاع اللعبة.';

  @override
  String get bot13 => 'قوة بمستوى وطني. يصعب هزيمته جدًا.';

  @override
  String get bot14 => 'تمركز بمستوى عالمي. لكل حركة هدف.';

  @override
  String get bot15 => 'يتعرف على الأنماط كالآلة. لا يلين.';

  @override
  String get bot16 => 'لاعب شرس. يعاقب أصغر خطأ.';

  @override
  String get bot17 => 'حساب بمستوى الحواسيب الخارقة.';

  @override
  String get bot18 => 'أقوى لاعب آلي هنا: يفكر بأعمق ما يسمح به الوقت.';

  @override
  String get noGame => 'لا توجد لعبة';

  @override
  String get moves => 'الحركات';

  @override
  String get mustCapture => 'يجب أن تأكل';

  @override
  String isThinking(String name) {
    return '$name يفكر…';
  }

  @override
  String toMove(String name) {
    return 'دور $name';
  }

  @override
  String drawBecause(String reason) {
    return 'تعادل · $reason';
  }

  @override
  String wonBecause(String name, String reason) {
    return 'فاز $name · $reason';
  }

  @override
  String get reasonResign => 'الاستسلام';

  @override
  String get reasonNoMoves => 'لا توجد حركة مسموحة';

  @override
  String get reasonRepetition => 'الوضع نفسه ثلاث مرات';

  @override
  String reasonNoProgress(int n) {
    return '$n حركات لكل لاعب دون تقدّم';
  }

  @override
  String get undo => 'تراجع';

  @override
  String get playAgain => 'العب مجددًا';

  @override
  String get resign => 'استسلم';

  @override
  String get resignQ => 'هل تستسلم في هذه اللعبة؟';

  @override
  String get resignBody => 'سيفوز خصمك.';

  @override
  String get keepPlaying => 'واصل اللعب';

  @override
  String get noMovesYet => 'لا حركات بعد';

  @override
  String get language => 'اللغة';

  @override
  String get languagePhone => 'لغة الهاتف';

  @override
  String get translationNote =>
      'الترجمات جديدة. قد تحتاج بعض الكلمات إلى مراجعة من متحدث أصلي.';

  @override
  String get display => 'العرض';

  @override
  String get themeSystem => 'النظام';

  @override
  String get themeLight => 'فاتح';

  @override
  String get themeDark => 'داكن';

  @override
  String get textSize => 'حجم النص';

  @override
  String get showInfo => 'إظهار أزرار المعلومات';

  @override
  String get showInfoSub => 'أزرار (i) الصغيرة التي تشرح الأشياء';

  @override
  String get boardAndPieces => 'الرقعة والقطع';

  @override
  String get yourLookTitle => 'لشاشتك فقط';

  @override
  String get yourLookText =>
      'هذه الخيارات تغيّر شاشتك فقط. في اللعب عبر الإنترنت يحتفظ خصمك برقعته وقطعه.';

  @override
  String get board => 'الرقعة';

  @override
  String get pieces => 'القطع';

  @override
  String get squareNumbers => 'أرقام المربعات';

  @override
  String get showLegal => 'إظهار الحركات المسموحة';

  @override
  String get showLegalSub =>
      'نقاط حيث يمكن للقطعة أن تذهب، وحلقة على القطع التي يجب أن تأكل';

  @override
  String get pieceAnimation => 'حركة القطع';

  @override
  String get animOff => 'إيقاف';

  @override
  String get animFast => 'سريعة';

  @override
  String get animNormal => 'عادية';

  @override
  String get animSlow => 'بطيئة';

  @override
  String get rulesOfVariants => 'قواعد كل نوع';

  @override
  String get rulesOfVariantsSub => 'كيف تُلعب كل لعبة من الألعاب التسع';

  @override
  String get installApp => 'تثبيت التطبيق';

  @override
  String get installAppSub =>
      'ضع Licheckers على شاشتك الرئيسية. يعمل دون إنترنت.';

  @override
  String get board_walnut => 'الجوز';

  @override
  String get board_forest => 'الغابة';

  @override
  String get board_ocean => 'المحيط';

  @override
  String get board_midnight => 'منتصف الليل';

  @override
  String get board_sunset => 'الغروب';

  @override
  String get board_clear_green => 'أخضر واضح';

  @override
  String get board_clear_brown => 'بني واضح';

  @override
  String get board_clear_blue => 'أزرق واضح';

  @override
  String get board_clear_red => 'أحمر واضح';

  @override
  String get board_contrast => 'تباين عالٍ';

  @override
  String get piece_classic => 'كلاسيكية';

  @override
  String get piece_wood => 'خشبية';

  @override
  String get piece_glass => 'زجاجية';

  @override
  String get piece_ruby => 'عاج وياقوت';

  @override
  String get piece_flat => 'مسطحة';

  @override
  String get installTitle => 'ثبّت Licheckers';

  @override
  String get installBody =>
      'يفتح أسرع، ويعمل دون إنترنت، دون الحاجة إلى متجر تطبيقات.';

  @override
  String get installNow => 'تثبيت';

  @override
  String get notNow => 'ليس الآن';

  @override
  String get installIosTitle => 'أضفه إلى الشاشة الرئيسية';

  @override
  String get installIosBody =>
      'في سفاري، اضغط زر المشاركة ثم «إضافة إلى الشاشة الرئيسية».';

  @override
  String get installDone => 'تم تثبيت Licheckers.';

  @override
  String get clock_bullet => 'رصاصة';

  @override
  String get clock_blitz => 'خاطفة';

  @override
  String get clock_rapid => 'سريعة';

  @override
  String get clock_classic => 'كلاسيكية';

  @override
  String startsIn(String time) {
    return 'تبدأ خلال $time';
  }

  @override
  String liveEndsIn(String time) {
    return 'مباشر: تنتهي خلال $time';
  }

  @override
  String get finished => 'انتهت';

  @override
  String leftHM(int h, int m) {
    return '$h س $m د';
  }

  @override
  String leftMS(int m, int s) {
    return '$m د $s ث';
  }

  @override
  String durM(int m) {
    return '$m دقيقة';
  }

  @override
  String durH(int h) {
    return '$h ساعة';
  }

  @override
  String durHM(int h, int m) {
    return '$h ساعة و$m دقيقة';
  }

  @override
  String place(String n) {
    String _temp0 = intl.Intl.selectLogic(n, {
      '1': 'الأول',
      '2': 'الثاني',
      '3': 'الثالث',
      'other': 'المركز $n',
    });
    return '$_temp0';
  }

  @override
  String get arena => 'الحلبة';

  @override
  String get swiss => 'السويسري';

  @override
  String get createTournament => 'أنشئ بطولة';

  @override
  String get demoNote =>
      'تجربة: بطولات للعرض ولا أموال حقيقية بعد. اللعب عبر الإنترنت والدفع سيأتيان مع الخادم.';

  @override
  String get clockTypesTitle => 'أنواع الساعة';

  @override
  String get clockTypesText =>
      'رصاصة: من 1 إلى 2 دقيقة لكل لاعب، سريعة جدًا.\nخاطفة: من 3 إلى 5 دقائق لكل لاعب.\nسريعة: من 10 إلى 15 دقيقة لكل لاعب.\nكلاسيكية: من 20 إلى 30 دقيقة لكل لاعب.\n\nالرقم الثاني مثل 3+2 يعني إضافة ثانيتين بعد كل حركة.';

  @override
  String get noTournamentsOfType => 'لا توجد بطولات من هذا النوع بعد.';

  @override
  String get yours => 'لك';

  @override
  String get joinedTag => 'منضم';

  @override
  String presentedBy(String names) {
    return 'برعاية $names';
  }

  @override
  String hostedBy(String host) {
    return 'المنظم: $host';
  }

  @override
  String get entry => 'رسوم الدخول';

  @override
  String get prizePool => 'مجموع الجوائز';

  @override
  String get players => 'اللاعبون';

  @override
  String get createTitle => 'إنشاء بطولة';

  @override
  String get secAbout => '1. نبذة';

  @override
  String get tournamentName => 'اسم البطولة';

  @override
  String get secFormat => '2. النظام';

  @override
  String get arenaInfo =>
      'انضم في أي وقت قبل النهاية. العب أكبر عدد ممكن من المباريات. الفوز 3 نقاط، والتعادل 1، والخسارة 0. صاحب أكثر النقاط عند انتهاء الوقت يفوز.\n\nمناسب للحشود الكبيرة، لأن الناس يمكنهم الوصول متأخرين.';

  @override
  String get swissInfo =>
      'عدد ثابت من الجولات. في كل جولة تواجه لاعبًا نقاطه قريبة من نقاطك. الجميع يلعب كل جولة. صاحب أكثر النقاط بعد الجولة الأخيرة يفوز.\n\nمناسب للبطولات الأصغر والجادة (حتى نحو 200 لاعب). يمكن الانضمام قبل الجولة الأولى فقط.';

  @override
  String get notEnoughRounds =>
      'لا يكفي الوقت لـ 3 جولات. أطِل البطولة أو اجعل الساعة أسرع.';

  @override
  String roundsFit(int n, int max) {
    return 'الجولات: $n (حتى $max ممكنة)';
  }

  @override
  String get secClock => '3. الساعة';

  @override
  String get clockTitle => 'الساعة';

  @override
  String get clockInfo =>
      'لكل مباراة في البطولة ساعة، حتى لا يعطّل لاعب بطيء البطولة كلها. الرقم الثاني هو الثواني المضافة بعد كل حركة.';

  @override
  String minutesPerPlayer(int n) {
    return 'دقائق لكل لاعب: $n';
  }

  @override
  String secondsAdded(int n) {
    return 'ثوانٍ تُضاف بعد كل حركة: $n';
  }

  @override
  String longGame(String clock, int n) {
    return '$clock. المباراة الطويلة تستغرق نحو $n دقيقة.';
  }

  @override
  String get secWhen => '4. الموعد';

  @override
  String get whenTitle => 'البداية والمدة';

  @override
  String get whenInfo =>
      'البطولات قصيرة عن قصد: من 30 دقيقة إلى 4 ساعات. يرى اللاعبون عدًّا تنازليًا حتى البداية ثم حتى النهاية. لا تُبدأ مباريات جديدة في الدقائق الأخيرة، ويمكن للمباريات الجارية أن تنتهي.';

  @override
  String get in1h => 'بعد ساعة';

  @override
  String get in3h => 'بعد 3 ساعات';

  @override
  String get in8h => 'بعد 8 ساعات';

  @override
  String get pickDateTime => 'اختر التاريخ والوقت';

  @override
  String startsAt(String time) {
    return 'تبدأ: $time';
  }

  @override
  String lengthIs(String d) {
    return 'المدة: $d';
  }

  @override
  String endsAt(String time) {
    return 'تنتهي: $time';
  }

  @override
  String roundsFitIn(int n, String d) {
    return 'نحو $n جولات تتسع في $d.';
  }

  @override
  String get secMoney => '5. اللاعبون والمال';

  @override
  String get moneyTitle => 'كيف يعمل المال';

  @override
  String moneyInfo(int pct) {
    return 'تحجز مجموع الجوائز كاملًا عند إنشاء البطولة. يدفع اللاعبون رسوم الدخول للانضمام. يُدفع للفائزين من الجوائز التي حجزتها. رسوم الدخول لك. تأخذ المنصة $pct% من ربحك فقط (رسوم الدخول ناقص الجوائز). إذا لم تغطِّ رسوم الدخول الجوائز فلا تأخذ المنصة شيئًا.\n\nإذا أُلغيت البطولة قبل أن تبدأ يُعاد المال للجميع. وبعد أن تبدأ يصبح المال محجوزًا.';
  }

  @override
  String get minPlayers => 'أقل عدد لاعبين';

  @override
  String get maxPlayers => 'أكبر عدد لاعبين';

  @override
  String get entryFee => 'رسوم الدخول';

  @override
  String get winnerSplit => 'توزيع الجوائز';

  @override
  String get winnerSplitInfo =>
      'كيف تُقسَّم الجوائز بين المراكز الأولى. ما يتبقى من التقريب يذهب للمركز الأول.';

  @override
  String get split_winner => 'الفائز يأخذ الكل';

  @override
  String get split_top3 => 'أفضل 3';

  @override
  String get split_top5 => 'أفضل 5';

  @override
  String get whatIf => 'ماذا لو انضم هذا العدد من اللاعبين؟';

  @override
  String get whatIfTitle => 'أموالك بالحساب';

  @override
  String get whatIfInfo =>
      'حرّك المؤشر لترى ما ستكسبه. حصة المنصة تؤخذ من ربحك فقط.';

  @override
  String get feesCollected => 'رسوم الدخول المجموعة';

  @override
  String get poolYouLocked => 'الجوائز التي حجزتها';

  @override
  String platformShare(int pct) {
    return 'حصة المنصة ($pct% من الربح)';
  }

  @override
  String get youEndWith => 'يتبقى لك';

  @override
  String breakEven(int n) {
    return 'تسترد مالك عند $n لاعبًا. وأقل من ذلك تخسر جزءًا من الجوائز.';
  }

  @override
  String get secBoard => '6. الرقعة والقطع';

  @override
  String get whyOnlyThese => 'لماذا هذه فقط؟';

  @override
  String get whyOnlyTheseInfo =>
      'يلعب الجميع في البطولة على الرقعة نفسها، حتى يرى اللاعبون المربعات والقطع بوضوح دائمًا. نعرض فقط الرقع والقطع التي تنجح في اختبارات الوضوح. لا يستطيع الرعاة تغيير الرقعة أبدًا.';

  @override
  String piecesNamed(String name) {
    return 'قطع $name';
  }

  @override
  String get check_whiteOnDark => 'القطع البيضاء واضحة على المربعات الداكنة';

  @override
  String get check_blackOnDark => 'القطع السوداء واضحة على المربعات الداكنة';

  @override
  String get check_sidesApart => 'يسهل التمييز بين القطع البيضاء والسوداء';

  @override
  String get check_squaresApart => 'يسهل التمييز بين المربعات الفاتحة والداكنة';

  @override
  String checkLine(String label, String value, String need) {
    return '$label ($value : 1، المطلوب $need)';
  }

  @override
  String get secSponsor => '7. الراعي (اختياري)';

  @override
  String get sponsoredTitle => 'البطولات المرعيّة';

  @override
  String sponsoredInfo(String theme, String pieces) {
    return 'يغيّر الراعي مظهر التطبيق في هذه البطولة فقط: الألوان والشعار وشريط الاسم، واسمه على القطع إن أراد. لا تتغير مربعات الرقعة أبدًا. لا نوافذ منبثقة ولا فيديو ولا أصوات أبدًا، ولا شيء يغطي الرقعة أو الساعات. عندما يغادر اللاعب البطولة يعود التطبيق إلى طبيعته.\n\nالسعر: $theme لكل راعٍ، و$pieces إضافية لكل راعٍ لوضع اسمه على القطع. تُراجَع الصور أولًا، لذا يجب أن تبدأ البطولة المرعيّة بعد 6 ساعات على الأقل من الآن.';
  }

  @override
  String get noSponsor => 'بلا راعٍ';

  @override
  String get oneSponsor => 'راعٍ واحد';

  @override
  String get twoSponsors => 'راعيان (النصف لكل منهما)';

  @override
  String get sponsorName => 'اسم الراعي';

  @override
  String get sponsor1Name => 'اسم الراعي 1 (الجانب الأبيض)';

  @override
  String get sponsor2Name => 'اسم الراعي 2 (الجانب الأسود)';

  @override
  String get sponsor => 'الراعي';

  @override
  String get sponsor1 => 'الراعي 1';

  @override
  String get sponsor2 => 'الراعي 2';

  @override
  String nameOnPieces(String price) {
    return 'الاسم على القطع (+$price)';
  }

  @override
  String nameOnWhite(String price) {
    return 'الاسم على القطع البيضاء (+$price)';
  }

  @override
  String nameOnBlack(String price) {
    return 'الاسم على القطع السوداء (+$price)';
  }

  @override
  String upToLetters(int n) {
    return 'حتى $n أحرف، مع فحص الوضوح';
  }

  @override
  String sponsorTotal(String price) {
    return 'مجموع الرعاية: $price';
  }

  @override
  String get logoRules =>
      'الشعارات: PNG أو JPG أو WebP، أقل من 2 ميغابايت. يراجع شخصٌ كل شعار (لا محتوى للبالغين، لا علامات مزيفة) قبل أن يراه اللاعبون الآخرون.';

  @override
  String get upload => 'رفع';

  @override
  String get fromLink => 'من رابط';

  @override
  String get logoColour => 'لون من الشعار';

  @override
  String get logoAdded =>
      'لون الشعار هو الآن لون البطولة. ينتظر الشعار مراجعة أمان من شخص: وحتى ذلك الحين تراه أنت فقط.';

  @override
  String get linkTitle => 'أضف صورة من رابط';

  @override
  String get linkHelp =>
      'الصق عنوان الصورة نفسها (غالبًا ينتهي بـ .png أو .jpg). بعض المواقع تمنع التطبيقات الأخرى من استخدام صورها. إذا حدث ذلك فنزّل الصورة واستخدم «رفع».';

  @override
  String somethingWrong(String error) {
    return 'حدث خطأ: $error';
  }

  @override
  String get secOptions => '8. خيارات';

  @override
  String get allowVoice => 'السماح بالدردشة الصوتية في المباريات';

  @override
  String get allowVoiceSub => 'يبقى للاعبين حق اختيار التحدث أو لا';

  @override
  String get watchDelay => 'تأخير المشاهدة المباشرة';

  @override
  String get watchDelayTitle => 'تأخير المشاهدة';

  @override
  String get watchDelayInfo =>
      'يمكن للآخرين مشاهدة أفضل المباريات مباشرة. في البطولات المدفوعة تتأخر مشاهدتهم بضع ثوانٍ، حتى لا يستطيع أحد تلقين لاعبٍ أفضل حركة.';

  @override
  String seconds(int n) {
    return '$n ث';
  }

  @override
  String moreProblems(String first, int n) {
    return '$first  (+$n أخرى)';
  }

  @override
  String get youPayNow => 'تدفع الآن';

  @override
  String get lockAndCreate => 'احجز الجوائز وأنشئ';

  @override
  String get confirmTitle => 'حجز الجوائز والإنشاء؟';

  @override
  String confirmPay(String total) {
    return 'تدفع $total الآن:';
  }

  @override
  String confirmPool(String amount) {
    return 'الجوائز (محجوزة): $amount';
  }

  @override
  String confirmFee(String amount) {
    return 'رسوم الإنشاء: $amount';
  }

  @override
  String confirmSponsor(String amount) {
    return 'مظهر الراعي: $amount';
  }

  @override
  String get confirmRules =>
      'إذا أُلغيت البطولة قبل أن تبدأ، يسترد كل لاعب رسوم دخوله وتعود إليك الجوائز. بعد أن تبدأ، تبقى الجوائز محجوزة حتى يُدفع للفائزين.';

  @override
  String get demoNoMoney => 'تجربة: لا تتحرك أموال حقيقية بعد.';

  @override
  String get p_nameShort => 'أعطِ البطولة اسمًا (3 أحرف أو أكثر).';

  @override
  String p_clockRange(String type) {
    return 'الساعة خارج نطاق $type.';
  }

  @override
  String get p_lengthRange => 'يجب أن تكون المدة بين 30 دقيقة و4 ساعات.';

  @override
  String get p_startSoon => 'ابدأ بعد 30 دقيقة على الأقل من الآن.';

  @override
  String get p_sponsoredStartSoon =>
      'يجب أن تبدأ البطولات المرعيّة بعد 6 ساعات على الأقل من الآن، حتى تُراجَع الصور.';

  @override
  String p_swissFew(int n) {
    return 'تتسع $n جولات سويسرية فقط. أطِل المدة أو اجعل الساعة أسرع.';
  }

  @override
  String p_swissTooMany(int n) {
    return 'تتسع $n جولات على الأكثر في هذا الوقت.';
  }

  @override
  String get p_arenaTooSlow =>
      'هذه الساعة بطيئة جدًا لهذه المدة. أطِل البطولة أو اجعل الساعة أسرع.';

  @override
  String get p_minPlayers => 'يلزم لاعبان على الأقل.';

  @override
  String get p_maxBelowMin => 'يجب ألا يقل أكبر عدد للاعبين عن أقل عدد.';

  @override
  String p_poolTooSmall(String amount) {
    return 'يجب ألا تقل الجوائز عن $amount.';
  }

  @override
  String p_prizesNeedPlayers(int n) {
    return '$n جوائز تحتاج $n لاعبين على الأقل.';
  }

  @override
  String get p_boardUnclear =>
      'هذه الرقعة وهذه القطع ليست واضحة بما يكفي. اختر زوجًا آخر.';

  @override
  String get p_sponsorName => 'أدخل اسم الراعي.';

  @override
  String get p_sponsor2Name => 'أدخل اسم الراعي الثاني.';

  @override
  String p_whiteLabel(String problem) {
    return 'القطع البيضاء: $problem';
  }

  @override
  String p_blackLabel(String problem) {
    return 'القطع السوداء: $problem';
  }

  @override
  String lbl_empty(int n) {
    return 'اكتب اسمًا قصيرًا (حتى $n أحرف).';
  }

  @override
  String lbl_tooLong(int n) {
    return 'طويل جدًا: $n أحرف على الأكثر حتى يبقى تاج الملك ظاهرًا.';
  }

  @override
  String get lbl_unreadable =>
      'سيكون هذا الاسم صعب القراءة على هذه القطع. اختر قطعًا أخرى.';

  @override
  String get e_svg =>
      'ستُقبل ملفات SVG عندما يستطيع الخادم تحويلها بأمان. استخدم PNG أو JPG حاليًا.';

  @override
  String get e_type => 'يرجى استخدام صورة PNG أو JPG أو WebP.';

  @override
  String get e_big => 'الصورة كبيرة جدًا. اجعلها أقل من 2 ميغابايت.';

  @override
  String get e_empty => 'الملف فارغ.';

  @override
  String get e_https => 'استخدم رابطًا كاملًا يبدأ بـ https://';

  @override
  String get e_link =>
      'تعذّر تحميل هذا الرابط. بعض المواقع تمنع التطبيقات الأخرى من استخدام صورها. نزّل الصورة واستخدم «رفع».';

  @override
  String e_http(String code) {
    return 'ردّ الموقع بخطأ ($code).';
  }

  @override
  String get e_webpage =>
      'هذا الرابط صفحة ويب وليس صورة. افتح الصورة نفسها وانسخ عنوانها.';

  @override
  String get e_notPicture => 'هذا الملف ليس صورة يمكننا قراءتها.';

  @override
  String get joinForFree => 'انضم مجانًا';

  @override
  String joinFor(String price) {
    return 'انضم مقابل $price';
  }

  @override
  String get joinForFreeQ => 'الانضمام مجانًا؟';

  @override
  String joinForQ(String price) {
    return 'الانضمام مقابل $price؟';
  }

  @override
  String get refundNote => 'إذا أُلغيت البطولة قبل أن تبدأ تسترد رسوم دخولك.';

  @override
  String get created => 'تم إنشاء البطولة. شارك الرابط أدناه لينضم الناس.';

  @override
  String get logoPending => 'الشعار بانتظار مراجعة الأمان: تراه أنت فقط';

  @override
  String fromTo(String start, String end, String d) {
    return '$start إلى $end  ($d)';
  }

  @override
  String get youreIn => 'أنت منضم';

  @override
  String get invitePeople => 'ادعُ الناس';

  @override
  String get shareLinkTitle => 'رابط المشاركة';

  @override
  String get shareLinkInfo =>
      'أرسل هذا الرابط عبر واتساب أو أي مكان. من لديه التطبيق يفتح هذه البطولة. يُطلب من الجدد التسجيل أولًا ثم الانضمام.\n\nيبدأ الرابط بالعمل عندما يصبح اللعب عبر الإنترنت متاحًا.';

  @override
  String get copyLink => 'نسخ الرابط';

  @override
  String get linkCopied => 'تم نسخ الرابط';

  @override
  String get prizes => 'الجوائز';

  @override
  String joinedCount(int n, int min, int max) {
    return 'انضم $n (الأقل $min، الأكثر $max)';
  }

  @override
  String get howItWorks => 'كيف تعمل';

  @override
  String get pointsTitle => 'النقاط والتعادل';

  @override
  String get pointsInfo =>
      'الفوز 3 نقاط، والتعادل 1، والخسارة 0. إذا تساوى اللاعبون في النقاط يتقدم صاحب الانتصارات الأكثر، ثم نتيجة المواجهة المباشرة، ثم قوة الخصوم، ثم المباريات الأقل، ثم من وصل إلى النتيجة أولًا. لذا يوجد دائمًا مركز أول واحد فقط.';

  @override
  String get arenaShort =>
      'الحلبة: انضم في أي وقت. العب أكبر عدد ممكن من المباريات. صاحب أكثر النقاط عند انتهاء الوقت يفوز.';

  @override
  String swissShort(int n) {
    return 'السويسري: $n جولات. في كل جولة تواجه لاعبًا نقاطه قريبة. انضم قبل الجولة الأولى.';
  }

  @override
  String get pointsLine => 'فوز = 3 نقاط · تعادل = 1 · خسارة = 0';

  @override
  String get voiceOn => 'الدردشة الصوتية مسموحة (بموافقة اللاعبين).';

  @override
  String get voiceOff => 'الدردشة الصوتية مغلقة في هذه البطولة.';

  @override
  String get watchNoDelay => 'المشاهدة المباشرة: بلا تأخير.';

  @override
  String watchDelayed(int n) {
    return 'المشاهدة المباشرة متأخرة $n ثانية.';
  }

  @override
  String get boardYouPlay => 'الرقعة التي ستلعب عليها';

  @override
  String get sameBoardTitle => 'رقعة واحدة للجميع';

  @override
  String get sameBoardInfo =>
      'يرى الجميع في هذه البطولة هذه الرقعة وهذه القطع، لتبقى اللعبة واضحة دائمًا. يعود اختيارك الخاص عندما تغادر.';

  @override
  String get yourMoney => 'أموالك (المنظِّم)';

  @override
  String get feesSoFar => 'رسوم الدخول حتى الآن';

  @override
  String get poolLocked => 'الجوائز المحجوزة';

  @override
  String get youWouldEnd => 'سيتبقى لك';
}
