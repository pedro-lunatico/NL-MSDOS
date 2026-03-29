/// scr_string_trim(str)
var s;
s = argument0;

// Remove espaços à esquerda
while (string_char_at(s, 1) == " ") {
    s = string_delete(s, 1, 1);
}

// Remove espaços à direita
while (string_char_at(s, string_length(s)) == " ") {
    s = string_delete(s, string_length(s), 1);
}

return s;
