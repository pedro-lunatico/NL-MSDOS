/// scr_aprender_fofoca(alvo, id_memo)
var alvo, id_m, categoria, peso;
alvo = argument0;
id_m = argument1;

categoria = ds_grid_get(global.grid_memoria, 2, id_m);
peso = ds_grid_get(global.grid_memoria, 3, id_m);

// Aumenta o peso daquela categoria na mente da outra clone
// Se a fofoca for sobre "becker" ou "berserk" (peso alto), a clone fica mais estressada
if (categoria == "becker" || categoria == "status") {
    alvo.peso_trabalhar -= 2; // Ficar sabendo do Becker tira o foco do trabalho
    alvo.peso_socializar += 1;
}

// Salva que esta clone agora "conhece" esse fato no INI individual dela
ini_open(alvo.meu_ini_individual);
ini_write_real("Memorias_Aprendidas", string(id_m), 1);
ini_close();
