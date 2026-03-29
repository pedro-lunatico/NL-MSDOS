/// scr_aprender_string(str, cat)
var s, c, h;
s = argument0;
c = argument1;
h = ds_grid_height(memoria_pessoal);

// Verifica se já conhece essa frase para não repetir no INI
for (i=0; i<h; i+=1) {
    if (ds_grid_get(memoria_pessoal, 0, i) == s) return 0;
}

// Adiciona na Memória RAM
ds_grid_resize(memoria_pessoal, 3, h + 1);
ds_grid_set(memoria_pessoal, 0, h, s);
ds_grid_set(memoria_pessoal, 1, h, c);

// Salva no HD (Individual)
ini_open(meu_ini_individual);
ini_write_string("M", "p" + string(h), s);
ini_write_string("M", "c" + string(h), c);
ini_write_real("Sistema", "total", h + 1);
ini_close();
