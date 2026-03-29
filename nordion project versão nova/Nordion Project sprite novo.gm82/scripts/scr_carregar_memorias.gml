/// scr_carregar_memorias()
// Este script carrega o banco de dados do Dew (ou Fir) para a Grid.

var arquivo, secao_total, chave_total;
arquivo = "memoria_dew.ini";
secao_total = "Sistema"; // No teu ini da Fir, o total está em [Sistema]
chave_total = "total_memorias";

// 1. PROTEÇÃO: Se o arquivo não existir, cria um esqueleto básico
if (!file_exists(arquivo)) {
    ini_open(arquivo);
    ini_write_real(secao_total, chave_total, 0);
    ini_close();
}

// 2. ABRIR E LER O TOTAL
ini_open(arquivo);
var total;
total = ini_read_real(secao_total, chave_total, 0);

// 3. GERENCIAMENTO DE MEMÓRIA (Substituindo ds_exists)
// No Create Event do objeto, deves definir global.memoria_grid_dew = -1;
if (global.memoria_grid_dew >= 0) {
    ds_grid_destroy(global.memoria_grid_dew);
}

// 4. CRIAR A GRID E PREENCHER
if (total > 0) {
    // 4 Colunas: 0=Pergunta, 1=Resposta, 2=Categoria, 3=Peso
    global.memoria_grid_dew = ds_grid_create(4, total);

    var i, idx_string;
    for (i = 0; i < total; i += 1) {
        idx_string = string(i + 1); // O seu ini começa em 1, 2, 3...

        var p, r, c, pe;
        // Lê de acordo com as seções do seu ficheiro .ini
        p  = ini_read_string("Entradas", idx_string, "");
        r  = ini_read_string("Respostas", idx_string, "...");
        c  = ini_read_string("Categorias", idx_string, "none");
        pe = ini_read_real("Pesos", idx_string, 1);

        // Preenche a Grid para busca rápida em tempo real
        ds_grid_set(global.memoria_grid_dew, 0, i, p);
        ds_grid_set(global.memoria_grid_dew, 1, i, r);
        ds_grid_set(global.memoria_grid_dew, 2, i, c);
        ds_grid_set(global.memoria_grid_dew, 3, i, pe);
    }
} else {
    // Caso o arquivo esteja vazio, cria uma grid mínima para evitar erro de busca
    global.memoria_grid_dew = ds_grid_create(4, 1);
    ds_grid_set(global.memoria_grid_dew, 0, 0, "dummy");
}

ini_close();
