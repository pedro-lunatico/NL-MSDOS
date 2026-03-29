/// scr_aprender_virus(entrada, resposta, categoria)
var ent, resp, cat, i, ja_sabe;
ent = argument0; resp = argument1; cat = argument2;
ja_sabe = false;

// Verifica se já existe essa entrada na grid
for (i = 0; i < ds_grid_height(memoria_pessoal); i += 1) {
    if (ds_grid_get(memoria_pessoal, 0, i) == ent) {
        ja_sabe = true;
        break;
    }
}

// Se não sabe, infecta a grid dela com a nova informação
if (!ja_sabe) {
    var hh; hh = ds_grid_height(memoria_pessoal);
    ds_grid_resize(memoria_pessoal, 4, hh + 1);
    ds_grid_set(memoria_pessoal, 0, hh, ent);
    ds_grid_set(memoria_pessoal, 1, hh, resp);
    ds_grid_set(memoria_pessoal, 2, hh, cat);
    ds_grid_set(memoria_pessoal, 3, hh, 1); // Peso inicial do vírus
}
