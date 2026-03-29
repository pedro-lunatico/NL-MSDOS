/// scr_normalizar(texto)
// Retorna texto limpo para comparação
txt = string_lower(argument0);
// Remover acentos (substituição simples)
txt = string_replace_all(txt, "á", "a");
txt = string_replace_all(txt, "à", "a");
txt = string_replace_all(txt, "ã", "a");
txt = string_replace_all(txt, "â", "a");
txt = string_replace_all(txt, "é", "e");
txt = string_replace_all(txt, "ê", "e");
txt = string_replace_all(txt, "í", "i");
txt = string_replace_all(txt, "ó", "o");
txt = string_replace_all(txt, "ô", "o");
txt = string_replace_all(txt, "õ", "o");
txt = string_replace_all(txt, "ú", "u");
txt = string_replace_all(txt, "ü", "u");
txt = string_replace_all(txt, "ç", "c");
// Remover pontuação comum
txt = string_replace_all(txt, ".", "");
txt = string_replace_all(txt, ",", "");
txt = string_replace_all(txt, "?", "");
txt = string_replace_all(txt, "!", "");
txt = string_replace_all(txt, ":", "");
txt = string_replace_all(txt, ";", "");
txt = string_replace_all(txt, "\", "");
txt = string_replace_all(txt, "'", "");
txt = string_replace_all(txt, "(", "");
txt = string_replace_all(txt, ")", "");
txt = string_replace_all(txt, "[", "");
txt = string_replace_all(txt, "]", "");
return txt;
