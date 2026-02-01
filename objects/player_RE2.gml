#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// --- CREATE EVENT ---
/// posição real do player
px = x;
py = y;

/// velocidade
move_speed = 5;

/// escala base
base_scale = 1;
scale = base_scale;

/// flag de movimento
moving = false;

/// sistema de roupa alternativa (mantém ao trocar de room)
if (!variable_global_exists("player_sprite")) {
    global.player_sprite = ply_standing;
}

global.attacking = false;
global.dancing = false;

/// aplica sprite salvo
sprite_index = global.player_sprite;
image_speed = 0;
image_index = 0;

/// cooldown ataque
attack_cooldown = 0;
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///animação
sprite_index = global.player_sprite;
image_index = 0;
image_speed = 0;
global.attacking = false;
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///espada original
sprite_index = ply_standing;
image_speed = 0;
#define Alarm_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
sprite_index = global.player_sprite;
image_index = 0;
image_speed = 0;
global.dancing = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// ===============================
/// STEP EVENT COMPLETO
/// MOVIMENTO + PSEUDO3D + ANIMAÇÕES
/// ===============================

// --------------------------------------
// RESET DE MOVIMENTO
// --------------------------------------
moving = false;

new_px = px;
new_py = py;


// --------------------------------------
// MOVIMENTO + COLISÃO
// --------------------------------------
if (!global.attacking && !global.dancing) {

    // cima
    if (keyboard_check(vk_up) || keyboard_check(ord("W"))) {
        if (!place_meeting(px, py - move_speed, colizao)) {
            new_py -= move_speed;
            moving = true;
        }
    }

    // baixo
    if (keyboard_check(vk_down) || keyboard_check(ord("S"))) {
        if (!place_meeting(px, py + move_speed, colizao)) {
            new_py += move_speed;
            moving = true;
        }
    }

    // esquerda
    if (keyboard_check(vk_left) || keyboard_check(ord("A"))) {
        if (!place_meeting(px - move_speed, py, colizao)) {
            new_px -= move_speed;
            moving = true;
        }
    }

    // direita
    if (keyboard_check(vk_right) || keyboard_check(ord("D"))) {
        if (!place_meeting(px + move_speed, py, colizao)) {
            new_px += move_speed;
            moving = true;
        }
    }

}

// aplica movimento final
px = new_px;
py = new_py;

// força o Game Maker a continuar atualizando o player mesmo offscreen
x = px;
y = py;

// evita bug de "travamento de colisão" quando muito longe da câmera
if (abs(x - view_xview[0]) > room_width * 2) x = px;
if (abs(y - view_yview[0]) > room_height * 2) y = py;

// --------------------------------------
// PSEUDO 3D - ESCALA POR PROFUNDIDADE
// --------------------------------------
scale = base_scale * (1 + (py / room_height) * 1.5);
image_xscale = scale;
image_yscale = scale;


// --------------------------------------
// ANIMAÇÃO DE ANDAR
// --------------------------------------
if (!global.attacking && !global.dancing) {
    if (moving) {
        image_speed = 0.2;
    } else {
        image_speed = 0;
        image_index = 0;
    }
}


// ======================================
// ANIMAÇÃO COMPLETA: ATAQUE / DANÇA
// ======================================

// ===== decrementa cooldown de ataque =====
if (attack_cooldown > 0) attack_cooldown -= 1;


// ===== ATAQUE (Right Mouse) =====
if (!global.attacking && !global.dancing && attack_cooldown <= 0 && mouse_check_button_pressed(mb_right)) {

    if (global.player_sprite == ply_standing) {
        sprite_index = ply_sword;     // espada normal
    } else {
        sprite_index = ply_alt_sword; // espada alternativa
    }

    image_index = 0;
    image_speed = 0.5;

    alarm[0] = ceil(sprite_get_number(sprite_index) / image_speed);
    global.attacking = true;

    attack_cooldown = ceil(sprite_get_number(sprite_index) / image_speed);
}


// ===== DANÇA (Tecla Q) =====
if (!global.attacking && !global.dancing && keyboard_check_pressed(ord("Q"))) {

    if (global.player_sprite == ply_standing) {
        sprite_index = ply_dance;     // dança normal
    } else {
        sprite_index = ply_dance_alt; // dança alternativa
    }

    image_index = 0;
    image_speed = 0.5;

    alarm[1] = room_speed * 2; // dura 2 segundos
    global.dancing = true;
}


// ======================================
// MANTER SPRITE BASE QUANDO NÃO ANIMA
// ======================================
if (!global.attacking && !global.dancing) {
    sprite_index = global.player_sprite;
}
#define Other_3
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// ================================
// SISTEMA DE SAVE - GM 8.1
// ================================

// Pasta onde os saves ficam
global.save_pasta = "C:\\NordionSave";

// cria a pasta se não existir
if (!directory_exists(global.save_pasta)) {
    directory_create(global.save_pasta);
}

// ----- SALVAR ROOM ATUAL -----
save_file = global.save_pasta + "\\NL_MSDOSsave.dat";
f = file_text_open_write(save_file);

// salva o NOME da room ao invés do índice (método seguro)
file_text_write_string(f, room_get_name(room));
file_text_close(f);

// ----- SALVAR ESTADO DO CASAMENTO -----
save_file2 = global.save_pasta + "\\NLMSDOSDEWMERRIED.dat";
f2 = file_text_open_write(save_file2);

// escreve 1 ou 0
if (instance_exists(Relationship_control)) {
    file_text_write_string(f2, string(Relationship_control.casado));
} else {
    file_text_write_string(f2, "0");
}

file_text_close(f2);

// ---- MENSAGEM OPCIONAL ----
if (variable_global_exists("mensagens")) {
    ds_list_add(global.mensagens, "jogo salvo com sucesso!");
    global.dialogo_ativo = true;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index, image_index, x, y, scale, scale, 0, c_white, 1);
