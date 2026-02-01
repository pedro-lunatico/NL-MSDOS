/// scr_get_item_info(nome_item, modo)
// modo 0 = retorna descrição | modo 1 = retorna cor

var nome, modo;
nome = argument0;
modo = argument1;

if (modo == 0) {
    // --- DESCRIÇÕES ---
    if (nome == "Fe") return "Ferro puro. Um metal resistente usado em ligas.";
    if (nome == "H")  return "Hidrogenio. Altamente inflamavel e leve.";
    if (nome == "O")  return "Oxigenio. Essencial para a combustao e vida.";
    if (nome == "Ag") return "Prata. Conduz energia e possui propriedades purificadoras.";
    if (nome == "Cl") return "Cloro. Um gas reativo e perigoso em altas doses.";
    if (nome == "C")  return "Carbono. A base da vida e de compostos instaveis.";

    // Itens de Crafting
    if (nome == "H2O") return "Agua pura. Utilizada para neutralizar reacoes.";
    if (nome == "Solução Regenerativa") return "Composto de H+O+O. Acelera a recuperacao de tecidos.";
    if (nome == "Nuvem Catalisadora") return "Mistura de Ag+Cl. Cria uma névoa que altera reacoes proximas.";
    if (nome == "Composto Inflamável") return "Hidrocarboneto (C+H+H). Extremamente perigoso perto de chamas.";
    if (nome == "Reagente de Ferrugem Ativa") return "Oxidante (Fe+O). Corroi estruturas metalicas rapidamente.";
    if (nome == "Agente Purificador") return "Solucao de Ag+H+O. Remove impurezas e toxinas quimicas.";
    if (nome == "Carga Asfixiante") return "Dioxido de Carbono concentrado. Remove o ar do ambiente.";
    if (nome == "Liga Instável") return "Mistura metalica (Fe+C+O). Pode explodir sob pressao.";
    if (nome == "Gás Irritante") return "Acido Cloridrico gasoso. Causa ardencia nos olhos e garganta.";

    // Pokemons / Especiais
    if (nome == "makernimite") return "Pedra misteriosa que emana uma energia ancestral.";
    if (nome == "volcarona") return "Pokemon Sol. Suas escamas queimam como o nucleo terrestre.";
    if (nome == "tepig") return "Pokemon Porco de Fogo. Adora frutas torradas.";
    if (nome == "magikarp") return "Um Pokemon que apenas salta. Parece patetico, mas e resistente.";

    return "Item sem descricao definida.";
}

if (modo == 1) {
    // --- CORES ---
    // Vermelho para Pokemons
    if (nome == "tepig" || nome == "volcarona" || nome == "magikarp") return make_color_rgb(255, 80, 80);
    // Amarelo para Especiais/Lendarios
    if (nome == "makernimite") return make_color_rgb(255, 220, 50);
    // Verde para Quimicos Base
    if (string_length(nome) <= 2) return make_color_rgb(80, 255, 80);
    // Ciano para Itens Craftados
    return make_color_rgb(100, 200, 255);
}
