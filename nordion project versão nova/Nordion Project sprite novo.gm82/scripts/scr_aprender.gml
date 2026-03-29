/// scr_aprender_dew(pergunta, resposta, categoria, peso)
var p, r, cat, pe, arquivo, total;
p   = argument0;
r   = argument1;
cat = argument2;
pe  = argument3;
arquivo = "memoria_dew.ini";

ini_open(arquivo);
total = ini_read_real("Config", "total_memorias", 0);
total += 1;

// Grava a nova memória no fim do ficheiro
ini_write_string("Memorias", "pergunta" + string(total), p);
ini_write_string("Memorias", "resposta" + string(total), r);
ini_write_string("Memorias", "categoria" + string(total), cat);
ini_write_real("Memorias", "peso" + string(total), pe);

// Atualiza o total
ini_write_real("Config", "total_memorias", total);
ini_close();

// Recarrega a grid para o Dew usar o conhecimento novo imediatamente
scr_carregar_memorias();
