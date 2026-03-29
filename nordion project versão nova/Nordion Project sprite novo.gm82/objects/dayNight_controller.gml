#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Create Event: Inicialização do Ciclo, Listas e Mapeamento de Spawns

global.total_steps = 57000;
global.ciclo_steps = global.total_steps / 6;
global.step_counter = 0;
global.dia_noite = 0; // 0 = Dia, 1 = Noite
global.evento_atual = 1;

// --- Variáveis de Notificação ---
notificacao_ativa = false;
notificacao_texto = "";
notificacao_timer = 0;
notificacao_duracao = 180;

// --- 1. Objetos que aparecem SOMENTE de DIA ---
global.objs_dia = ds_list_create();
ds_list_add(global.objs_dia, Predio_Castelia_City);
ds_list_add(global.objs_dia, PredioCasteliaCity_x0_7);
ds_list_add(global.objs_dia, predioCasteliaCity_x0_5);
ds_list_add(global.objs_dia, Mark_OBJ);
ds_list_add(global.objs_dia, Leaf_Enemy);
ds_list_add(global.objs_dia, Hatsune_Miku_OBJ);
ds_list_add(global.objs_dia, Fergus_OBJ);
ds_list_add(global.objs_dia, Osaka);
ds_list_add(global.objs_dia, Colton);
ds_list_add(global.objs_dia, TP_MIKUBYL);

// --- 2. Objetos que aparecem SOMENTE de NOITE ---
global.objs_noite = ds_list_create();
ds_list_add(global.objs_noite, ponto_de_corrida);
ds_list_add(global.objs_noite, Dew_relationship);
ds_list_add(global.objs_noite, Nami_Burglar);
ds_list_add(global.objs_noite, Dawn);
ds_list_add(global.objs_noite, carbono);


// --- 3. MAPEAMENTO DE OBJETOS CÍCLICOS PARA SPAWN POINTS ---
// Mapeia o OBJETO_ALVO para o OBJETO_SPAWN (colocado na sala).
global.objs_spawns = ds_map_create();

// ATENÇÃO: SUBSTITUA 'obj_Spawn_XX' pelos seus objetos reais de spawn points
ds_map_add(global.objs_spawns, Predio_Castelia_City, furniture);
ds_map_add(global.objs_spawns, PredioCasteliaCity_x0_7, furniture);
ds_map_add(global.objs_spawns, predioCasteliaCity_x0_5, furniture);
ds_map_add(global.objs_spawns, Mark_OBJ, furniture);
ds_map_add(global.objs_spawns, Leaf_Enemy, furniture);
ds_map_add(global.objs_spawns, Hatsune_Miku_OBJ, furniture);
ds_map_add(global.objs_spawns, Fergus_OBJ, furniture);
ds_map_add(global.objs_spawns, Osaka, furniture);
ds_map_add(global.objs_spawns, Colton, furniture);
ds_map_add(global.objs_spawns, TP_MIKUBYL, furniture); // Usa 10 spawns para os 10 objetos
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Step Event: Controle de Ciclo, Afundamento e Criação de Objetos

// --- 0. Atualização do Timer da Notificação ---
if (notificacao_ativa) {
    notificacao_timer -= 1;
    if (notificacao_timer <= 0) {
        notificacao_ativa = false;
    }
}


// --- 1. Controle de Ciclo Dia/Noite ---

global.step_counter += 1;

if (global.step_counter >= global.ciclo_steps) {
    global.step_counter = 0;
    global.dia_noite = 1 - global.dia_noite;

    var i;
    var obj_temp;

    if (global.dia_noite == 0) { // Virou DIA ☀️

        // A. AFUNDA/DELETA (SINALIZA) Objetos da NOITE
        for (i = 0; i < ds_list_size(global.objs_noite); i += 1) {
            obj_temp = ds_list_find_value(global.objs_noite, i);
            with (obj_temp) {
                if (instance_exists(id)) afundando = true; // SINALIZANDO
            }
        }

        // B. CRIA Objetos do DIA (COM VERIFICAÇÃO DE EXISTÊNCIA E SPAWN POINT)
        for (i = 0; i < ds_list_size(global.objs_dia); i += 1) {
            obj_temp = ds_list_find_value(global.objs_dia, i);

            if (!instance_exists(obj_temp)) { // Verifica: Objeto Alvo NÃO existe?

                spawn_obj_type = ds_map_find_value(global.objs_spawns, obj_temp);

                if (instance_exists(spawn_obj_type)) { // Verifica: Spawn Point existe?
                    spawn_id = instance_find(spawn_obj_type, 0);
                    instance_create(spawn_id.x, spawn_id.y, obj_temp); // CRIA
                }
            }
        }

        // C. Notificação
        notificacao_ativa = true;
        notificacao_texto = "O dia amanheceu! ☀️";
        notificacao_timer = notificacao_duracao;

    } else { // Virou NOITE 🌙

        // A. AFUNDA/DELETA (SINALIZA) Objetos do DIA
        for (i = 0; i < ds_list_size(global.objs_dia); i += 1) {
            obj_temp = ds_list_find_value(global.objs_dia, i);
            with (obj_temp) {
                if (instance_exists(id)) afundando = true;
            }
        }

        // B. CRIA Objetos da NOITE (COM VERIFICAÇÃO DE EXISTÊNCIA E SPAWN POINT)
        for (i = 0; i < ds_list_size(global.objs_noite); i += 1) {
            obj_temp = ds_list_find_value(global.objs_noite, i);

            if (!instance_exists(obj_temp)) { // Verifica: Objeto Alvo NÃO existe?

                spawn_obj_type = ds_map_find_value(global.objs_spawns, obj_temp);

                if (instance_exists(spawn_obj_type)) { // Verifica: Spawn Point existe?
                    spawn_id = instance_find(spawn_obj_type, 0);
                    instance_create(spawn_id.x, spawn_id.y, obj_temp); // CRIA
                }
            }
        }

        // C. Notificação
        notificacao_ativa = true;
        notificacao_texto = "A noite chegou! 🌙";
        notificacao_timer = notificacao_duracao;
    }

    // 2. Controle dos 100 Eventos
    global.evento_atual += 1;
    if (global.evento_atual > 100) global.evento_atual = 1;
}
#define Keyboard_35
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Keyboard Event: Alternar Dia/Noite Imediatamente (DEBUG - COMPLETO)

global.step_counter = 0;
global.dia_noite = 1 - global.dia_noite;

var i;
var obj_temp;

if (global.dia_noite == 0) { // Virou Dia

    // 1. AFUNDA/DELETA Objetos da NOITE
    for (i = 0; i < ds_list_size(global.objs_noite); i += 1) {
        obj_temp = ds_list_find_value(global.objs_noite, i);
        with (obj_temp) {
            if (instance_exists(id)) afundando = true;
        }
    }

    // 2. CRIA Objetos do DIA
    for (i = 0; i < ds_list_size(global.objs_dia); i += 1) {
        instance_create(500, 500, ds_list_find_value(global.objs_dia, i));
    }

    notificacao_ativa = true;
    notificacao_texto = "DEBUG: Dia Ativado!";
    notificacao_timer = notificacao_duracao;

} else { // Virou Noite

    // 1. AFUNDA/DELETA Objetos do DIA
    for (i = 0; i < ds_list_size(global.objs_dia); i += 1) {
        obj_temp = ds_list_find_value(global.objs_dia, i);
        with (obj_temp) {
            if (instance_exists(id)) afundando = true;
        }
    }

    // 2. CRIA Objetos da NOITE
    for (i = 0; i < ds_list_size(global.objs_noite); i += 1) {
        instance_create(500, 500, ds_list_find_value(global.objs_noite, i));
    }

    notificacao_ativa = true;
    notificacao_texto = "DEBUG: Noite Ativada!";
    notificacao_timer = notificacao_duracao;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Draw Event: Efeito de Noite e Notificação de Ciclo

// --- 1. Efeito de Noite ---
if (global.dia_noite == 1) {
    draw_set_alpha(0.6);
    draw_set_color(c_black);
    draw_rectangle(0, 0, room_width, room_height, false);
    draw_set_alpha(1);
    draw_set_color(c_white);
}

// --- 2. Desenho da Notificação de Ciclo ---
if (notificacao_ativa) {
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    // Fundo
    draw_set_color(c_black);
    draw_set_alpha(0.8);
    draw_rectangle(0, room_height/2 - 50, room_width, room_height/2 + 50, false);
    draw_set_alpha(1);

    // Texto
    draw_set_color(c_white);
    draw_text(room_width/2, room_height/2, notificacao_texto);

    // Reseta o alinhamento
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
