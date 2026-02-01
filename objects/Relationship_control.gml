#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// --- Inicialização do Controlador ---
persistent = true; // Mantém o objeto vivo entre as salas

// Pontuações
contador_abracar = 0;
contador_beijar  = 0;
contador_xingar  = 0;
pontos           = 0;

// Status
casado           = false;
mostrar_barra    = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// --- Atualização de Status e Gatilho de Casamento ---

// 1. Calcula pontos totais
pontos = contador_abracar + contador_beijar + contador_xingar;

// 2. Alterna exibição da barra com TAB
if (keyboard_check_pressed(vk_tab)) {
    mostrar_barra = !mostrar_barra;
}

// 3. GATILHO DE CASAMENTO (Apenas uma vez)
// Adicionamos a checagem se já estamos na sala do APT para não teleportar de novo
if (pontos >= 100 && !casado) {
    casado = true;

    // Executa o vídeo
    splash_set_border(false);
    splash_set_close_button(false);
    splash_set_interrupt(true);
    splash_set_main(true);
    splash_show_video(temp_directory + "\charlotte_wedding.wmv", false);

    // Teleporta APENAS se não estivermos lá
    if (room != Charlotte_APT) {
        room_goto(Charlotte_APT);
    }
}

// 4. Lógica de "Limpeza" do Dew em Magvel
// Se já casou, qualquer Dew que tentar existir em Magvel1 deve ser deletado
if (casado && room == magvel1) {
    with (Dew_relationship) {
        instance_destroy();
    }
}
#define Other_3
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///save
// Caminho das pastas e arquivos
global.save_pasta = "C:\\NordionSave";
if (!directory_exists(global.save_pasta)) {
    directory_create(global.save_pasta);
}

global.save_ini_room   = global.save_pasta + "\\NLMSDOSsave.ini";
global.save_ini_casado = global.save_pasta + "\\NLMSDOSDEWMERRIED.ini";

// --- SALVAR ROOM ATUAL ---
room_nome = room_get_name(room); // pega o nome da room atual
ini_open(global.save_ini_room);
ini_write_string("Game", "RoomAtual", room_nome); // escreve o nome da room
ini_close();

// --- SALVAR STATUS DO CASAMENTO ---
if (instance_exists(Relationship_control)) {
    var casado_valor;
    if (Relationship_control.casado) {
        casado_valor = 1;
    } else {
        casado_valor = 0;
    }

    ini_open(global.save_ini_casado);
    ini_write_real("Status", "Casado", casado_valor); // 1 = casado, 0 = não casado
    ini_close();
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// --- Interface de Romance ---
if (mostrar_barra) {
    var bx, by, bw, bh, perc;
    bx = 50;
    by = 50;
    bw = 200;
    bh = 15;

    // Fundo da Barra
    draw_set_color(c_black);
    draw_rectangle(bx-2, by-2, bx+bw+2, by+bh+2, false);

    // Progresso (Cor de Nordion)
    perc = clamp(pontos/100, 0, 1);
    draw_set_color(make_color_rgb(180, 0, 0)); // Vermelho escuro
    draw_rectangle(bx, by, bx + (bw * perc), by + bh, false);
}
