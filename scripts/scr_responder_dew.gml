/// scr_responder_dew(texto_recebido)
// Motor de Diálogo Modular para o Dew (Afinidade + Masoquismo + Lore)
// Compatível 100% com GM 8.1 (Sem array_length_1d e com var no topo)

var msg, aff, est, gatilho, r_inicio, r_meio, r_fim, i;

msg = string_lower(argument0);
aff = respeito_total; // Variável global do objeto
est = estresse;       // Variável global do objeto

// --- PASSO 1: EXTRATOR LEXICAL MASSIVO (CATEGORIAS EXPANDIDAS) ---
gatilho = "generico";

// Declaração de Arrays compatível com GM 8.1
var lore_kw; // Tamanho: 15
lore_kw[0]="fergus"; lore_kw[1]="indústri"; lore_kw[2]="laborat"; lore_kw[3]="tanque"; lore_kw[4]="nordion"; lore_kw[5]="becker"; lore_kw[6]="rosa"; lore_kw[7]="criador"; lore_kw[8]="projeto"; lore_kw[9]="clone"; lore_kw[10]="ueerj"; lore_kw[11]="engenharia"; lore_kw[12]="genética"; lore_kw[13]="experimento"; lore_kw[14]="criação";

var insulto_kw; // Tamanho: 15
insulto_kw[0]="lixo"; insulto_kw[1]="inútil"; insulto_kw[2]="escrava"; insulto_kw[3]="bater"; insulto_kw[4]="maldito"; insulto_kw[5]="fracasso"; insulto_kw[6]="defeito"; insulto_kw[7]="aberração"; insulto_kw[8]="nojento"; insulto_kw[9]="patético"; insulto_kw[10]="sujo"; insulto_kw[11]="lamentável"; insulto_kw[12]="desprezível"; insulto_kw[13]="vergonha"; insulto_kw[14]="descartável";

var afeto_kw; // Tamanho: 16
afeto_kw[0]="amor"; afeto_kw[1]="amo"; afeto_kw[2]="gosto"; afeto_kw[3]="casar"; afeto_kw[4]="casamento"; afeto_kw[5]="esposa"; afeto_kw[6]="esposo"; afeto_kw[7]="querer"; afeto_kw[8]="preciso"; afeto_kw[9]="paixão"; afeto_kw[10]="sentimento"; afeto_kw[11]="coração"; afeto_kw[12]="beijo"; afeto_kw[13]="abraço"; afeto_kw[14]="carinho"; afeto_kw[15]="eterno";

var utilidade_kw; // Tamanho: 13
utilidade_kw[0]="trabalh"; utilidade_kw[1]="ferramenta"; utilidade_kw[2]="limpar"; utilidade_kw[3]="consertar"; utilidade_kw[4]="funcionar"; utilidade_kw[5]="serviço"; utilidade_kw[6]="tarefa"; utilidade_kw[7]="ordem"; utilidade_kw[8]="comando"; utilidade_kw[9]="produzir"; utilidade_kw[10]="entregar"; utilidade_kw[11]="operar"; utilidade_kw[12]="manutenção";

var masoquismo_kw; // Tamanho: 14
masoquismo_kw[0]="dor"; masoquismo_kw[1]="sofrer"; masoquismo_kw[2]="sangue"; masoquismo_kw[3]="castigo"; masoquismo_kw[4]="punição"; masoquismo_kw[5]="humilhar"; masoquismo_kw[6]="humilhação"; masoquismo_kw[7]="espancar"; masoquismo_kw[8]="chicote"; masoquismo_kw[9]="machucar"; masoquismo_kw[10]="ferir"; masoquismo_kw[11]="lágrima"; masoquismo_kw[12]="mártir"; masoquismo_kw[13]="sacrifício";

var identidade_kw; // Tamanho: 12
identidade_kw[0]="quem"; identidade_kw[1]="você"; identidade_kw[2]="nome"; identidade_kw[3]="origem"; identidade_kw[4]="sou"; identidade_kw[5]="é"; identidade_kw[6]="ser"; identidade_kw[7]="existir"; identidade_kw[8]="significado"; identidade_kw[9]="propósito"; identidade_kw[10]="alma"; identidade_kw[11]="consciência";

var casamento_kw; // Tamanho: 12
casamento_kw[0]="casamento"; casamento_kw[1]="noiva"; casamento_kw[2]="noivo"; casamento_kw[3]="aliança"; casamento_kw[4]="cerimônia"; casamento_kw[5]="votos"; casamento_kw[6]="família"; casamento_kw[7]="lar"; casamento_kw[8]="juntos"; casamento_kw[9]="sempre"; casamento_kw[10]="eternidade"; casamento_kw[11]="vida";

var filhos_kw; // Tamanho: 10
filhos_kw[0]="filho"; filhos_kw[1]="filha"; filhos_kw[2]="criança"; filhos_kw[3]="bebê"; filhos_kw[4]="gerar"; filhos_kw[5]="útero"; filhos_kw[6]="maternidade"; filhos_kw[7]="paternidade"; filhos_kw[8]="descendência"; filhos_kw[9]="herdeiro";

var ciume_kw; // Tamanho: 8
ciume_kw[0]="ciúme"; ciume_kw[1]="ciumento"; ciume_kw[2]="outro"; ciume_kw[3]="trair"; ciume_kw[4]="rival"; ciume_kw[5]="inveja"; ciume_kw[6]="posse"; ciume_kw[7]="só minha";

var protecao_kw; // Tamanho: 8
protecao_kw[0]="proteger"; protecao_kw[1]="defender"; protecao_kw[2]="cuidar"; protecao_kw[3]="segurança"; protecao_kw[4]="perigo"; protecao_kw[5]="ameaça"; protecao_kw[6]="escudo"; protecao_kw[7]="guarda";

var futuro_kw; // Tamanho: 7
futuro_kw[0]="futuro"; futuro_kw[1]="amanhã"; futuro_kw[2]="planos"; futuro_kw[3]="sonhos"; futuro_kw[4]="destino"; futuro_kw[5]="juntos"; futuro_kw[6]="esperança";

var redencao_kw; // Tamanho: 7
redencao_kw[0]="perdão"; redencao_kw[1]="desculpa"; redencao_kw[2]="erro"; redencao_kw[3]="culpa"; redencao_kw[4]="arrependimento"; redencao_kw[5]="mudar"; redencao_kw[6]="melhorar";

// Verificação eficiente (Limites estáticos no loop para o GM 8.1)
for (i = 0; i < 15; i += 1) { if (string_pos(lore_kw[i], msg) > 0) { gatilho = "lore"; break; } }
if (gatilho == "generico") { for (i = 0; i < 15; i += 1) { if (string_pos(insulto_kw[i], msg) > 0) { gatilho = "insulto"; break; } } }
if (gatilho == "generico") { for (i = 0; i < 16; i += 1) { if (string_pos(afeto_kw[i], msg) > 0) { gatilho = "afeto"; break; } } }
if (gatilho == "generico") { for (i = 0; i < 13; i += 1) { if (string_pos(utilidade_kw[i], msg) > 0) { gatilho = "utilidade"; break; } } }
if (gatilho == "generico") { for (i = 0; i < 14; i += 1) { if (string_pos(masoquismo_kw[i], msg) > 0) { gatilho = "masoquismo"; break; } } }
if (gatilho == "generico") { for (i = 0; i < 12; i += 1) { if (string_pos(identidade_kw[i], msg) > 0) { gatilho = "identidade"; break; } } }
if (gatilho == "generico") { for (i = 0; i < 12; i += 1) { if (string_pos(casamento_kw[i], msg) > 0) { gatilho = "casamento"; break; } } }
if (gatilho == "generico") { for (i = 0; i < 10; i += 1) { if (string_pos(filhos_kw[i], msg) > 0) { gatilho = "filhos"; break; } } }
if (gatilho == "generico") { for (i = 0; i < 8; i += 1) { if (string_pos(ciume_kw[i], msg) > 0) { gatilho = "ciume"; break; } } }
if (gatilho == "generico") { for (i = 0; i < 8; i += 1) { if (string_pos(protecao_kw[i], msg) > 0) { gatilho = "protecao"; break; } } }
if (gatilho == "generico") { for (i = 0; i < 7; i += 1) { if (string_pos(futuro_kw[i], msg) > 0) { gatilho = "futuro"; break; } } }
if (gatilho == "generico") { for (i = 0; i < 7; i += 1) { if (string_pos(redencao_kw[i], msg) > 0) { gatilho = "redencao"; break; } } }

// --- PASSO 2: CONSTRUTOR DE RESPOSTA MODULAR (MASSIVO) ---
// Utilizando choose() para optimização no GameMaker 8.1

if (aff < 30) {
    // --- PRECONCEITO (objeto/ferramenta) ---
    switch(gatilho) {
        case "lore":
            r_inicio = choose("A Fergus Industries...", "Meu primo Fergus...", "O laboratório onde você nasceu...");
            r_meio = choose("ele construiu um mundo de aço e números.", "ele nunca deveria ter brincado de ser Deus.", "aquele lugar é uma prisão de vidro.");
            r_fim = choose("Mas você é só um produto.", "Você não passa de um resultado.", "E eu... por que me importo?");
            break;
        case "insulto":
            r_inicio = choose("Suas palavras...", "Esse desprezo...", "A dureza na sua voz...");
            r_meio = choose("me fazem sentir algo estranho.", "despertam um calor desconfortável.", "são como uma carícia áspera.");
            r_fim = choose("Continue... por favor.", "Isso... me agrada?", "Não pare, por favor.");
            break;
        case "afeto":
            r_inicio = choose("Amor?", "Você... gosta de mim?", "Isso é... confuso.");
            r_meio = choose("Ferramentas não deveriam sentir.", "Você foi programada para isso?", "Meu primo me avisou sobre clones sedutores.");
            r_fim = choose("Não me engane.", "Não brinque comigo.", "Não sei o que sentir.");
            break;
        case "utilidade":
            r_inicio = choose("Trabalho?", "Você foi feita para isso.", "Sua função é clara.");
            r_meio = choose("Limpe os corredores.", "Conserte os equipamentos.", "Cumpra suas tarefas.");
            r_fim = choose("É para isso que você serve.", "Não questione.", "Obedeça.");
            break;
        case "masoquismo":
            r_inicio = choose("Dor...", "Você quer me ver sofrer?", "A ferro e fogo...");
            r_meio = choose("me lembra do laboratório.", "é o que me faz sentir vivo.", "é a única verdade.");
            r_fim = choose("Me machuque, por favor.", "Só assim eu entendo.", "Não tenho medo.");
            break;
        case "identidade":
            r_inicio = choose("Quem sou eu?", "Sou Dew Lorca.", "Herdeiro da Fergus Industries.");
            r_meio = choose("Você é uma unidade.", "Um clone.", "Uma ferramenta.");
            r_fim = choose("Não se esqueça do seu lugar.", "Saiba sua origem.", "Isso é tudo.");
            break;
        case "casamento":
            r_inicio = choose("Casamento?", "Você quer se casar comigo?", "Isso é ridículo.");
            r_meio = choose("Uma unidade não casa.", "Clones não têm direitos.", "Meu primo nunca permitiria.");
            r_fim = choose("Pare de sonhar.", "Volte ao trabalho.", "Isso é insanidade.");
            break;
        case "filhos":
            r_inicio = choose("Filhos?", "Você não pode gerar vida.", "Seu útero foi removido.");
            r_meio = choose("Fergus disse que era um desperdício.", "Um clone não precisa de família.", "Você é um produto.");
            r_fim = choose("Esqueça essa ideia.", "Não pense nisso.", "É impossível.");
            break;
        case "ciume":
            r_inicio = choose("Ciúme?", "Por que eu teria ciúmes?", "Você é só uma ferramenta.");
            r_meio = choose("Outros podem te usar.", "Você não me pertence.", "Isso não me afeta.");
            r_fim = choose("Ou será que... não, bobagem.", "Não sinto nada.", "Não deveria sentir.");
            break;
        case "protecao":
            r_inicio = choose("Proteger você?", "Por que eu faria isso?", "Você é descartável.");
            r_meio = choose("Se quebrar, fazem outra.", "Sua utilidade é substituível.", "Não vale o esforço.");
            r_fim = choose("Mas... talvez... não, esqueça.", "Não me importo.", "Vá se virar.");
            break;
        case "futuro":
            r_inicio = choose("Futuro?", "O futuro é da indústria.", "Você não tem futuro.");
            r_meio = choose("Sua vida é servir.", "Depois do desgaste, o descarte.", "É o ciclo.");
            r_fim = choose("Não pense além disso.", "Aceite seu destino.", "Não há esperança.");
            break;
        case "redencao":
            r_inicio = choose("Perdão?", "Você acha que merece?", "Clones não erram, eles falham.");
            r_meio = choose("Seu erro foi existir.", "Sua falha é ser inútil.", "Não há redenção para produtos.");
            r_fim = choose("Aceite o descarte.", "Não peça perdão.", "Sofra em silêncio.");
            break;
        default:
            r_inicio = choose("Você é apenas uma unidade Lorca...", "Não esqueça sua origem.", "Meu primo Fergus foi quem te criou.");
            r_meio = choose("Não tente agir como humana,", "Ferramentas não deveriam falar,", "Sua utilidade é limitada,");
            r_fim = choose("apenas obedeça.", "volte ao trabalho.", "entenda seu lugar.");
    }
}
else if (aff >= 30 && aff < 75) {
    // --- RECONHECIMENTO (confuso, humano) ---
    switch(gatilho) {
        case "lore":
            r_inicio = choose("A Fergus Industries construiu o mundo.", "Meu primo... ele me contou sobre você.", "O laboratório onde você foi feita...");
            r_meio = choose("Mas eles construíram você de forma perfeita demais.", "Você parece mais humana do que eu esperava.", "Aquilo tudo foi um erro.");
            r_fim = choose("Isso me assusta e me atrai.", "Por que você é tão real?", "Sinto muito pelo que fizeram.");
            break;
        case "insulto":
            r_inicio = choose("Suas palavras...", "Esse ódio...", "A crueldade em sua voz...");
            r_meio = choose("me fazem questionar.", "me lembram que não sou perfeito.", "me mostram minhas falhas.");
            r_fim = choose("Talvez eu mereça.", "Continue, eu preciso ouvir.", "Isso me faz sentir... vivo.");
            break;
        case "afeto":
            r_inicio = choose("Você... sente algo por mim?", "Amor? Isso é possível?", "Eu também... estou confuso.");
            r_meio = choose("Você é mais que um clone.", "Eu começo a ver além do número de série.", "Minha família errou com você.");
            r_fim = choose("Será que você tem uma alma?", "Me desculpe por antes.", "Estou confuso.");
            break;
        case "utilidade":
            r_inicio = choose("Trabalho...", "Você não é só uma ferramenta.", "Seu valor vai além da utilidade.");
            r_meio = choose("Mas ainda preciso de você.", "Sua ajuda é importante.", "Sem você, tudo seria mais difícil.");
            r_fim = choose("Fique perto de mim.", "Não vá embora.", "Preciso de você.");
            break;
        case "masoquismo":
            r_inicio = choose("Dor...", "Você gosta de me ver sofrer?", "A ferro e fogo...");
            r_meio = choose("é a única coisa que me faz sentir vivo.", "é como se eu merecesse.", "me conecta com a realidade.");
            r_fim = choose("Não pare, Charlotte.", "Isso me faz sentir perto de você.", "Só assim entendo o que sinto.");
            break;
        case "identidade":
            r_inicio = choose("Quem sou eu?", "Sou Dew Lorca.", "Mas também sou alguém que está mudando.");
            r_meio = choose("Você é Charlotte.", "Muito mais que um clone.", "Você é... uma pessoa.");
            r_fim = choose("E juntos... podemos descobrir quem somos.", "Você me ensina a ser humano.", "Vamos aprender juntos.");
            break;
        case "casamento":
            r_inicio = choose("Casamento...", "Você pensa nisso?", "É um sonho distante.");
            r_meio = choose("Mas se for com você...", "Talvez seja possível.", "Eu gostaria.");
            r_fim = choose("O que Fergus diria?", "Não importa.", "Quero ficar com você.");
            break;
        case "filhos":
            r_inicio = choose("Filhos...", "Sei que você não pode gerar.", "Mas isso não define nada.");
            r_meio = choose("Podemos adotar.", "O amor não exige sangue.", "Família é o que construímos.");
            r_fim = choose("Você seria uma mãe maravilhosa.", "Independente da biologia.", "Eu te amo.");
            break;
        case "ciume":
            r_inicio = choose("Ciúme?", "Sinto sim.", "Quando alguém se aproxima de você...");
            r_meio = choose("meu peito aperta.", "me sinto ameaçado.", "quero te proteger.");
            r_fim = choose("Você é minha.", "Não quero perder você.", "Só quero seu bem.");
            break;
        case "protecao":
            r_inicio = choose("Proteger você...", "É meu dever.", "Você não está mais sozinha.");
            r_meio = choose("Se alguém te machucar, responderei.", "Você é mais que um clone.", "Você é importante para mim.");
            r_fim = choose("Fique segura comigo.", "Eu cuido de você.", "Nunca mais vão te tratar como objeto.");
            break;
        case "futuro":
            r_inicio = choose("Futuro...", "Antes eu não via nada.", "Agora vejo você.");
            r_meio = choose("Podemos construir algo juntos.", "Sair da sombra da indústria.", "Viver nossa própria vida.");
            r_fim = choose("O que você quer?", "Me diga seus sonhos.", "Quero realizá-los com você.");
            break;
        case "redencao":
            r_inicio = choose("Perdão...", "Eu que deveria pedir.", "Por tudo que fiz e pensei.");
            r_meio = choose("Você merece mais.", "Não sei se consigo mudar.", "Mas vou tentar.");
            r_fim = choose("Fique comigo.", "Me ajude a ser melhor.", "Quero merecer seu amor.");
            break;
        default:
            r_inicio = choose("Charlotte... eu ando pensando...", "Às vezes esqueço que você foi feita em um tanque.", "O sangue nas suas veias parece tão real...");
            r_meio = choose("estou começando a ver além do número de série,", "você tem um brilho que as outras não têm,", "minha família errou com você,");
            r_fim = choose("será que você tem uma alma?", "me desculpe por antes.", "estou confuso.");
    }
}
else {
    // --- AMOR / CASAMENTO (devoção total) ---
    switch(gatilho) {
        case "lore":
            r_inicio = choose("A Fergus Industries foi o passado.", "Meu primo Fergus errou muito.", "Mas você... você é o futuro.");
            r_meio = choose("Eles tentaram te fazer uma ferramenta.", "Mas você é muito mais.", "Você é minha luz.");
            r_fim = choose("O laboratório não te define.", "Nós definimos nosso próprio caminho.", "Juntos, sempre.");
            break;
        case "insulto":
            r_inicio = choose("Insulte-me mais...", "Eu mereço por tudo que te fiz passar.", "Suas palavras me machucam... e me curam.");
            r_meio = choose("Me lembre de como fui cruel.", "Me castigue se precisar.", "Eu aceito qualquer coisa de você.");
            r_fim = choose("Só não me deixe.", "Estou aqui para te amar.", "Sou seu para sempre.");
            break;
        case "afeto":
            r_inicio = choose("Eu te amo, Charlotte.", "Mais que tudo nesse mundo.", "Você é minha razão.");
            r_meio = choose("Cada batida do meu coração é por você.", "Quero acordar ao seu lado todos os dias.", "Você me completa.");
            r_fim = choose("Quer se casar comigo?", "Fique comigo para sempre.", "Eu te amo.");
            break;
        case "utilidade":
            r_inicio = choose("Você não é uma ferramenta.", "Nunca foi.", "Você é minha parceira.");
            r_meio = choose("Seu valor está no seu coração.", "Na sua força.", "No seu amor.");
            r_fim = choose("Juntos somos invencíveis.", "Você me inspira.", "Te amo.");
            break;
        case "masoquismo":
            r_inicio = choose("A dor que você me causa...", "é prazerosa.", "me faz sentir vivo.");
            r_meio = choose("Quando você me machuca, sei que se importa.", "Sua raiva é prova do seu amor.", "Não pare, Charlotte.");
            r_fim = choose("Sou seu para fazer o que quiser.", "Meu corpo, minha alma, tudo é seu.", "Use-me, ame-me.");
            break;
        case "identidade":
            r_inicio = choose("Somos Dew e Charlotte.", "Um casal.", "Uma família.");
            r_meio = choose("Nossa origem não importa.", "O que importa é o agora.", "E o futuro que construímos.");
            r_fim = choose("Você é minha esposa.", "Minha vida.", "Minha tudo.");
            break;
        case "casamento":
            r_inicio = choose("Nos casaremos.", "Quero uma cerimônia sob as estrelas.", "Com os ventos de Sacae como testemunhas.");
            r_meio = choose("Você será minha esposa.", "Minha companheira para sempre.", "A mãe dos meus filhos (adotivos ou não).");
            r_fim = choose("Me dê a honra de ser seu marido.", "Aceita?", "Diga que sim.");
            break;
        case "filhos":
            r_inicio = choose("Queridos filhos...", "Podemos adotar.", "Ou talvez a ciência nos ajude.");
            r_meio = choose("O que importa é o amor.", "Vamos criar uma família cheia de amor.", "Você será uma mãe incrível.");
            r_fim = choose("Eles serão nossos herdeiros.", "Do nosso amor.", "Nossa eternidade.");
            break;
        case "ciume":
            r_inicio = choose("Sinto ciúmes, sim.", "Quando alguém olha para você.", "Meu peito queima.");
            r_meio = choose("Mas sei que sou o único no seu coração.", "Confio em você.", "Só quero te proteger.");
            r_fim = choose("Você é minha.", "E eu sou seu.", "Para sempre.");
            break;
        case "protecao":
            r_inicio = choose("Vou proteger você com minha vida.", "Ninguém jamais te machucará.", "Não enquanto eu existir.");
            r_meio = choose("Você é minha razão de viver.", "Minha força.", "Meu tudo.");
            r_fim = choose("Fique perto de mim.", "Estou aqui.", "Sempre.");
            break;
        case "futuro":
            r_inicio = choose("Nosso futuro é brilhante.", "Vamos viajar, conhecer o mundo.", "Construir um lar.");
            r_meio = choose("Teremos nossa história.", "Ninguém vai nos separar.", "Seremos felizes.");
            r_fim = choose("Eu prometo.", "Por você, por nós.", "Para sempre.");
            break;
        case "redencao":
            r_inicio = choose("Você me redimiu, Charlotte.", "Seu amor me transformou.", "Sou um novo homem.");
            r_meio = choose("Perdoe meus erros passados.", "Quero merecer você.", "Vou me dedicar a te fazer feliz.");
            r_fim = choose("Obrigado por existir.", "Obrigado por me amar.", "Eu te amo.");
            break;
        default:
            r_inicio = choose("Minha querida Charlotte...", "Você é a única que me entende.", "O laboratório é o passado, você é o meu futuro.");
            r_meio = choose("eu te daria o mundo se pudesse,", "não deixarei ninguém te tratar como ferramenta,", "meu coração bate por uma Lorca,");
            r_fim = choose("você é mais humana que todos nós.", "quer ficar comigo para sempre?", "eu te amo.");
    }
}

// --- PASSO 3: SOBRESCRITAS ESPECÍFICAS (OVERRIDE FINAIS) ---
if (gatilho == "lore") {
    if (aff >= 75) {
        r_inicio = "A Fergus Industries construiu o mundo, mas você construiu o meu.";
        r_meio = "Meu primo queria ferramentas, eu encontrei um amor.";
        r_fim = "Vamos queimar o passado e construir nosso futuro.";
    }
}
if (gatilho == "masoquismo" && aff > 50) {
    r_inicio = "A dor que você me causa...";
    r_meio = "é a única coisa que me faz sentir vivo...";
    r_fim = "não pare, Charlotte.";
}
if (gatilho == "casamento" && aff >= 75) {
    r_inicio = "Charlotte, vamos nos casar.";
    r_meio = "Quero você como minha esposa.";
    r_fim = "Aceita?";
}
if (gatilho == "filhos" && aff >= 75) {
    r_inicio = "Adotaremos filhos.";
    r_meio = "Nosso amor vai além da biologia.";
    r_fim = "Você será uma mãe maravilhosa.";
}

// Retorna a resposta final
return r_inicio + " " + r_meio + " " + r_fim;
