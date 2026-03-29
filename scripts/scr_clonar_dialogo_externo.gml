/// scr_clonar_dialogo_externo(lista_id)
var lista, tam, frase_raw, r, pos_separador;
lista = argument0;
tam = ds_list_size(lista);

if (tam > 0) {
    r = irandom(tam - 1);
    frase_raw = ds_list_find_value(lista, r);

    // --- LÓGICA DE LIMPEZA AMPLA ---
    // Procura pelo último separador comum em scripts de diálogo (";" ou ":")
    // Se encontrar, ele assume que o que vem antes é ID/Tag e o que vem depois é a fala.

    var p1, p2;
    p1 = string_pos("; ", frase_raw);
    p2 = string_pos(": ", frase_raw);

    pos_separador = max(p1, p2);

    if (pos_separador > 0) {
        // Corta tudo antes do separador e limpa espaços
        frase_raw = string_delete(frase_raw, 1, pos_separador + 1);
    }

    // Remove tags de rádio ou sistema entre colchetes [exemplo] ou barras |tag|
    // O Markov só quer as palavras puras.
    frase_raw = scr_string_trim(frase_raw);

    // --- APRENDIZADO ---
    if (frase_raw != "") {
        scr_gerar_frase_markov(frase_raw);
        flash_timer = 15; // Feedback visual: a clone "brilhou" ao aprender
        return frase_raw;
    }
}
return "";
