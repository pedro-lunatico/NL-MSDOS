/// scr_escolher_dialogo_predefinido()
// Seleciona a melhor lista de diÃ¡logos com base no estado atual da Fir.

var lista_alvo, size, indice;
lista_alvo = -1;

// 1. PRIORIDADE MÃXIMA: ESTADOS AGUDOS (Vergonha ou Estresse CrÃ­tico)
if (vergonha > 50) {
    // Se ela estÃ¡ com muita vergonha, ela fica travada ou tÃ­mida
    lista_alvo = dialogos_amigavel; // Ou uma lista especÃ­fica 'dialogos_vergonha' se vocÃª tiver
}
else if (estresse > 80) {
    // Estresse alto sempre gera grosseria, independente de ser casada ou nÃ£o
    lista_alvo = dialogos_xingar;
}
// 2. ESTADOS RELACIONAIS (Se nÃ£o estiver em surto)
else {
    if (global.casado) {
        // Se casada e calma, usa diÃ¡logos Ã­ntimos
        lista_alvo = dialogos_coalescer;
    } else {
        // ProgressÃ£o de amizade para quem nÃ£o Ã© casado
        if (contador_relacao > 80)      lista_alvo = dialogos_romance_fir;
        else if (contador_relacao > 40) lista_alvo = dialogos_amigavel;
        else                            lista_alvo = dialogos_desconhecido;
    }
}

// 3. SEGURANÃ‡A E RETORNO
// Caso a lista escolhida esteja vazia ou nÃ£o exista
if (lista_alvo != -1) {
    size = ds_list_size(lista_alvo);
    if (size > 0) {
        indice = irandom(size - 1);
        return ds_list_find_value(lista_alvo, indice);
    }
}

return "Revolution... eu perdi o fio da meada.";
