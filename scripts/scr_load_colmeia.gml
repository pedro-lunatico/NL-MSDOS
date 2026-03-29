/// scr_load_colmeia()
var i, total_virus, dado_lido;

if (file_exists("memoria_global_colmeia.ini")) {
    ini_open("memoria_global_colmeia.ini");

    total_virus = ini_read_real("Global", "quantidade", 0);

    // Limpa a lista atual para não duplicar dados
    ds_list_clear(global.virus_memoria);

    for (i = 0; i < total_virus; i += 1) {
        dado_lido = ini_read_string("Virus", string(i), "");
        if (dado_lido != "") {
            ds_list_add(global.virus_memoria, dado_lido);
        }
    }

    ini_close();
}
