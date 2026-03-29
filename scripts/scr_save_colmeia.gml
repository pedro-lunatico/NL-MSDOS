/// scr_save_colmeia()
var i, total_virus;
ini_open("memoria_global_colmeia.ini");

total_virus = ds_list_size(global.virus_memoria);
ini_write_real("Global", "quantidade", total_virus);

for (i = 0; i < total_virus; i += 1) {
    // Salva cada item da lista (palavra|explicacao) com uma chave numerica
    ini_write_string("Virus", string(i), ds_list_find_value(global.virus_memoria, i));
}

ini_close();
