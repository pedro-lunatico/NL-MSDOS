/// scr_parse_input(argument0)
// Quebra a string em palavras individuais numa ds_list

var str, list, pos, word;
str = string_lower(argument0) + " ";

// Limpeza de pontuação
str = string_replace_all(str, "?", "");
str = string_replace_all(str, "!", "");
str = string_replace_all(str, ".", "");
str = string_replace_all(str, ",", "");

list = ds_list_create();
pos = string_pos(" ", str);

while (pos > 0) {
    word = string_copy(str, 1, pos - 1);
    if (word != "") {
        ds_list_add(list, word);
    }
    str = string_delete(str, 1, pos);
    pos = string_pos(" ", str);
}

return list;
