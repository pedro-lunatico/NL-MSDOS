/// scr_buscar_melhor_resposta(frase_jogador)
// Retorna um ds_map com "resposta", "categoria" e "indice" ou -1 se não achar nada.

var frase, melhor_score, melhor_indice, i, total;
frase = string_lower(argument0);
melhor_score = 0;
melhor_indice = -1;
total = ds_grid_height(global.memoria_grid);

// 1. Percorre a Grid de Memórias
for (i = 0; i < total; i += 1) {
    var pergunta_banco, score_atual, palavras_banco, j, qtd_palavras;
    pergunta_banco = ds_grid_get(global.memoria_grid, 0, i); // Coluna 0: Pergunta
    score_atual = 0;

    // Se a frase for idêntica, score máximo imediato
    if (frase == pergunta_banco) {
        score_atual = 100;
    } else {
        // Comparação por palavras-chave (Fuzzy simplificado)
        // Divide a pergunta do banco em palavras (espaços)
        var temp_pergunta; temp_pergunta = pergunta_banco + " ";
        while (string_pos(" ", temp_pergunta) > 0) {
            var palavra;
            palavra = string_copy(temp_pergunta, 1, string_pos(" ", temp_pergunta) - 1);
            temp_pergunta = string_delete(temp_pergunta, 1, string_pos(" ", temp_pergunta));

            // Se a palavra do banco existir na frase do jogador, ganha pontos
            if (string_length(palavra) > 2) { // Ignora "de", "e", "o"
                if (string_pos(palavra, frase) > 0) score_atual += 10;
            }
        }
    }

    // Multiplica pelo peso da memória (Coluna 3 da Grid)
    score_atual += ds_grid_get(global.memoria_grid, 3, i);

    // Verifica se esta é a melhor resposta até agora
    if (score_atual > melhor_score) {
        melhor_score = score_atual;
        melhor_indice = i;
    }
}

// 2. Retorna o Resultado
if (melhor_score >= 10) { // Limite mínimo de 10 pontos para aceitar a resposta
    var resultado;
    resultado = ds_map_create();
    ds_map_add(resultado, "resposta", ds_grid_get(global.memoria_grid, 1, melhor_indice));
    ds_map_add(resultado, "categoria", ds_grid_get(global.memoria_grid, 2, melhor_indice));
    ds_map_add(resultado, "indice", melhor_indice);
    return resultado;
} else {
    return -1;
}
