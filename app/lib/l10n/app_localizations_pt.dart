// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class LPt extends L {
  LPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Licheckers';

  @override
  String get navPlay => 'Jogar';

  @override
  String get navTournaments => 'Torneios';

  @override
  String get navLearn => 'Aprender';

  @override
  String get navSettings => 'Definições';

  @override
  String get infoTooltip => 'O que é isto?';

  @override
  String get gotIt => 'Entendi';

  @override
  String get cancel => 'Cancelar';

  @override
  String get back => 'Voltar';

  @override
  String get create => 'Criar';

  @override
  String get add => 'Adicionar';

  @override
  String get remove => 'Remover';

  @override
  String get join => 'Entrar';

  @override
  String get white => 'Brancas';

  @override
  String get black => 'Pretas';

  @override
  String get you => 'Você';

  @override
  String get free => 'Grátis';

  @override
  String get none => 'Nenhum';

  @override
  String get all => 'Todos';

  @override
  String get variant_english => 'Inglesas (americanas)';

  @override
  String get variant_international => 'Internacionais';

  @override
  String get variant_brazilian => 'Brasileiras';

  @override
  String get variant_russian => 'Russas';

  @override
  String get variant_italian => 'Italianas';

  @override
  String get variant_spanish => 'Espanholas';

  @override
  String get variant_turkish => 'Turcas (Dama)';

  @override
  String get variant_frisian => 'Frísias';

  @override
  String get variant_canadian => 'Canadenses';

  @override
  String get tagFlyingKings => 'damas voadoras';

  @override
  String get tagShortKings => 'damas curtas';

  @override
  String get tagStraightMoves => 'movimentos em linha reta';

  @override
  String get tagCaptures8 => 'capturas em 8 direções';

  @override
  String get tagMenNoKings => 'pedras não capturam damas';

  @override
  String get tagFreeChoice => 'captura à escolha';

  @override
  String get tagMenForward => 'pedras só capturam para a frente';

  @override
  String get tagMustTakeMost => 'capturar o máximo é obrigatório';

  @override
  String get howToPlay => 'Como jogar';

  @override
  String ruleBoardDiag(int size, int count) {
    return 'Tabuleiro: ${size}x$size. Cada jogador começa com $count pedras nas casas escuras.';
  }

  @override
  String ruleBoardAll(int size, int count) {
    return 'Tabuleiro: ${size}x$size. Cada jogador começa com $count pedras, usando todas as casas.';
  }

  @override
  String get ruleWhiteFirst => 'As brancas começam.';

  @override
  String get ruleBlackFirst => 'As pretas começam.';

  @override
  String get ruleMenMoveDiag =>
      'As pedras andam uma casa na diagonal para a frente.';

  @override
  String get ruleMenMoveStraight =>
      'As pedras andam uma casa em frente ou para o lado.';

  @override
  String get ruleMenCapture8 =>
      'As pedras capturam nas 8 direções: na diagonal e em linha reta.';

  @override
  String get ruleMenCaptureStraight =>
      'As pedras capturam saltando em frente ou para o lado.';

  @override
  String get ruleMenCaptureBoth =>
      'As pedras capturam para a frente e para trás.';

  @override
  String get ruleMenCaptureForward => 'As pedras só capturam para a frente.';

  @override
  String get ruleMenNoKings => 'Uma pedra não pode capturar uma dama.';

  @override
  String get ruleKingsFlyDiag =>
      'As damas voam: deslizam quantas casas vazias quiserem na diagonal e podem capturar de longe.';

  @override
  String get ruleKingsFlyStraight =>
      'As damas voam: deslizam quantas casas vazias quiserem em linha reta e podem capturar de longe.';

  @override
  String get ruleKingsShort => 'As damas andam uma casa em qualquer diagonal.';

  @override
  String get ruleMustCapture =>
      'Se puder capturar, tem de capturar. Uma sequência de capturas tem de ser terminada.';

  @override
  String get rulePriorityNone =>
      'Se houver várias capturas possíveis, você escolhe qual.';

  @override
  String get rulePriorityMax =>
      'Tem de escolher a captura que leva mais peças.';

  @override
  String get rulePrioritySpanish =>
      'Tem de capturar o máximo de peças. Se empatar, a captura com mais damas.';

  @override
  String get rulePriorityItalian =>
      'Tem de capturar o máximo de peças. Se empatar: capturar com a dama, depois levar mais damas, depois a sequência que encontra uma dama primeiro.';

  @override
  String get rulePriorityFrisian =>
      'Tem de capturar o maior valor (uma dama vale um pouco menos que duas pedras). Se empatar, é a dama que captura.';

  @override
  String get ruleRemoveAsJumped =>
      'Uma peça capturada sai do tabuleiro no momento em que é saltada.';

  @override
  String get ruleRemoveAfter =>
      'As peças capturadas saem juntas depois da jogada. Até lá bloqueiam o caminho e não podem ser saltadas duas vezes.';

  @override
  String get ruleNoTurnBack =>
      'Dentro de uma captura não pode voltar para trás 180 graus.';

  @override
  String get rulePromoStop =>
      'Uma pedra que chega à última fila vira dama e a jogada termina.';

  @override
  String get rulePromoAsMan =>
      'Uma pedra só vira dama se a jogada TERMINAR na última fila. Se só passar por lá numa captura, continua pedra.';

  @override
  String get rulePromoAsKing =>
      'Uma pedra que chega à última fila durante uma captura vira dama na hora e continua a capturar como dama.';

  @override
  String ruleKingLimit(int n) {
    return 'A mesma dama só pode fazer $n jogadas sem captura seguidas enquanto você ainda tiver pedras.';
  }

  @override
  String get ruleLose => 'Perde quem fica sem peças ou sem jogadas possíveis.';

  @override
  String ruleDraw(int n) {
    return 'Empate: a mesma posição três vezes, ou $n jogadas de cada um sem captura e sem mover pedra.';
  }

  @override
  String get sectionGame => 'Jogo';

  @override
  String get variantsInfoTitle => 'Variantes';

  @override
  String get variantsInfoText =>
      'As damas jogam-se com regras diferentes pelo mundo. Escolha uma aqui. Abra Aprender para ler as regras de cada jogo.';

  @override
  String get opponent => 'Adversário';

  @override
  String get computer => 'Computador';

  @override
  String get twoPlayers => 'Dois jogadores';

  @override
  String get botLevelsTitle => 'Níveis do computador';

  @override
  String get botLevelsText =>
      'Há 18 jogadores do computador. O nível 1 joga quase ao acaso. Os níveis mais altos veem mais jogadas à frente e erram menos. Os mais altos pensam alguns segundos.';

  @override
  String levelN(int n) {
    return 'Nível $n';
  }

  @override
  String get passDevice => 'Passe o aparelho depois de cada jogada.';

  @override
  String get yourColour => 'A sua cor';

  @override
  String get startGame => 'Começar jogo';

  @override
  String get bot1 => 'Joga quase ao acaso e adora entregar peças.';

  @override
  String get bot2 =>
      'Só está aqui para se divertir. Cai muitas vezes nas suas capturas.';

  @override
  String get bot3 => 'Está a aprender o básico. Sabe que capturar é bom.';

  @override
  String get bot4 => 'O jogador médio da praça. Sólido mas previsível.';

  @override
  String get bot5 =>
      'Começa a procurar capturas duplas e o controle do centro.';

  @override
  String get bot6 => 'Muito cauteloso. Prefere manter as peças na última fila.';

  @override
  String get bot7 => 'Ataca sem parar. Gosta de forçar trocas.';

  @override
  String get bot8 => 'Frequentador do clube de damas do bairro.';

  @override
  String get bot9 => 'Estuda a teoria. Muito eficiente no final.';

  @override
  String get bot10 => 'Campeão regional. Pouquíssimos erros.';

  @override
  String get bot11 =>
      'Visão tática profunda. Vai prender a sua dama com facilidade.';

  @override
  String get bot12 => 'Vê longe. Controla o ritmo do jogo.';

  @override
  String get bot13 => 'Força de nível nacional. Muito difícil de vencer.';

  @override
  String get bot14 =>
      'Posicionamento de nível mundial. Cada jogada tem um propósito.';

  @override
  String get bot15 => 'Reconhece padrões como uma máquina. Implacável.';

  @override
  String get bot16 => 'Uma fera. Castiga a menor imprecisão.';

  @override
  String get bot17 => 'Cálculo de nível de supercomputador.';

  @override
  String get bot18 =>
      'O computador mais forte aqui: pensa tão fundo quanto o tempo deixa.';

  @override
  String get noGame => 'Nenhum jogo';

  @override
  String get moves => 'Jogadas';

  @override
  String get mustCapture => 'Tem de capturar';

  @override
  String isThinking(String name) {
    return '$name está a pensar…';
  }

  @override
  String toMove(String name) {
    return 'Vez de $name';
  }

  @override
  String drawBecause(String reason) {
    return 'Empate · $reason';
  }

  @override
  String wonBecause(String name, String reason) {
    return '$name venceu · $reason';
  }

  @override
  String get reasonResign => 'desistência';

  @override
  String get reasonNoMoves => 'sem jogadas possíveis';

  @override
  String get reasonRepetition => 'mesma posição três vezes';

  @override
  String reasonNoProgress(int n) {
    return '$n jogadas de cada um sem progresso';
  }

  @override
  String get undo => 'Desfazer';

  @override
  String get playAgain => 'Jogar de novo';

  @override
  String get resign => 'Desistir';

  @override
  String get resignQ => 'Desistir deste jogo?';

  @override
  String get resignBody => 'O seu adversário vence.';

  @override
  String get keepPlaying => 'Continuar a jogar';

  @override
  String get noMovesYet => 'Ainda sem jogadas';

  @override
  String get language => 'Idioma';

  @override
  String get languagePhone => 'Idioma do telefone';

  @override
  String get translationNote =>
      'As traduções são novas. Algumas palavras ainda podem precisar de revisão por um falante nativo.';

  @override
  String get display => 'Ecrã';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Escuro';

  @override
  String get textSize => 'Tamanho do texto';

  @override
  String get showInfo => 'Mostrar botões de informação';

  @override
  String get showInfoSub => 'Os pequenos botões (i) que explicam as coisas';

  @override
  String get boardAndPieces => 'Tabuleiro e peças';

  @override
  String get yourLookTitle => 'Só o seu ecrã';

  @override
  String get yourLookText =>
      'Estas escolhas só mudam o seu ecrã. Num jogo online o adversário mantém o seu próprio tabuleiro e peças.';

  @override
  String get board => 'Tabuleiro';

  @override
  String get pieces => 'Peças';

  @override
  String get squareNumbers => 'Números das casas';

  @override
  String get showLegal => 'Mostrar jogadas possíveis';

  @override
  String get showLegalSub =>
      'Pontos onde a peça pode ir, e um anel nas peças que têm de capturar';

  @override
  String get pieceAnimation => 'Animação das peças';

  @override
  String get animOff => 'Desligada';

  @override
  String get animFast => 'Rápida';

  @override
  String get animNormal => 'Normal';

  @override
  String get animSlow => 'Lenta';

  @override
  String get rulesOfVariants => 'Regras de cada variante';

  @override
  String get rulesOfVariantsSub => 'Como se joga cada um dos 9 jogos';

  @override
  String get installApp => 'Instalar app';

  @override
  String get installAppSub =>
      'Ponha o Licheckers no ecrã inicial. Funciona offline.';

  @override
  String get board_walnut => 'Nogueira';

  @override
  String get board_forest => 'Floresta';

  @override
  String get board_ocean => 'Oceano';

  @override
  String get board_midnight => 'Meia-noite';

  @override
  String get board_sunset => 'Pôr do sol';

  @override
  String get board_clear_green => 'Verde nítido';

  @override
  String get board_clear_brown => 'Castanho nítido';

  @override
  String get board_clear_blue => 'Azul nítido';

  @override
  String get board_clear_red => 'Vermelho nítido';

  @override
  String get board_contrast => 'Alto contraste';

  @override
  String get piece_classic => 'Clássicas';

  @override
  String get piece_wood => 'Madeira';

  @override
  String get piece_glass => 'Vidro';

  @override
  String get piece_ruby => 'Marfim e rubi';

  @override
  String get piece_flat => 'Planas';

  @override
  String get installTitle => 'Instalar o Licheckers';

  @override
  String get installBody =>
      'Abre mais depressa, funciona offline, sem loja de apps.';

  @override
  String get installNow => 'Instalar';

  @override
  String get notNow => 'Agora não';

  @override
  String get installIosTitle => 'Adicionar ao ecrã inicial';

  @override
  String get installIosBody =>
      'No Safari, toque no botão Partilhar e depois em “Adicionar ao ecrã principal”.';

  @override
  String get installDone => 'O Licheckers está instalado.';

  @override
  String get clock_bullet => 'Bullet';

  @override
  String get clock_blitz => 'Blitz';

  @override
  String get clock_rapid => 'Rápido';

  @override
  String get clock_classic => 'Clássico';

  @override
  String startsIn(String time) {
    return 'Começa em $time';
  }

  @override
  String liveEndsIn(String time) {
    return 'Ao vivo: termina em $time';
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
    String _temp0 = intl.Intl.selectLogic(n, {'other': '$nº'});
    return '$_temp0';
  }

  @override
  String get arena => 'Arena';

  @override
  String get swiss => 'Suíço';

  @override
  String get createTournament => 'Criar um torneio';

  @override
  String get demoNote =>
      'Demonstração: torneios de exemplo e ainda sem dinheiro real. O jogo online e os pagamentos chegam com o servidor.';

  @override
  String get clockTypesTitle => 'Tipos de relógio';

  @override
  String get clockTypesText =>
      'Bullet: 1 a 2 minutos cada, muito rápido.\nBlitz: 3 a 5 minutos cada.\nRápido: 10 a 15 minutos cada.\nClássico: 20 a 30 minutos cada.\n\nUm segundo número como 3+2 quer dizer que se somam 2 segundos depois de cada jogada.';

  @override
  String get noTournamentsOfType => 'Ainda não há torneios deste tipo.';

  @override
  String get yours => 'Seu';

  @override
  String get joinedTag => 'Inscrito';

  @override
  String presentedBy(String names) {
    return 'Apresentado por $names';
  }

  @override
  String hostedBy(String host) {
    return 'Organizado por $host';
  }

  @override
  String get entry => 'Inscrição';

  @override
  String get prizePool => 'Prémios';

  @override
  String get players => 'Jogadores';

  @override
  String get createTitle => 'Criar torneio';

  @override
  String get secAbout => '1. Sobre';

  @override
  String get tournamentName => 'Nome do torneio';

  @override
  String get secFormat => '2. Formato';

  @override
  String get arenaInfo =>
      'Entre quando quiser antes do fim. Jogue o máximo de jogos que puder. Vitória vale 3 pontos, empate 1, derrota 0. Quem tiver mais pontos no fim do relógio vence.\n\nIdeal para muita gente, porque dá para chegar atrasado.';

  @override
  String get swissInfo =>
      'Um número fixo de rondas. Em cada ronda você joga com alguém de pontuação parecida. Todos jogam todas as rondas. Quem tiver mais pontos depois da última ronda vence.\n\nIdeal para eventos menores e sérios (até cerca de 200 jogadores). Só pode entrar antes da ronda 1.';

  @override
  String get notEnoughRounds =>
      'Não há tempo para 3 rondas. Aumente o torneio ou acelere o relógio.';

  @override
  String roundsFit(int n, int max) {
    return 'Rondas: $n (cabem até $max)';
  }

  @override
  String get secClock => '3. Relógio';

  @override
  String get clockTitle => 'Relógio';

  @override
  String get clockInfo =>
      'Todo jogo de torneio tem relógio, para que um jogador lento não pare o evento inteiro. O segundo número são os segundos somados depois de cada jogada.';

  @override
  String minutesPerPlayer(int n) {
    return 'Minutos por jogador: $n';
  }

  @override
  String secondsAdded(int n) {
    return 'Segundos somados a cada jogada: $n';
  }

  @override
  String longGame(String clock, int n) {
    return '$clock. Um jogo longo dura cerca de $n minutos.';
  }

  @override
  String get secWhen => '4. Quando';

  @override
  String get whenTitle => 'Início e duração';

  @override
  String get whenInfo =>
      'Os torneios são curtos de propósito: 30 minutos a 4 horas. Os jogadores veem uma contagem até ao início e depois até ao fim. Não se emparelham jogos novos nos últimos minutos; os que estão a decorrer podem terminar.';

  @override
  String get in1h => 'Daqui a 1 hora';

  @override
  String get in3h => 'Daqui a 3 horas';

  @override
  String get in8h => 'Daqui a 8 horas';

  @override
  String get pickDateTime => 'Escolher data e hora';

  @override
  String startsAt(String time) {
    return 'Começa: $time';
  }

  @override
  String lengthIs(String d) {
    return 'Duração: $d';
  }

  @override
  String endsAt(String time) {
    return 'Termina: $time';
  }

  @override
  String roundsFitIn(int n, String d) {
    return 'Cabem cerca de $n rondas em $d.';
  }

  @override
  String get secMoney => '5. Jogadores e dinheiro';

  @override
  String get moneyTitle => 'Como funciona o dinheiro';

  @override
  String moneyInfo(int pct) {
    return 'Você bloqueia todo o prémio ao criar o torneio. Os jogadores pagam a inscrição para entrar. Os vencedores são pagos com o seu prémio bloqueado. As inscrições são suas. A plataforma fica com $pct% só do seu lucro (inscrições menos prémio). Se as inscrições não cobrirem o prémio, a plataforma não fica com nada.\n\nSe o torneio for cancelado antes de começar, todos são reembolsados. Depois de começar, o dinheiro fica bloqueado.';
  }

  @override
  String get minPlayers => 'Mín. de jogadores';

  @override
  String get maxPlayers => 'Máx. de jogadores';

  @override
  String get entryFee => 'Inscrição';

  @override
  String get winnerSplit => 'Divisão dos prémios';

  @override
  String get winnerSplitInfo =>
      'Como o prémio se divide pelos primeiros lugares. As sobras do arredondamento vão para o primeiro lugar.';

  @override
  String get split_winner => 'O vencedor leva tudo';

  @override
  String get split_top3 => 'Top 3';

  @override
  String get split_top5 => 'Top 5';

  @override
  String get whatIf => 'E se entrarem estes jogadores?';

  @override
  String get whatIfTitle => 'O seu dinheiro, calculado';

  @override
  String get whatIfInfo =>
      'Mova o controlo para ver quanto ganharia. A parte da plataforma sai só do seu lucro.';

  @override
  String get feesCollected => 'Inscrições recebidas';

  @override
  String get poolYouLocked => 'Prémio que bloqueou';

  @override
  String platformShare(int pct) {
    return 'Parte da plataforma ($pct% do lucro)';
  }

  @override
  String get youEndWith => 'Fica com';

  @override
  String breakEven(int n) {
    return 'Empata as contas com $n jogadores. Abaixo disso perde parte do prémio.';
  }

  @override
  String get secBoard => '6. Tabuleiro e peças';

  @override
  String get whyOnlyThese => 'Porque só estes?';

  @override
  String get whyOnlyTheseInfo =>
      'Todos no torneio jogam no mesmo tabuleiro, para verem sempre bem as casas e as peças. Só oferecemos tabuleiros e peças que passam nos nossos testes de legibilidade. Os patrocinadores nunca podem mudar o tabuleiro.';

  @override
  String piecesNamed(String name) {
    return 'Peças $name';
  }

  @override
  String get check_whiteOnDark =>
      'As peças brancas destacam-se das casas escuras';

  @override
  String get check_blackOnDark =>
      'As peças pretas destacam-se das casas escuras';

  @override
  String get check_sidesApart =>
      'É fácil distinguir as peças brancas das pretas';

  @override
  String get check_squaresApart =>
      'É fácil distinguir as casas claras das escuras';

  @override
  String checkLine(String label, String value, String need) {
    return '$label ($value : 1, precisa de $need)';
  }

  @override
  String get secSponsor => '7. Patrocinador (opcional)';

  @override
  String get sponsoredTitle => 'Torneios patrocinados';

  @override
  String sponsoredInfo(String theme, String pieces) {
    return 'Um patrocinador muda o visual da app só neste torneio: cores, logótipo e faixa com o nome, e, se quiser, o nome nas peças. As casas do tabuleiro nunca mudam. Nunca há pop-ups, vídeos nem sons, e nada tapa o tabuleiro ou os relógios. Quando o jogador sai do torneio, a app volta ao normal.\n\nPreço: $theme por patrocinador, mais $pieces por patrocinador para pôr o nome nas peças. As imagens são verificadas primeiro, por isso um torneio patrocinado tem de começar pelo menos 6 horas depois de agora.';
  }

  @override
  String get noSponsor => 'Sem patrocinador';

  @override
  String get oneSponsor => 'Um patrocinador';

  @override
  String get twoSponsors => 'Dois patrocinadores (metade cada)';

  @override
  String get sponsorName => 'Nome do patrocinador';

  @override
  String get sponsor1Name => 'Nome do patrocinador 1 (lado branco)';

  @override
  String get sponsor2Name => 'Nome do patrocinador 2 (lado preto)';

  @override
  String get sponsor => 'Patrocinador';

  @override
  String get sponsor1 => 'Patrocinador 1';

  @override
  String get sponsor2 => 'Patrocinador 2';

  @override
  String nameOnPieces(String price) {
    return 'Nome nas peças (+$price)';
  }

  @override
  String nameOnWhite(String price) {
    return 'Nome nas peças brancas (+$price)';
  }

  @override
  String nameOnBlack(String price) {
    return 'Nome nas peças pretas (+$price)';
  }

  @override
  String upToLetters(int n) {
    return 'Até $n letras, com teste de legibilidade';
  }

  @override
  String sponsorTotal(String price) {
    return 'Total do patrocínio: $price';
  }

  @override
  String get logoRules =>
      'Logótipos: PNG, JPG ou WebP, com menos de 2 MB. Cada logótipo é verificado por uma pessoa (sem conteúdo adulto, sem marcas falsas) antes de outros jogadores o verem.';

  @override
  String get upload => 'Carregar';

  @override
  String get fromLink => 'De um link';

  @override
  String get logoColour => 'Cor do logótipo';

  @override
  String get logoAdded =>
      'A cor do logótipo é agora a cor do torneio. O logótipo aguarda verificação por uma pessoa: até lá, só você o vê.';

  @override
  String get linkTitle => 'Adicionar imagem de um link';

  @override
  String get linkHelp =>
      'Cole o endereço da própria imagem (costuma terminar em .png ou .jpg). Alguns sites impedem outras apps de usar as suas imagens. Se acontecer, descarregue a imagem e use Carregar.';

  @override
  String somethingWrong(String error) {
    return 'Algo correu mal: $error';
  }

  @override
  String get secOptions => '8. Opções';

  @override
  String get allowVoice => 'Permitir conversa por voz nos jogos';

  @override
  String get allowVoiceSub =>
      'Os jogadores continuam a escolher se falam ou não';

  @override
  String get watchDelay => 'Atraso da transmissão';

  @override
  String get watchDelayTitle => 'Atraso da transmissão';

  @override
  String get watchDelayInfo =>
      'Outras pessoas podem ver os melhores jogos ao vivo. Nos torneios pagos veem com alguns segundos de atraso, para ninguém soprar a melhor jogada a um jogador.';

  @override
  String seconds(int n) {
    return '$n s';
  }

  @override
  String moreProblems(String first, int n) {
    return '$first  (+$n outros)';
  }

  @override
  String get youPayNow => 'Paga agora';

  @override
  String get lockAndCreate => 'Bloquear prémio e criar';

  @override
  String get confirmTitle => 'Bloquear o prémio e criar?';

  @override
  String confirmPay(String total) {
    return 'Paga $total agora:';
  }

  @override
  String confirmPool(String amount) {
    return 'Prémio (bloqueado): $amount';
  }

  @override
  String confirmFee(String amount) {
    return 'Taxa de criação: $amount';
  }

  @override
  String confirmSponsor(String amount) {
    return 'Visual do patrocinador: $amount';
  }

  @override
  String get confirmRules =>
      'Se o torneio for cancelado antes de começar, cada jogador recebe a inscrição de volta e o prémio volta para si. Depois de começar, o prémio fica bloqueado até os vencedores serem pagos.';

  @override
  String get demoNoMoney => 'Demonstração: ainda não se move dinheiro real.';

  @override
  String get p_nameShort => 'Dê um nome ao torneio (3 letras ou mais).';

  @override
  String p_clockRange(String type) {
    return 'O relógio está fora do intervalo $type.';
  }

  @override
  String get p_lengthRange =>
      'A duração tem de ser entre 30 minutos e 4 horas.';

  @override
  String get p_startSoon => 'Comece pelo menos 30 minutos depois de agora.';

  @override
  String get p_sponsoredStartSoon =>
      'Torneios patrocinados têm de começar pelo menos 6 horas depois de agora, para as imagens serem verificadas.';

  @override
  String p_swissFew(int n) {
    return 'Só cabem $n rondas suíças. Aumente a duração ou acelere o relógio.';
  }

  @override
  String p_swissTooMany(int n) {
    return 'Cabem no máximo $n rondas neste tempo.';
  }

  @override
  String get p_arenaTooSlow =>
      'Este relógio é lento demais para esta duração. Aumente o torneio ou acelere o relógio.';

  @override
  String get p_minPlayers => 'São precisos pelo menos 2 jogadores.';

  @override
  String get p_maxBelowMin =>
      'O máximo de jogadores tem de ser pelo menos o mínimo.';

  @override
  String p_poolTooSmall(String amount) {
    return 'O prémio tem de ser de pelo menos $amount.';
  }

  @override
  String p_prizesNeedPlayers(int n) {
    return '$n prémios precisam de pelo menos $n jogadores.';
  }

  @override
  String get p_boardUnclear =>
      'Este tabuleiro e estas peças não são nítidos o bastante. Escolha outro par.';

  @override
  String get p_sponsorName => 'Escreva o nome do patrocinador.';

  @override
  String get p_sponsor2Name => 'Escreva o nome do segundo patrocinador.';

  @override
  String p_whiteLabel(String problem) {
    return 'Peças brancas: $problem';
  }

  @override
  String p_blackLabel(String problem) {
    return 'Peças pretas: $problem';
  }

  @override
  String lbl_empty(int n) {
    return 'Escreva um nome curto (até $n letras).';
  }

  @override
  String lbl_tooLong(int n) {
    return 'Comprido demais: no máximo $n letras para a coroa da dama continuar visível.';
  }

  @override
  String get lbl_unreadable =>
      'Este nome seria difícil de ler nestas peças. Escolha outras peças.';

  @override
  String get e_svg =>
      'Ficheiros SVG serão aceites quando o servidor os puder converter com segurança. Por agora use PNG ou JPG.';

  @override
  String get e_type => 'Use uma imagem PNG, JPG ou WebP.';

  @override
  String get e_big => 'A imagem é grande demais. Mantenha-a abaixo de 2 MB.';

  @override
  String get e_empty => 'O ficheiro está vazio.';

  @override
  String get e_https => 'Use um link completo que comece por https://';

  @override
  String get e_link =>
      'Não foi possível abrir esse link. Alguns sites impedem outras apps de usar as suas imagens. Descarregue a imagem e use Carregar.';

  @override
  String e_http(String code) {
    return 'O site respondeu com um erro ($code).';
  }

  @override
  String get e_webpage =>
      'Esse link é uma página web, não uma imagem. Abra a própria imagem e copie o endereço.';

  @override
  String get e_notPicture =>
      'Este ficheiro não é uma imagem que consigamos ler.';

  @override
  String get joinForFree => 'Entrar grátis';

  @override
  String joinFor(String price) {
    return 'Entrar por $price';
  }

  @override
  String get joinForFreeQ => 'Entrar grátis?';

  @override
  String joinForQ(String price) {
    return 'Entrar por $price?';
  }

  @override
  String get refundNote =>
      'Se o torneio for cancelado antes de começar, recebe a inscrição de volta.';

  @override
  String get created =>
      'Torneio criado. Partilhe o link abaixo para as pessoas entrarem.';

  @override
  String get logoPending => 'Logótipo à espera de verificação: só você o vê';

  @override
  String fromTo(String start, String end, String d) {
    return '$start até $end  ($d)';
  }

  @override
  String get youreIn => 'Está inscrito';

  @override
  String get invitePeople => 'Convidar pessoas';

  @override
  String get shareLinkTitle => 'Link de partilha';

  @override
  String get shareLinkInfo =>
      'Envie este link pelo WhatsApp ou onde quiser. Quem já tem a app abre este torneio. Os novos têm de se registar primeiro e depois entrar.\n\nO link começa a funcionar quando o jogo online estiver ativo.';

  @override
  String get copyLink => 'Copiar link';

  @override
  String get linkCopied => 'Link copiado';

  @override
  String get prizes => 'Prémios';

  @override
  String joinedCount(int n, int min, int max) {
    return '$n inscritos (mín. $min, máx. $max)';
  }

  @override
  String get howItWorks => 'Como funciona';

  @override
  String get pointsTitle => 'Pontos e desempates';

  @override
  String get pointsInfo =>
      'Vitória 3 pontos, empate 1, derrota 0. Com os mesmos pontos, fica à frente quem tem mais vitórias, depois o confronto direto, depois a força dos adversários, depois menos jogos, depois quem chegou primeiro à pontuação. Por isso há sempre só um primeiro lugar.';

  @override
  String get arenaShort =>
      'Arena: entre quando quiser. Jogue o máximo de jogos que puder. Quem tiver mais pontos no fim do relógio vence.';

  @override
  String swissShort(int n) {
    return 'Suíço: $n rondas. Em cada ronda joga com alguém de pontuação parecida. Entre antes da ronda 1.';
  }

  @override
  String get pointsLine => 'Vitória = 3 pontos · Empate = 1 · Derrota = 0';

  @override
  String get voiceOn =>
      'A conversa por voz é permitida (se os dois aceitarem).';

  @override
  String get voiceOff => 'A conversa por voz está desligada neste torneio.';

  @override
  String get watchNoDelay => 'Ao vivo: sem atraso.';

  @override
  String watchDelayed(int n) {
    return 'A transmissão tem $n segundos de atraso.';
  }

  @override
  String get boardYouPlay => 'O tabuleiro em que vai jogar';

  @override
  String get sameBoardTitle => 'O mesmo tabuleiro para todos';

  @override
  String get sameBoardInfo =>
      'Todos neste torneio veem este tabuleiro e estas peças, para o jogo ser sempre claro. A sua escolha volta quando sair.';

  @override
  String get yourMoney => 'O seu dinheiro (organizador)';

  @override
  String get feesSoFar => 'Inscrições até agora';

  @override
  String get poolLocked => 'Prémio bloqueado';

  @override
  String get youWouldEnd => 'Ficaria com';
}
