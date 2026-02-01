#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// tick
globalvar moneytime, moneyplus, tick;
health = 100;
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///moving
// Velocidade do player
move_speed = 4;

// Estado de movimento
moving = false;

// Controle de animação
image_xscale = 1;
image_speed = 0;
image_index = 0;

// Flip horizontal
prev_x = x;
face_deadzone = 0.5;

// Destino inicial (começa parado)
dest_x = x;
dest_y = y;

// Timer de colisão
collision_timer = 0;
collision_limit = 0.25; // 1/4 de segundo encostado

// Objeto de colisão
colisao = colizao; // troque pelo seu
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///moving
// Velocidade do player
move_speed = 4;

// Estado de movimento
moving = false;

// Controle de animação
image_xscale = 1;
image_speed = 0;
image_index = 0;

// Flip horizontal
prev_x = x;
face_deadzone = 0.5;

// Destino inicial (começa parado)
dest_x = x;
dest_y = y;

// Timer de colisão
collision_timer = 0;
collision_limit = 0.25; // 1/4 de segundo encostado

// Objeto de colisão
colisao = colizao; // troque pelo seu
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///roupa alternativa
// Mantém sprite base entre rooms
if (!variable_global_exists("player_sprite")) {
    global.player_sprite = ply_standing;
}

global.attacking = false;
global.dancing = false;

sprite_index = global.player_sprite;
image_speed = 0;
image_index = 0;

// Cooldown para evitar spam de ataque
attack_cooldown = 0;
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///sound sword
// Nenhum som tocando no começo
som_tocando = false;
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///teleport
// Primeiro teste: a variável existe?
if (variable_global_exists("next_x")) {

    // Segundo teste: só usa se o valor for válido
    if (global.next_x != -1) {
        x = global.next_x;
        y = global.next_y;
    }

    // Limpa mesmo assim para evitar reaplicar
    global.next_x = -1;
    global.next_y = -1;
}
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///espada original
sprite_index = ply_standing;
image_speed = 0;
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
/// tick++

global.tick = global.tick + 1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///moving
key_x = 0;
key_y = 0;

if (keyboard_check(vk_right) or keyboard_check(ord("D"))) key_x = 1;
if (keyboard_check(vk_left)  or keyboard_check(ord("A"))) key_x = -1;
if (keyboard_check(vk_down)  or keyboard_check(ord("S"))) key_y = 1;
if (keyboard_check(vk_up)    or keyboard_check(ord("W"))) key_y = -1;

keyboard_moving = (key_x != 0 or key_y != 0);

if (keyboard_moving)
{
    // Desativa movimento do mouse
    moving = false;

    // Normaliza diagonal
    d = sqrt(key_x*key_x + key_y*key_y);
    key_x /= d;
    key_y /= d;

    nx = key_x * move_speed;
    ny = key_y * move_speed;

    // Movimento X
    if (!place_meeting(x + nx, y, colizao)) x += nx;

    // Movimento Y
    if (!place_meeting(x, y + ny, colizao)) y += ny;

    // Animação
    image_speed = 0.2;

    // Flip lado
    if (nx > 0) image_xscale = -1;
    if (nx < 0) image_xscale = 1;

    prev_x = x;
}
else
{
    /// ===========================
    /// 2 - CLIQUE DEFINE DESTINO
    /// ===========================
    if (mouse_check_button_pressed(mb_left))
    {
        dest_x = mouse_x;
        dest_y = mouse_y;
        moving = true;
    }

    /// ===========================
    /// 3 - MOVIMENTO POR MOUSE
    /// ===========================
    if (moving)
    {
        dx = dest_x - x;
        dy = dest_y - y;
        dist = sqrt(dx*dx + dy*dy);

        if (dist > move_speed)
        {
            nx = (dx / dist) * move_speed;
            ny = (dy / dist) * move_speed;

            if (!place_meeting(x + nx, y, colizao)) x += nx;
            if (!place_meeting(x, y + ny, colizao)) y += ny;

            image_speed = 0.2;

            if (nx > 0) image_xscale = -1;
            if (nx < 0) image_xscale = 1;
        }
        else
        {
            x = dest_x;
            y = dest_y;
            moving = false;

            image_speed = 0;
            image_index = 0;
        }

        prev_x = x;
    }
    else
    {
        // Parado
        image_speed = 0;
        image_index = 0;
    }
}
// Impede sair da room
x = max(0, min(x, room_width  - sprite_width));
y = max(0, min(y, room_height - sprite_height));
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///animação
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

    // Bloqueia novo ataque até animação terminar
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

// ===== MANTER SPRITE BASE =====
if (!global.attacking && !global.dancing) {
    if (sprite_index != global.player_sprite) {
        sprite_index = global.player_sprite;
        image_speed = 0;
        image_index = 0;
    }
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///sound sword
// Se algum som estiver marcado como tocando, checa se ainda está ativo
if (som_tocando) {
    if (!sound_isplaying(som_atual)) {
        som_tocando = false; // liberado para tocar outro
    }
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///gameover
if (health <= 0)
{
sound_stop_all()
sound_play(gameover_theme)
show_message("vc:achava que era mais forte")
sound_stop_all()
game_restart();
}
#define Keyboard_77
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=224
invert=0
arg0=TP_JOLYNE_KUJO
arg1=20
*/
#define Mouse_50
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
dest_x = mouse_x;
dest_y = mouse_y;

if (!place_meeting(dest_x, dest_y, colizao)) {
    moving = true;
    if (image_speed == 0) image_speed = 0.2;
} else {
    moving = false;
    show_debug_message("Destino bloqueado!");
}
#define Mouse_51
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Só toca se não houver som em andamento
if (!som_tocando) {
    som_atual = choose(Sword_SFX, Sword2_SFX, Sword3_SFX);
    sound_play(som_atual);
    som_tocando = true;
}
#define Other_3
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///save
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
#define Trigger_Morri!
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=224
invert=0
arg0=GameOver
arg1=20
*/
#define Trigger_MoneyTime
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
_scr = "Você tem " + string(score + global.moneyplus) + " Diamantes! São " + string(global.moneyplus) + "mais do que a ultima vez!";

show_message(_scr);

score += global.moneyplus;

global.moneytime = false;
