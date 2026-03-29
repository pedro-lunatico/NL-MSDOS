#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Create Event de main_menu_controller
current_index = 0;
base_x = room_width/2;
offset_x = 200;

// referências para os 4 objetos do menu
menu_0 = noone;
menu_1 = noone;
menu_2 = noone;
menu_3 = noone;

// contador para coleta inicial
c = 0;

// Inicializa variáveis globais do diálogo, se ainda não existirem
if (!variable_global_exists("dialogo_ativo")) {
    global.dialogo_ativo = false;
}
if (!variable_global_exists("mensagens")) {
    global.mensagens = ds_list_create();
}
if (!variable_global_exists("texto")) {
    global.texto = "";
}
if (!variable_global_exists("caracteres_mostrados")) {
    global.caracteres_mostrados = 0;
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
global.load_next_step = false;
global.save_path = "C:\\NordionSave\\NLMSDOS_GAMESAV";
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// ==========================
// DECLARAÇÃO DE VARIÁVEIS LOCAIS
// ==========================
f = 0;
f2 = 0;
saved_room_str = "";
casado_val = 0;

// ==========================
// FLAG ENTER
// ==========================
if (!variable_local_exists("enter_pressed")) enter_pressed = false;

// ==========================
// COLETAR OS 4 ITENS DO MENU (somente se ainda não coletados)
// ==========================
if (menu_3 == noone)
{
    with (new_game_button) { other.menu_0 = id; }
    with (load_game_button) { other.menu_1 = id; }
    with (TP_Tutorial1) { other.menu_2 = id; }
    with (settings_button) { other.menu_3 = id; }
}

// ==========================
// NAVEGAÇÃO COM TECLAS
// ==========================
if (keyboard_check_pressed(vk_right)) current_index += 1;
if (keyboard_check_pressed(vk_left)) current_index -= 1;

if (current_index < 0) current_index = 3;
if (current_index > 3) current_index = 0;

// ==========================
// ORGANIZAÇÃO DOS ITENS (posição, escala)
// ==========================
i = 0;
repeat(4)
{
    inst = noone;
    if (i == 0) inst = menu_0;
    if (i == 1) inst = menu_1;
    if (i == 2) inst = menu_2;
    if (i == 3) inst = menu_3;

    if (inst != noone)
    {
        inst.target_x = base_x + (i - current_index) * offset_x;

        if (i == current_index)
            inst.target_scale = 1.6;
        else
            inst.target_scale = 1.0;
    }
    i += 1;
}

// ==========================
// EXECUTAR FUNÇÃO COM ENTER
// ==========================
if (keyboard_check_pressed(vk_enter) && !enter_pressed)
{
    enter_pressed = true;

    // -----------------
    // Opção 0 — NEW GAME
    // -----------------
    if (current_index == 0)
    {
        room_goto(Fergus);
    }

    // -----------------
    // Opção 1 — LOAD GAME
    // -----------------
    else if (current_index == 1)
    {
        global.save_pasta = "C:\\NordionSave";
        global.load_caminho = global.save_pasta + "\\NL_MSDOSsave.dat";
        global.load_casamento = global.save_pasta + "\\NLMSDOSDEWMERRIED.dat";

        if (!variable_global_exists("mensagens"))
        {
            global.mensagens = ds_list_create();
            global.dialogo_ativo = false;
            global.caracteres_mostrados = 0;
            global.velocidade_letra = 2;
            global.contador = 0;
            global.mensagem_atual = 0;
            global.texto = "";
        }

        if (file_exists(global.load_caminho))
        {
            // ---- SALA ----
            f = file_text_open_read(global.load_caminho);
            saved_room_str = file_text_read_string(f);
            file_text_close(f);

            room_index_to_load = -1;
            i = room_first;
            while (i != -1)
            {
                if (room_get_name(i) == saved_room_str)
                {
                    room_index_to_load = i;
                    break;
                }
                i = room_next(i);
            }

            if (room_index_to_load != -1)
            {
                // ---- CASAMENTO ----
                global.casado = 0;

                if (file_exists(global.load_casamento))
                {
                    f2 = file_text_open_read(global.load_casamento);
                    casado_str = file_text_read_string(f2);
                    file_text_close(f2);

                    casado_str = string_replace_all(casado_str, chr(13), "");
                    casado_str = string_replace_all(casado_str, chr(10), "");
                    casado_str = string_replace_all(casado_str, " ", "");

                    if (string_length(casado_str) > 0)
                    {
                        global.casado = (real(casado_str) == 1);
                    }
                }

                // ---- CRIA CONTROLADORES SE NÃO EXISTIREM ----
                if (!instance_exists(Relationship_control))
                    instance_create(-1, -1, Relationship_control);

                if (!instance_exists(inventory_controller))
                    instance_create(-2, -2, inventory_controller);

                if (!instance_exists(level_control))
                    instance_create(-3, -3, level_control);

                // <-- **AQUI FALTAVA O }** NO SEU ORIGINAL!!!

                // ---- APLICA CASAMENTO ----
                if (instance_exists(Relationship_control))
                    Relationship_control.casado = global.casado;

                room_goto(room_index_to_load);
            }
            else
            {
                ds_list_add(global.mensagens, "Room do save não existe!");
                global.dialogo_ativo = true;
                global.caracteres_mostrados = 0;
                global.contador = 0;
                global.mensagem_atual = 0;
                global.texto = "";
            }
        }
        else
        {
            ds_list_add(global.mensagens, "Não há dados salvos!");
            global.dialogo_ativo = true;
            global.caracteres_mostrados = 0;
            global.contador = 0;
            global.mensagem_atual = 0;
            global.texto = "";
        }
    }

    // -----------------
    // Opção 2 — TUTORIAL
    // -----------------
    else if (current_index == 2)
    {
        room_goto(Tutorial_1);
    }

    // -----------------
    // Opção 3 — SETTINGS
    // -----------------
    else if (current_index == 3)
    {
        room_goto(setting_room);
    }
}

// ==========================
// RESET ENTER
// ==========================
if (!keyboard_check(vk_enter)) enter_pressed = false;
#define Other_5
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=212
invert=0
arg0=Nordion Lands Theme
*/
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Desenha o próprio sprite como botão
draw_self();

// ------------------------------
// Balão de diálogo Frutiger Aero Avançado
// ------------------------------

// Declarações compatíveis GM8.1
x0 = 50;
y0 = room_height - 90;
largura = room_width - 100;
altura = 100;
steps = altura; // linhas do degradê
i = 0;
c = 0;

if (global.dialogo_ativo && ds_list_size(global.mensagens) > 0) {

    // Fundo com degradê vertical
    for (i = 0; i < steps; i += 1) {
        c = make_color_rgb(60 + (i * 50 / steps), 150 + (i * 50 / steps), 255);
        draw_set_color(c);
        draw_rectangle(x0, y0 + i, x0 + largura, y0 + i + 1, false);
    }

    // Borda arredondada clara
    draw_set_color(make_color_rgb(180, 220, 255));
    draw_roundrect(x0+1, y0+1, x0 + largura-1, y0 + altura-1, false);

    // Texto com sombra semi-transparente
    draw_set_alpha(0.2); // transparência da sombra
    draw_set_color(c_black);
    draw_text_ext(x0 + 16, y0 + 16,
        string_copy(global.texto, 1, global.caracteres_mostrados),
        largura - 30, -1);

    // Texto principal
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_text_ext(x0 + 15, y0 + 15,
        string_copy(global.texto, 1, global.caracteres_mostrados),
        largura - 30, -1);
}
draw_text(10, 10, "INDEX = " + string(current_index));
