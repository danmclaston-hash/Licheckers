// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class LEs extends L {
  LEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Licheckers';

  @override
  String get navPlay => 'Jugar';

  @override
  String get navTournaments => 'Torneos';

  @override
  String get navLearn => 'Aprender';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get infoTooltip => '¿Qué es esto?';

  @override
  String get gotIt => 'Entendido';

  @override
  String get cancel => 'Cancelar';

  @override
  String get back => 'Volver';

  @override
  String get create => 'Crear';

  @override
  String get add => 'Añadir';

  @override
  String get remove => 'Quitar';

  @override
  String get join => 'Unirse';

  @override
  String get white => 'Blancas';

  @override
  String get black => 'Negras';

  @override
  String get you => 'Tú';

  @override
  String get free => 'Gratis';

  @override
  String get none => 'Ninguno';

  @override
  String get all => 'Todos';

  @override
  String get variant_english => 'Inglesas (americanas)';

  @override
  String get variant_international => 'Internacionales';

  @override
  String get variant_brazilian => 'Brasileñas';

  @override
  String get variant_russian => 'Rusas';

  @override
  String get variant_italian => 'Italianas';

  @override
  String get variant_spanish => 'Españolas';

  @override
  String get variant_turkish => 'Turcas (Dama)';

  @override
  String get variant_frisian => 'Frisias';

  @override
  String get variant_canadian => 'Canadienses';

  @override
  String get tagFlyingKings => 'damas voladoras';

  @override
  String get tagShortKings => 'damas cortas';

  @override
  String get tagStraightMoves => 'movimientos en línea recta';

  @override
  String get tagCaptures8 => 'capturas en 8 direcciones';

  @override
  String get tagMenNoKings => 'los peones no capturan damas';

  @override
  String get tagFreeChoice => 'captura a elección';

  @override
  String get tagMenForward => 'los peones solo capturan hacia delante';

  @override
  String get tagMustTakeMost => 'hay que capturar el máximo';

  @override
  String get howToPlay => 'Cómo se juega';

  @override
  String ruleBoardDiag(int size, int count) {
    return 'Tablero: ${size}x$size. Cada jugador empieza con $count peones en las casillas oscuras.';
  }

  @override
  String ruleBoardAll(int size, int count) {
    return 'Tablero: ${size}x$size. Cada jugador empieza con $count peones, usando todas las casillas.';
  }

  @override
  String get ruleWhiteFirst => 'Empiezan las blancas.';

  @override
  String get ruleBlackFirst => 'Empiezan las negras.';

  @override
  String get ruleMenMoveDiag => 'Los peones avanzan una casilla en diagonal.';

  @override
  String get ruleMenMoveStraight =>
      'Los peones avanzan una casilla recto hacia delante o hacia el lado.';

  @override
  String get ruleMenCapture8 =>
      'Los peones capturan en las 8 direcciones: en diagonal y en línea recta.';

  @override
  String get ruleMenCaptureStraight =>
      'Los peones capturan saltando recto hacia delante o hacia el lado.';

  @override
  String get ruleMenCaptureBoth =>
      'Los peones capturan hacia delante y hacia atrás.';

  @override
  String get ruleMenCaptureForward => 'Los peones solo capturan hacia delante.';

  @override
  String get ruleMenNoKings => 'Un peón no puede capturar una dama.';

  @override
  String get ruleKingsFlyDiag =>
      'Las damas vuelan: se deslizan cualquier número de casillas vacías en diagonal y pueden capturar de lejos.';

  @override
  String get ruleKingsFlyStraight =>
      'Las damas vuelan: se deslizan cualquier número de casillas vacías en línea recta y pueden capturar de lejos.';

  @override
  String get ruleKingsShort =>
      'Las damas se mueven una casilla en cualquier diagonal.';

  @override
  String get ruleMustCapture =>
      'Si puedes capturar, debes hacerlo. Una cadena de capturas debe terminarse.';

  @override
  String get rulePriorityNone =>
      'Si hay varias capturas posibles, tú eliges cuál.';

  @override
  String get rulePriorityMax =>
      'Debes elegir la captura que se lleva más piezas.';

  @override
  String get rulePrioritySpanish =>
      'Debes capturar el máximo de piezas. Si hay empate, la captura con más damas.';

  @override
  String get rulePriorityItalian =>
      'Debes capturar el máximo de piezas. Si hay empate: capturar con dama, luego llevarse más damas, luego la cadena que encuentra antes una dama.';

  @override
  String get rulePriorityFrisian =>
      'Debes capturar el mayor valor (una dama vale algo menos que dos peones). Si hay empate, debe capturar una dama.';

  @override
  String get ruleRemoveAsJumped =>
      'Una pieza capturada sale del tablero en cuanto se salta.';

  @override
  String get ruleRemoveAfter =>
      'Las piezas capturadas se retiran juntas tras la jugada. Hasta entonces bloquean el paso y no pueden saltarse dos veces.';

  @override
  String get ruleNoTurnBack =>
      'Dentro de una captura no puedes volver atrás 180 grados.';

  @override
  String get rulePromoStop =>
      'Un peón que llega a la última fila se convierte en dama y la jugada termina.';

  @override
  String get rulePromoAsMan =>
      'Un peón solo se convierte en dama si su jugada TERMINA en la última fila. Si solo pasa por ella durante una captura, sigue siendo peón.';

  @override
  String get rulePromoAsKing =>
      'Un peón que llega a la última fila durante una captura se convierte en dama al instante y sigue capturando como dama.';

  @override
  String ruleKingLimit(int n) {
    return 'La misma dama solo puede hacer $n jugadas sin captura seguidas mientras tengas peones.';
  }

  @override
  String get ruleLose =>
      'Pierdes si te quedas sin piezas o sin jugadas legales.';

  @override
  String ruleDraw(int n) {
    return 'Tablas: la misma posición tres veces, o $n jugadas cada uno sin captura ni movimiento de peón.';
  }

  @override
  String get sectionGame => 'Partida';

  @override
  String get variantsInfoTitle => 'Variantes';

  @override
  String get variantsInfoText =>
      'Las damas se juegan con reglas distintas en el mundo. Elige una aquí. Abre Aprender para leer las reglas de cada juego.';

  @override
  String get opponent => 'Rival';

  @override
  String get computer => 'Ordenador';

  @override
  String get twoPlayers => 'Dos jugadores';

  @override
  String get botLevelsTitle => 'Niveles del ordenador';

  @override
  String get botLevelsText =>
      'Hay 18 jugadores del ordenador. El nivel 1 juega casi al azar. Los niveles altos ven más jugadas por delante y fallan menos. Los más altos piensan unos segundos.';

  @override
  String levelN(int n) {
    return 'Nivel $n';
  }

  @override
  String get passDevice => 'Pasa el dispositivo tras cada jugada.';

  @override
  String get yourColour => 'Tu color';

  @override
  String get startGame => 'Empezar partida';

  @override
  String get bot1 => 'Juega casi al azar y le encanta regalar piezas.';

  @override
  String get bot2 => 'Solo viene a pasarlo bien. Cae a menudo en tus capturas.';

  @override
  String get bot3 => 'Aprende lo básico. Sabe que capturar es bueno.';

  @override
  String get bot4 => 'El jugador medio del parque. Sólido pero previsible.';

  @override
  String get bot5 =>
      'Empieza a buscar capturas dobles y el control del centro.';

  @override
  String get bot6 =>
      'Muy prudente. Prefiere mantener las piezas en la última fila.';

  @override
  String get bot7 => 'Ataca sin parar. Le gusta forzar cambios.';

  @override
  String get bot8 => 'Un habitual del club de damas del barrio.';

  @override
  String get bot9 => 'Estudia la teoría. Muy eficaz en el final.';

  @override
  String get bot10 => 'Campeón regional. Muy pocos errores.';

  @override
  String get bot11 =>
      'Visión táctica profunda. Atrapará tu dama con facilidad.';

  @override
  String get bot12 => 'Ve lejos. Controla el ritmo de la partida.';

  @override
  String get bot13 =>
      'Fuerza de nivel nacional. Increíblemente difícil de ganar.';

  @override
  String get bot14 =>
      'Posicionamiento de nivel mundial. Cada jugada tiene un propósito.';

  @override
  String get bot15 => 'Reconoce patrones como una máquina. Implacable.';

  @override
  String get bot16 => 'Una fiera. Castiga la más mínima imprecisión.';

  @override
  String get bot17 => 'Cálculo de nivel de superordenador.';

  @override
  String get bot18 =>
      'El ordenador más fuerte: piensa tan hondo como el tiempo permite.';

  @override
  String get noGame => 'No hay partida';

  @override
  String get moves => 'Jugadas';

  @override
  String get mustCapture => 'Debes capturar';

  @override
  String isThinking(String name) {
    return '$name está pensando…';
  }

  @override
  String toMove(String name) {
    return 'Turno de $name';
  }

  @override
  String drawBecause(String reason) {
    return 'Tablas · $reason';
  }

  @override
  String wonBecause(String name, String reason) {
    return '$name gana · $reason';
  }

  @override
  String get reasonResign => 'abandono';

  @override
  String get reasonNoMoves => 'sin jugadas legales';

  @override
  String get reasonRepetition => 'misma posición tres veces';

  @override
  String reasonNoProgress(int n) {
    return '$n jugadas cada uno sin progreso';
  }

  @override
  String get undo => 'Deshacer';

  @override
  String get playAgain => 'Jugar otra vez';

  @override
  String get resign => 'Abandonar';

  @override
  String get resignQ => '¿Abandonar esta partida?';

  @override
  String get resignBody => 'Tu rival gana.';

  @override
  String get keepPlaying => 'Seguir jugando';

  @override
  String get noMovesYet => 'Aún no hay jugadas';

  @override
  String get language => 'Idioma';

  @override
  String get languagePhone => 'Idioma del teléfono';

  @override
  String get translationNote =>
      'Las traducciones son nuevas. Algunas palabras aún pueden necesitar revisión de un hablante nativo.';

  @override
  String get display => 'Pantalla';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get textSize => 'Tamaño del texto';

  @override
  String get showInfo => 'Mostrar botones de información';

  @override
  String get showInfoSub => 'Los pequeños botones (i) que explican las cosas';

  @override
  String get boardAndPieces => 'Tablero y piezas';

  @override
  String get yourLookTitle => 'Solo tu pantalla';

  @override
  String get yourLookText =>
      'Estas opciones solo cambian tu pantalla. En una partida en línea tu rival conserva su propio tablero y piezas.';

  @override
  String get board => 'Tablero';

  @override
  String get pieces => 'Piezas';

  @override
  String get squareNumbers => 'Números de casillas';

  @override
  String get showLegal => 'Mostrar jugadas legales';

  @override
  String get showLegalSub =>
      'Puntos donde puede ir una pieza y un anillo en las piezas que deben capturar';

  @override
  String get pieceAnimation => 'Animación de piezas';

  @override
  String get animOff => 'No';

  @override
  String get animFast => 'Rápida';

  @override
  String get animNormal => 'Normal';

  @override
  String get animSlow => 'Lenta';

  @override
  String get rulesOfVariants => 'Reglas de cada variante';

  @override
  String get rulesOfVariantsSub => 'Cómo se juega cada uno de los 9 juegos';

  @override
  String get installApp => 'Instalar app';

  @override
  String get installAppSub =>
      'Pon Licheckers en tu pantalla de inicio. Funciona sin conexión.';

  @override
  String get board_walnut => 'Nogal';

  @override
  String get board_forest => 'Bosque';

  @override
  String get board_ocean => 'Océano';

  @override
  String get board_midnight => 'Medianoche';

  @override
  String get board_sunset => 'Atardecer';

  @override
  String get board_clear_green => 'Verde nítido';

  @override
  String get board_clear_brown => 'Marrón nítido';

  @override
  String get board_clear_blue => 'Azul nítido';

  @override
  String get board_clear_red => 'Rojo nítido';

  @override
  String get board_contrast => 'Alto contraste';

  @override
  String get piece_classic => 'Clásicas';

  @override
  String get piece_wood => 'Madera';

  @override
  String get piece_glass => 'Cristal';

  @override
  String get piece_ruby => 'Marfil y rubí';

  @override
  String get piece_flat => 'Planas';

  @override
  String get installTitle => 'Instalar Licheckers';

  @override
  String get installBody =>
      'Abre más rápido, funciona sin conexión y no necesita tienda de apps.';

  @override
  String get installNow => 'Instalar';

  @override
  String get notNow => 'Ahora no';

  @override
  String get installIosTitle => 'Añadir a la pantalla de inicio';

  @override
  String get installIosBody =>
      'En Safari, toca el botón Compartir y luego “Añadir a pantalla de inicio”.';

  @override
  String get installDone => 'Licheckers está instalado.';

  @override
  String get clock_bullet => 'Bala';

  @override
  String get clock_blitz => 'Blitz';

  @override
  String get clock_rapid => 'Rápido';

  @override
  String get clock_classic => 'Clásico';

  @override
  String startsIn(String time) {
    return 'Empieza en $time';
  }

  @override
  String liveEndsIn(String time) {
    return 'En directo: termina en $time';
  }

  @override
  String get finished => 'Terminado';

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
    String _temp0 = intl.Intl.selectLogic(n, {'other': '$n.º'});
    return '$_temp0';
  }

  @override
  String get arena => 'Arena';

  @override
  String get swiss => 'Suizo';

  @override
  String get createTournament => 'Crear un torneo';

  @override
  String get demoNote =>
      'Demo: torneos de ejemplo y aún sin dinero real. El juego en línea y los pagos llegarán con el servidor.';

  @override
  String get clockTypesTitle => 'Tipos de reloj';

  @override
  String get clockTypesText =>
      'Bala: 1 a 2 minutos cada uno, muy rápido.\nBlitz: 3 a 5 minutos cada uno.\nRápido: 10 a 15 minutos cada uno.\nClásico: 20 a 30 minutos cada uno.\n\nUn segundo número como 3+2 significa que se suman 2 segundos tras cada jugada.';

  @override
  String get noTournamentsOfType => 'Aún no hay torneos de este tipo.';

  @override
  String get yours => 'Tuyo';

  @override
  String get joinedTag => 'Inscrito';

  @override
  String presentedBy(String names) {
    return 'Presentado por $names';
  }

  @override
  String hostedBy(String host) {
    return 'Organiza $host';
  }

  @override
  String get entry => 'Inscripción';

  @override
  String get prizePool => 'Bolsa de premios';

  @override
  String get players => 'Jugadores';

  @override
  String get createTitle => 'Crear torneo';

  @override
  String get secAbout => '1. Datos';

  @override
  String get tournamentName => 'Nombre del torneo';

  @override
  String get secFormat => '2. Formato';

  @override
  String get arenaInfo =>
      'Únete cuando quieras antes del final. Juega tantas partidas como puedas. Ganar da 3 puntos, tablas 1, perder 0. Quien tenga más puntos al acabar el reloj gana.\n\nIdeal para mucha gente, porque se puede llegar tarde.';

  @override
  String get swissInfo =>
      'Un número fijo de rondas. En cada ronda juegas con alguien de puntuación parecida. Todos juegan todas las rondas. Quien tenga más puntos tras la última ronda gana.\n\nIdeal para eventos pequeños y serios (hasta unos 200 jugadores). Solo puedes unirte antes de la ronda 1.';

  @override
  String get notEnoughRounds =>
      'No hay tiempo para 3 rondas. Alarga el torneo o acelera el reloj.';

  @override
  String roundsFit(int n, int max) {
    return 'Rondas: $n (caben hasta $max)';
  }

  @override
  String get secClock => '3. Reloj';

  @override
  String get clockTitle => 'Reloj';

  @override
  String get clockInfo =>
      'Cada partida del torneo tiene reloj, para que un jugador lento no frene todo el evento. El segundo número son los segundos que se suman tras cada jugada.';

  @override
  String minutesPerPlayer(int n) {
    return 'Minutos por jugador: $n';
  }

  @override
  String secondsAdded(int n) {
    return 'Segundos sumados por jugada: $n';
  }

  @override
  String longGame(String clock, int n) {
    return '$clock. Una partida larga dura unos $n minutos.';
  }

  @override
  String get secWhen => '4. Cuándo';

  @override
  String get whenTitle => 'Inicio y duración';

  @override
  String get whenInfo =>
      'Los torneos son cortos a propósito: de 30 minutos a 4 horas. Los jugadores ven una cuenta atrás hasta el inicio y luego hasta el final. En los últimos minutos no se emparejan partidas nuevas; las que están en juego pueden terminar.';

  @override
  String get in1h => 'En 1 hora';

  @override
  String get in3h => 'En 3 horas';

  @override
  String get in8h => 'En 8 horas';

  @override
  String get pickDateTime => 'Elegir fecha y hora';

  @override
  String startsAt(String time) {
    return 'Empieza: $time';
  }

  @override
  String lengthIs(String d) {
    return 'Duración: $d';
  }

  @override
  String endsAt(String time) {
    return 'Termina: $time';
  }

  @override
  String roundsFitIn(int n, String d) {
    return 'Caben unas $n rondas en $d.';
  }

  @override
  String get secMoney => '5. Jugadores y dinero';

  @override
  String get moneyTitle => 'Cómo funciona el dinero';

  @override
  String moneyInfo(int pct) {
    return 'Al crear el torneo bloqueas toda la bolsa de premios. Los jugadores pagan la inscripción para entrar. A los ganadores se les paga con tu bolsa bloqueada. Las inscripciones son tuyas. La plataforma se queda el $pct% solo de tu beneficio (inscripciones menos premios). Si las inscripciones no cubren la bolsa, la plataforma no se lleva nada.\n\nSi el torneo se cancela antes de empezar, se devuelve el dinero a todos. Una vez empezado, el dinero queda bloqueado.';
  }

  @override
  String get minPlayers => 'Mín. de jugadores';

  @override
  String get maxPlayers => 'Máx. de jugadores';

  @override
  String get entryFee => 'Inscripción';

  @override
  String get winnerSplit => 'Reparto de premios';

  @override
  String get winnerSplitInfo =>
      'Cómo se reparte la bolsa entre los primeros puestos. Lo que sobre del redondeo va al primer puesto.';

  @override
  String get split_winner => 'El ganador se lo lleva todo';

  @override
  String get split_top3 => 'Top 3';

  @override
  String get split_top5 => 'Top 5';

  @override
  String get whatIf => '¿Y si se unen tantos jugadores?';

  @override
  String get whatIfTitle => 'Tu dinero, calculado';

  @override
  String get whatIfInfo =>
      'Mueve el control para ver cuánto ganarías. La parte de la plataforma sale solo de tu beneficio.';

  @override
  String get feesCollected => 'Inscripciones cobradas';

  @override
  String get poolYouLocked => 'Bolsa que bloqueaste';

  @override
  String platformShare(int pct) {
    return 'Parte de la plataforma ($pct% del beneficio)';
  }

  @override
  String get youEndWith => 'Te quedas con';

  @override
  String breakEven(int n) {
    return 'Recuperas tu dinero con $n jugadores. Por debajo pierdes parte de la bolsa.';
  }

  @override
  String get secBoard => '6. Tablero y piezas';

  @override
  String get whyOnlyThese => '¿Por qué solo estos?';

  @override
  String get whyOnlyTheseInfo =>
      'Todos en el torneo juegan en el mismo tablero, para que siempre se vean bien las casillas y las piezas. Solo ofrecemos tableros y piezas que pasan nuestras pruebas de legibilidad. Los patrocinadores nunca pueden cambiar el tablero.';

  @override
  String piecesNamed(String name) {
    return 'Piezas $name';
  }

  @override
  String get check_whiteOnDark =>
      'Las piezas blancas destacan sobre las casillas oscuras';

  @override
  String get check_blackOnDark =>
      'Las piezas negras destacan sobre las casillas oscuras';

  @override
  String get check_sidesApart =>
      'Es fácil distinguir las piezas blancas de las negras';

  @override
  String get check_squaresApart =>
      'Es fácil distinguir las casillas claras de las oscuras';

  @override
  String checkLine(String label, String value, String need) {
    return '$label ($value : 1, necesita $need)';
  }

  @override
  String get secSponsor => '7. Patrocinador (opcional)';

  @override
  String get sponsoredTitle => 'Torneos patrocinados';

  @override
  String sponsoredInfo(String theme, String pieces) {
    return 'Un patrocinador cambia el aspecto de la app solo en este torneo: colores, logotipo y franja con su nombre, y si quiere su nombre en las piezas. Las casillas del tablero nunca cambian. Nunca hay ventanas emergentes, vídeos ni sonidos, y nada tapa el tablero ni los relojes. Cuando un jugador sale del torneo, la app vuelve a la normalidad.\n\nPrecio: $theme por patrocinador, más $pieces por patrocinador para poner su nombre en las piezas. Las imágenes se revisan primero, así que un torneo patrocinado debe empezar al menos 6 horas después de ahora.';
  }

  @override
  String get noSponsor => 'Sin patrocinador';

  @override
  String get oneSponsor => 'Un patrocinador';

  @override
  String get twoSponsors => 'Dos patrocinadores (mitad cada uno)';

  @override
  String get sponsorName => 'Nombre del patrocinador';

  @override
  String get sponsor1Name => 'Nombre del patrocinador 1 (lado blanco)';

  @override
  String get sponsor2Name => 'Nombre del patrocinador 2 (lado negro)';

  @override
  String get sponsor => 'Patrocinador';

  @override
  String get sponsor1 => 'Patrocinador 1';

  @override
  String get sponsor2 => 'Patrocinador 2';

  @override
  String nameOnPieces(String price) {
    return 'Nombre en las piezas (+$price)';
  }

  @override
  String nameOnWhite(String price) {
    return 'Nombre en las piezas blancas (+$price)';
  }

  @override
  String nameOnBlack(String price) {
    return 'Nombre en las piezas negras (+$price)';
  }

  @override
  String upToLetters(int n) {
    return 'Hasta $n letras, con prueba de legibilidad';
  }

  @override
  String sponsorTotal(String price) {
    return 'Total del patrocinio: $price';
  }

  @override
  String get logoRules =>
      'Logotipos: PNG, JPG o WebP, de menos de 2 MB. Una persona revisa cada logotipo (sin contenido adulto, sin marcas falsas) antes de que otros jugadores lo vean.';

  @override
  String get upload => 'Subir';

  @override
  String get fromLink => 'Desde un enlace';

  @override
  String get logoColour => 'Color del logotipo';

  @override
  String get logoAdded =>
      'El color del logotipo es ahora el color del torneo. El logotipo espera una revisión de seguridad por una persona: hasta entonces solo tú lo ves.';

  @override
  String get linkTitle => 'Añadir una imagen desde un enlace';

  @override
  String get linkHelp =>
      'Pega la dirección de la propia imagen (suele terminar en .png o .jpg). Algunos sitios impiden que otras apps usen sus imágenes. Si pasa, descarga la imagen y usa Subir.';

  @override
  String somethingWrong(String error) {
    return 'Algo salió mal: $error';
  }

  @override
  String get secOptions => '8. Opciones';

  @override
  String get allowVoice => 'Permitir chat de voz en las partidas';

  @override
  String get allowVoiceSub => 'Los jugadores siguen eligiendo si hablan o no';

  @override
  String get watchDelay => 'Retraso de la emisión';

  @override
  String get watchDelayTitle => 'Retraso de la emisión';

  @override
  String get watchDelayInfo =>
      'Otras personas pueden ver en directo las mejores partidas. En los torneos de pago lo ven con unos segundos de retraso, para que nadie le sople la mejor jugada a un jugador.';

  @override
  String seconds(int n) {
    return '$n s';
  }

  @override
  String moreProblems(String first, int n) {
    return '$first  (+$n más)';
  }

  @override
  String get youPayNow => 'Pagas ahora';

  @override
  String get lockAndCreate => 'Bloquear premios y crear';

  @override
  String get confirmTitle => '¿Bloquear los premios y crear?';

  @override
  String confirmPay(String total) {
    return 'Pagas $total ahora:';
  }

  @override
  String confirmPool(String amount) {
    return 'Premios (bloqueados): $amount';
  }

  @override
  String confirmFee(String amount) {
    return 'Tarifa de creación: $amount';
  }

  @override
  String confirmSponsor(String amount) {
    return 'Aspecto del patrocinador: $amount';
  }

  @override
  String get confirmRules =>
      'Si el torneo se cancela antes de empezar, cada jugador recupera su inscripción y la bolsa vuelve a ti. Una vez empezado, la bolsa queda bloqueada hasta que se paga a los ganadores.';

  @override
  String get demoNoMoney => 'Demo: aún no se mueve dinero real.';

  @override
  String get p_nameShort => 'Ponle nombre al torneo (3 letras o más).';

  @override
  String p_clockRange(String type) {
    return 'El reloj está fuera del rango $type.';
  }

  @override
  String get p_lengthRange =>
      'La duración debe estar entre 30 minutos y 4 horas.';

  @override
  String get p_startSoon => 'Empieza al menos 30 minutos después de ahora.';

  @override
  String get p_sponsoredStartSoon =>
      'Los torneos patrocinados deben empezar al menos 6 horas después de ahora, para revisar las imágenes.';

  @override
  String p_swissFew(int n) {
    return 'Solo caben $n rondas suizas. Alárgalo o acelera el reloj.';
  }

  @override
  String p_swissTooMany(int n) {
    return 'Caben como mucho $n rondas en este tiempo.';
  }

  @override
  String get p_arenaTooSlow =>
      'Este reloj es demasiado lento para esta duración. Alarga el torneo o acelera el reloj.';

  @override
  String get p_minPlayers => 'Hacen falta al menos 2 jugadores.';

  @override
  String get p_maxBelowMin =>
      'El máximo de jugadores debe ser al menos el mínimo.';

  @override
  String p_poolTooSmall(String amount) {
    return 'La bolsa de premios debe ser de al menos $amount.';
  }

  @override
  String p_prizesNeedPlayers(int n) {
    return '$n premios necesitan al menos $n jugadores.';
  }

  @override
  String get p_boardUnclear =>
      'Este tablero y estas piezas no son lo bastante nítidos. Elige otra pareja.';

  @override
  String get p_sponsorName => 'Escribe el nombre del patrocinador.';

  @override
  String get p_sponsor2Name => 'Escribe el nombre del segundo patrocinador.';

  @override
  String p_whiteLabel(String problem) {
    return 'Piezas blancas: $problem';
  }

  @override
  String p_blackLabel(String problem) {
    return 'Piezas negras: $problem';
  }

  @override
  String lbl_empty(int n) {
    return 'Escribe un nombre corto (hasta $n letras).';
  }

  @override
  String lbl_tooLong(int n) {
    return 'Demasiado largo: como mucho $n letras para que se vea la corona de la dama.';
  }

  @override
  String get lbl_unreadable =>
      'Este nombre se leería mal en estas piezas. Elige otras piezas.';

  @override
  String get e_svg =>
      'Los archivos SVG se aceptarán cuando el servidor pueda convertirlos con seguridad. Por ahora usa PNG o JPG.';

  @override
  String get e_type => 'Usa una imagen PNG, JPG o WebP.';

  @override
  String get e_big => 'La imagen es demasiado grande. Que pese menos de 2 MB.';

  @override
  String get e_empty => 'El archivo está vacío.';

  @override
  String get e_https => 'Usa un enlace completo que empiece por https://';

  @override
  String get e_link =>
      'No se pudo cargar ese enlace. Algunos sitios impiden que otras apps usen sus imágenes. Descarga la imagen y usa Subir.';

  @override
  String e_http(String code) {
    return 'El sitio respondió con un error ($code).';
  }

  @override
  String get e_webpage =>
      'Ese enlace es una página web, no una imagen. Abre la propia imagen y copia su dirección.';

  @override
  String get e_notPicture => 'Este archivo no es una imagen que podamos leer.';

  @override
  String get joinForFree => 'Unirse gratis';

  @override
  String joinFor(String price) {
    return 'Unirse por $price';
  }

  @override
  String get joinForFreeQ => '¿Unirse gratis?';

  @override
  String joinForQ(String price) {
    return '¿Unirse por $price?';
  }

  @override
  String get refundNote =>
      'Si el torneo se cancela antes de empezar, te devolvemos la inscripción.';

  @override
  String get created =>
      'Torneo creado. Comparte el enlace de abajo para que la gente se una.';

  @override
  String get logoPending => 'Logotipo pendiente de revisión: solo tú lo ves';

  @override
  String fromTo(String start, String end, String d) {
    return '$start a $end  ($d)';
  }

  @override
  String get youreIn => 'Estás dentro';

  @override
  String get invitePeople => 'Invitar a gente';

  @override
  String get shareLinkTitle => 'Enlace para compartir';

  @override
  String get shareLinkInfo =>
      'Envía este enlace por WhatsApp o donde quieras. Quien ya tiene la app abre este torneo. A los nuevos se les pide registrarse primero y luego unirse.\n\nEl enlace funcionará cuando el juego en línea esté activo.';

  @override
  String get copyLink => 'Copiar enlace';

  @override
  String get linkCopied => 'Enlace copiado';

  @override
  String get prizes => 'Premios';

  @override
  String joinedCount(int n, int min, int max) {
    return '$n inscritos (mín. $min, máx. $max)';
  }

  @override
  String get howItWorks => 'Cómo funciona';

  @override
  String get pointsTitle => 'Puntos y desempates';

  @override
  String get pointsInfo =>
      'Ganar 3 puntos, tablas 1, perder 0. Con los mismos puntos, va delante quien tiene más victorias, luego el enfrentamiento directo, luego la fuerza de los rivales, luego menos partidas, luego quien llegó antes a esa puntuación. Así siempre hay un solo primer puesto.';

  @override
  String get arenaShort =>
      'Arena: únete cuando quieras. Juega tantas partidas como puedas. Quien tenga más puntos al acabar el reloj gana.';

  @override
  String swissShort(int n) {
    return 'Suizo: $n rondas. En cada ronda juegas con alguien de puntuación parecida. Únete antes de la ronda 1.';
  }

  @override
  String get pointsLine => 'Ganar = 3 puntos · Tablas = 1 · Perder = 0';

  @override
  String get voiceOn =>
      'El chat de voz está permitido (si ambos jugadores aceptan).';

  @override
  String get voiceOff => 'El chat de voz está desactivado en este torneo.';

  @override
  String get watchNoDelay => 'En directo: sin retraso.';

  @override
  String watchDelayed(int n) {
    return 'La emisión va $n segundos retrasada.';
  }

  @override
  String get boardYouPlay => 'El tablero en el que jugarás';

  @override
  String get sameBoardTitle => 'El mismo tablero para todos';

  @override
  String get sameBoardInfo =>
      'Todos en este torneo ven este tablero y estas piezas, para que la partida esté siempre clara. Tu propia elección vuelve cuando sales.';

  @override
  String get yourMoney => 'Tu dinero (organizador)';

  @override
  String get feesSoFar => 'Inscripciones hasta ahora';

  @override
  String get poolLocked => 'Bolsa bloqueada';

  @override
  String get youWouldEnd => 'Te quedarías con';

  @override
  String get quickEasy => 'Fácil';

  @override
  String get quickMedium => 'Medio';

  @override
  String get quickHard => 'Difícil';

  @override
  String get twoPlayersSub => 'un dispositivo';

  @override
  String get customTile => 'Personalizada';

  @override
  String get customSub => 'tus opciones';

  @override
  String get customTitle => 'Partida personalizada';

  @override
  String get chooseVariant => 'Elegir un juego';

  @override
  String get nextTournament => 'Próximo torneo';

  @override
  String get noClock => 'Sin reloj';

  @override
  String get reasonTimeout => 'se acabó el tiempo';

  @override
  String get newGame => 'Nueva partida';

  @override
  String get sounds => 'Sonidos y vibración';

  @override
  String get soundsSub =>
      'Jugadas, capturas, damas, poco tiempo y fin de partida';

  @override
  String get prevMove => 'Jugada anterior';

  @override
  String get nextMove => 'Jugada siguiente';

  @override
  String get backToGame => 'Volver a la partida';
}
