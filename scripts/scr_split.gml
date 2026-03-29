/// scr_split(text, delim)
// Divide uma string em uma ds_list usando um delimitador.
// Lembre-se: VocÃª DEVE destruir a lista com ds_list_destroy() apÃ³s o uso para nÃ£o dar memory leak!

var text, delim, list, pos, delim_len, token;
text = argument0;
delim = argument1;
list = ds_list_create();
delim_len = string_length(delim);

// Caso de seguranÃ§a: delimitador vazio
if (delim_len == 0) {
    ds_list_add(list, text);
    return list;
}

// Loop de busca otimizado
while (true) {
    pos = string_pos(delim, text); // Encontra a posiÃ§Ã£o do prÃ³ximo delimitador

    if (pos != 0) {
        // Extrai o que estÃ¡ ANTES do delimitador
        token = string_copy(text, 1, pos - 1);
        ds_list_add(list, token);

        // Deleta o que jÃ¡ foi processado + o delimitador da string original
        text = string_delete(text, 1, pos + delim_len - 1);
    } else {
        // NÃ£o hÃ¡ mais delimitadores, adiciona o que sobrou (Ãºltimo token)
        ds_list_add(list, text);
        break;
    }
}

return list;
