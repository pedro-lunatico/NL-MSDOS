/// scr_similaridade(string1, string2)
// Retorna um valor entre 0 e 1 (Índice de Jaccard)
// 0 = Nada a ver | 1 = Frases idênticas

var t1, t2, words1, words2, size1, size2, i, j, count_intersec, count_union, w1, w2;

// Captura dos argumentos (Obrigatório no GM 8.1)
t1 = scr_normalizar(argument0);
t2 = scr_normalizar(argument1);

// Transforma as frases em listas de palavras
words1 = scr_split(t1, " ");
words2 = scr_split(t2, " ");

size1 = ds_list_size(words1);
size2 = ds_list_size(words2);

// Se as duas estiverem vazias, não há similaridade
if (size1 == 0 && size2 == 0) {
    ds_list_destroy(words1);
    ds_list_destroy(words2);
    return 0;
}

count_intersec = 0;

// Loop de comparação (Otimizado: salvando o tamanho em variáveis)
for (i = 0; i < size1; i += 1) {
    w1 = ds_list_find_value(words1, i);

    for (j = 0; j < ds_list_size(words2); j += 1) {
        w2 = ds_list_find_value(words2, j);

        if (w1 == w2) {
            count_intersec += 1;
            // Remove da segunda lista para não contar a mesma palavra duas vezes
            ds_list_delete(words2, j);
            break;
        }
    }
}

// Cálculo da União (Soma das palavras únicas)
count_union = (size1 + size2) - count_intersec;

// Limpeza de memória (Fundamental para não travar o jogo)
ds_list_destroy(words1);
ds_list_destroy(words2);

// Retorna o resultado final
if (count_union > 0) {
    return (count_intersec / count_union);
} else {
    return 0;
}
