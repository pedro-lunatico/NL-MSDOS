/// scr_responder_dew_trauma(acao)
// Cérebro de Diálogo: Preconceito e Desumanização
// Baseado nos estudos de "Violência Simbólica" e "Objetificação"

var tipo, r_inicio, r_meio, r_fim, status;
tipo = argument0;
status = objeto_status; // Variável que criamos no Step

r_inicio = "";
r_meio = "";
r_fim = "";

// --- LÓGICA DE RESPOSTA POR ESTADO MENTAL ---

if (status >= 70) {
    // ESTADO SUPREMACISTA: Ele a vê como um clone/objeto
    switch(tipo) {
        case "abracar":
            r_inicio = "Não me toque agora.";
            r_meio = "Você foi projetada para obedecer,";
            r_fim = "não para buscar conforto.";
            break;

        case "beijar":
            r_inicio = "Um beijo de um simulacro?";
            r_meio = "Fergus diz que vocês nem sentem nada de verdade.";
            r_fim = "Saia de perto.";
            break;

        case "xingar":
            r_inicio = "Pode gritar.";
            r_meio = "Palavras de um objeto não mudam a realidade.";
            r_fim = "Você ainda pertence à Fergus Industries.";
            break;

        case "conversar":
            r_inicio = "O que um produto como você...";
            r_meio = "teria a dizer que eu já não saiba?";
            r_fim = "Volte ao seu protocolo.";
            break;

        case "coalescer":
            r_inicio = "Isso é apenas manutenção.";
            r_meio = "Não confunda nossa conexão com humanidade.";
            r_fim = "Você é uma ferramenta útil, nada mais.";
            break;
    }
}

else if (status < 70 && estresse > 70) {
    // ESTADO INSTÁVEL: Ele está em conflito (Trauma de Fergus)
    switch(tipo) {
        case "abracar":
            r_inicio = "Eu... eu não sei.";
            r_meio = "Às vezes eu olho para você e vejo o que o Fergus descreve.";
            r_fim = "Me deixe sozinho por um tempo.";
            break;

        case "beijar":
            r_inicio = "Charlotte...";
            r_meio = "Eu tenho medo de me tornar como ele.";
            r_fim = "Por favor, não me deixe perder o controle.";
            break;

        default:
            r_inicio = "Minha cabeça está um caos.";
            r_meio = "As vozes dele não param.";
            r_fim = "Não me pressione.";
            break;
    }
}

else {
    // ESTADO PROTETOR / SUBMISSO: Ele a vê como humana
    switch(tipo) {
        case "abracar":
            r_inicio = "Você é a única coisa...";
            r_meio = "que me faz sentir que não sou um monstro.";
            r_fim = "Obrigado por estar aqui.";
            break;

        case "beijar":
            r_inicio = "Eu não mereço você.";
            r_meio = "Um herdeiro quebrado e uma mulher livre.";
            r_fim = "Eu prometo te proteger deles... e de mim.";
            break;

        case "xingar":
            // Inversão masoquista: No estado submisso, ele aceita a dor
            r_inicio = "Dói...";
            r_meio = "mas se isso te faz sentir melhor, continue.";
            r_fim = "Eu sou seu, de qualquer forma.";
            break;

        default:
            r_inicio = "Estou ouvindo.";
            r_meio = "O que você precisa, Charlotte?";
            r_fim = "";
            break;
    }
}

return r_inicio + " " + r_meio + " " + r_fim;
