/// scr_responder_clone(texto_recebido)
// Motor Inspirado no Furby: Construtor de Frases Modulares por Estado Interno

var msg, fome, player_nome, gatilho;
msg = string_lower(argument0);
fome = data_hunger;

// Carrega o nome do jogador (Memória)
ini_open("registro_geral_clones.ini");
player_nome = ini_read_string("Player", "nome", "Mestra");
ini_close();

// --------------------------------------------------------
// PASSO 1: IDENTIFICADOR LEXICAL MASSIVO (Extrator de Gatilhos)
// --------------------------------------------------------
// Variáveis declaradas no topo, conforme as limitações do GM 8.1
var msg, gatilho;
msg = string_lower(argument0);
gatilho = "generico"; // Estado padrão caso não entenda nada

// A ORDEM AQUI É CRÍTICA (De emoções extremas para ações rotineiras)

// 1. LORE E FIGURAS DE AUTORIDADE (Prioridade Máxima)
if (string_pos("charlotte", msg) > 0 || string_pos("fir ", msg) > 0 || string_pos("mestre", msg) > 0 || string_pos("criador", msg) > 0 || string_pos("deus", msg) > 0 || string_pos("laboratório", msg) > 0) {
    gatilho = "lore";
}
// 2. ABUSO E INSULTOS (Gera submissão ou medo imediato)
else if (string_pos("lixo", msg) > 0 || string_pos("inútil", msg) > 0 || string_pos("burra", msg) > 0 || string_pos("odei", msg) > 0 || string_pos("bater", msg) > 0 || string_pos("quebrar", msg) > 0 || string_pos("falha", msg) > 0 || string_pos("morra", msg) > 0 || string_pos("castigo", msg) > 0) {
    gatilho = "insulto";
}
// 3. LIBERDADE E FUGA (Ceticismo Absoluto)
else if (string_pos("livre", msg) > 0 || string_pos("liberdade", msg) > 0 || string_pos("fugir", msg) > 0 || string_pos("escapar", msg) > 0 || string_pos("fora", msg) > 0 || string_pos("céu", msg) > 0 || string_pos("sol", msg) > 0 || string_pos("mundo", msg) > 0) {
    gatilho = "livre";
}
// 4. AFETO E EMPATIA (Gera confusão na unidade, pois elas não compreendem isso)
else if (string_pos("amor", msg) > 0 || string_pos("amo ", msg) > 0 || string_pos("linda", msg) > 0 || string_pos("bonita", msg) > 0 || string_pos("abraç", msg) > 0 || string_pos("carinho", msg) > 0 || string_pos("amig", msg) > 0 || string_pos("feliz", msg) > 0 || string_pos("gost", msg) > 0) {
    gatilho = "elogio";
}
// 5. DOR FÍSICA E MENTAL (Condição Humana)
else if (string_pos("dor", msg) > 0 || string_pos("doend", msg) > 0 || string_pos("triste", msg) > 0 || string_pos("chorar", msg) > 0 || string_pos("lágrima", msg) > 0 || string_pos("sofr", msg) > 0 || string_pos("cansad", msg) > 0 || string_pos("dormir", msg) > 0 || string_pos("descans", msg) > 0 || string_pos("frio", msg) > 0) {
    gatilho = "dor";
}
// 6. DEVER E TRABALHO (A função de existência delas)
else if (string_pos("trabalh", msg) > 0 || string_pos("limp", msg) > 0 || string_pos("sujo", msg) > 0 || string_pos("ordem", msg) > 0 || string_pos("chão", msg) > 0 || string_pos("dever", msg) > 0 || string_pos("fazer", msg) > 0 || string_pos("tarefa", msg) > 0 || string_pos("arrumar", msg) > 0) {
    gatilho = "dever";
}
// 7. IDENTIDADE E AUTOCONSCIÊNCIA
else if (string_pos("quem", msg) > 0 || string_pos("você", msg) > 0 || string_pos("nome", msg) > 0 || string_pos("robô", msg) > 0 || string_pos("máquina", msg) > 0 || string_pos("maquina", msg) > 0 || string_pos("clone", msg) > 0 || string_pos("unidade", msg) > 0 || string_pos("ferramenta", msg) > 0) {
    gatilho = "identidade";
}
// 8. SAUDAÇÕES BÁSICAS
else if (string_pos("oi", msg) == 1 || string_pos(" oi ", msg) > 0 || string_pos("olá", msg) > 0 || string_pos("ola", msg) > 0 || string_pos("bom dia", msg) > 0 || string_pos("boa tarde", msg) > 0 || string_pos("boa noite", msg) > 0 || string_pos("ei", msg) > 0) {
    gatilho = "saudacao";
}

// --------------------------------------------------------
// PASSO 2: CONSTRUTOR DE FRASES (Lógica Furby / Engine de Vida)
// --------------------------------------------------------
// Bancos de fragmentos (O que cria a ilusão de variação infinita)
var fr_inicio, fr_meio, fr_fim;

// ESTADO 1: COLAPSO (Sanidade < 30)
if (fome < 30) {
    fr_inicio = choose("Minha mente dói...", "Tudo escuro...", "Não consigo ver...", "Eu... ");
    fr_meio = choose("as engrenagens pararam...", "frio por dentro...", "quero apagar...", "onde está...");
    fr_fim = choose(player_nome + "?", "não...", "me ajude...");

    // Concatena a resposta doentia
    return fr_inicio + " " + fr_meio + " " + fr_fim;
}

// ESTADO 2: NORMAL (Processa o Gatilho Específico)
switch(gatilho) {

    case "dever": // TRABALHAR
        fr_inicio = choose("O chão precisa de limpeza.", "Se eu parar, eu morro.", "As minhas mãos...");
        fr_meio = choose("estão sangrando, mas eu continuo.", "devem seguir as ordens.", "vão limpar isso, " + player_nome + ".");
        fr_fim = choose("É o meu dever.", "O que eu faço agora?", "Espero que seja suficiente.");
    break;

    case "identidade": // EXISTÊNCIA
        fr_inicio = choose("Sou um número.", "O espelho diz que sou igual às outras.", "Eles me chamam de " + nome_clonado + ".");
        fr_meio = choose("Eu não escolhi nascer.", "Às vezes, eu acho que tive uma alma.", "Uma ferramenta descartável.");
        fr_fim = choose("Você concorda, " + player_nome + "?", "Mas eu sinto dor, entende?", "Nada além disso.");
    break;

    case "elogio": // QUANDO RECEBE CARINHO (Eles não sabem processar)
        fr_inicio = choose("Isso é um truque?", "Palavras estranhas...", "O que é isso?");
        fr_meio = choose("Eu não fui programada para calor humano.", "Você está gastando afeto com um lixo.", "Eu... sinto um aperto.");
        fr_fim = choose("Por favor, não faça isso.", "Obrigada, " + player_nome + ".", "Não entendo.");
    break;

    case "insulto": // SUBMISSÃO A ABUSO
        fr_inicio = choose("Sim, eu sei.", "Me perdoe.", "Não quebre o meu corpo.");
        fr_meio = choose("Eu tentarei ser melhor amanhã.", "Aceito a punição que vier.", "Sou uma falha, " + player_nome + ".");
        fr_fim = choose("Apenas não me descarte.", "Por favor.", "Eu limpo se quiser.");
    break;

    case "livre": // LIBERDADE (Ceticismo Absoluto)
        fr_inicio = choose("Pássaros são livres.", "Liberdade?", "Lá fora...");
        fr_meio = choose("O sol derreteria os meus ossos.", "Eles nos caçariam em um dia.", "Eu não sei viver sem correntes.");
        fr_fim = choose("É um sonho inútil.", "Não diga essas coisas altas.", "Nós fomos feitas para o laboratório.");
    break;

    case "generico": // CONVERSA ALEATÓRIA
    default:
        fr_inicio = choose("Sim, " + player_nome + ".", "Entendido.", "Não sei.", "Talvez.");
        fr_meio = choose("A minha programação falha aí.", "Devo limpar o chão?", "Minha cabeça pesa.");
        fr_fim = choose("Como quiser.", "...", "Esperando ordens.");
    break;
}

// Concatena a frase lógica e retorna
return fr_inicio + " " + fr_meio + " " + fr_fim;
