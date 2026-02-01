// Argumentos: argument0 (pasta), argument1 (lista para salvar)
var path, file, sub_folders;
path = argument0;

// 1. Busca Executáveis
file = file_find_first(path + "*.exe", 0);
while (file != "") {
    ds_list_add(argument1, path + file);
    file = file_find_next();
}
file_find_close();

// 2. Busca Arquivos Batch
file = file_find_first(path + "*.bat", 0);
while (file != "") {
    ds_list_add(argument1, path + file);
    file = file_find_next();
}
file_find_close();

// 3. ENTRAR EM SUBPASTAS (Recursão)
// No GM8, usamos o atributo 16 (fa_directory)
file = file_find_first(path + "*.*", 16);
while (file != "") {
    if (file != "." && file != "..") {
        // Verifica se o que encontrou é realmente um diretório
        if (file_attributes(path + file, 16)) {
            scr_find_files(path + file + "\", argument1);
        }
    }
    file = file_find_next();
}
file_find_close();
