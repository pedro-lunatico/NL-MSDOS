/// scr_markov_aprender(frase)
var str, palavra_atual, palavra_proxima, lista_palavras;
str = argument0 + " [FIM]"; // Marca o final da frase
lista_palavras = ds_list_create();

// --- 1. Split da String (Manual para GM8.1) ---
var temp_str; temp_str = "";
for (i=1; i<=string_length(str); i+=1) {
    var char; char = string_char_at(str, i);
    if (char != " ") {
        temp_str += char;
    } else {
        if (temp_str != "") ds_list_add(lista_palavras, temp_str);
        temp_str = "";
    }
}

// --- 2. Mapeamento de Adjacência ---
// Usamos uma Grid para salvar: [0]Palavra [1]O que vem depois [2]Peso
for (i=0; i<ds_list_size(lista_palavras)-1; i+=1) {
    palavra_atual = ds_list_find_value(lista_palavras, i);
    palavra_proxima = ds_list_find_value(lista_palavras, i+1);

    var h; h = ds_grid_height(memoria_pessoal);
    ds_grid_resize(memoria_pessoal, 3, h + 1);
    ds_grid_set(memoria_pessoal, 0, h, string_lower(palavra_atual));
    ds_grid_set(memoria_pessoal, 1, h, string_lower(palavra_proxima));
    ds_grid_set(memoria_pessoal, 2, h, 1); // Peso inicial
}

ds_list_destroy(lista_palavras);
