#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Garante que o cavalo nasça em cima do player, se ele existir
if (instance_exists(player)) {
    x = player.x;
    y = player.y;
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// tick
globalvar moneytime, moneyplus, tick;
health = 100;
global.montado = false;
dist_cavalo = 0;
image_index = 0.06;
global.humanidade = 0;
global.quebra_de_confianca = false;
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///moving
// Velocidade do player
move_speed = 5;

// Estado de movimento
moving = false;

// Controle de animação
image_xscale = 1;
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
image_index = 0;

// Flip horizontal
prev_x = x;
face_deadzone = 0.5;

// Destino inicial (começa parado)
dest_x = x;
dest_y = y;
target_x = 0;
target_y = 0;
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
image_speed = 6;
    global.dancing = false;
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///animação
sprite_index = global.player_sprite;
image_speed = 6;
global.attacking = false;
#define Alarm_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
sprite_index = global.player_sprite;
image_speed = 6;
global.dancing = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Lógica de Montaria (Correção de Variável)

// 1. Inicializa a lista se ela não existir
if (!variable_global_exists("proibidas")) {
    global.proibidas = ds_list_create();
    ds_list_add(global.proibidas, monte_silesia);
    ds_list_add(global.proibidas, monte_silesia2);
    ds_list_add(global.proibidas, monte_silesia_RVL);
}

// 2. Tentar montar (Checagem segura)
if (instance_exists(Cavalo)) {
    // Só declaramos e calculamos a distância se o cavalo existir!
    var dist_cavalo;
    dist_cavalo = point_distance(x, y, Cavalo.x, Cavalo.y);

    // Agora o if está seguro dentro do bloco instance_exists
    if (dist_cavalo < 60 && mouse_check_button_pressed(mb_left)) {

         // Verifica se a sala permite
// Se estiver montado, sai do script e não processa nada!
if (visible == false or (variable_global_exists("montado") && global.montado == true)) {
    visible = false; // Garante invisibilidade
    exit;
             with(Cavalo) {
                 x = -1000;
                 y = -1000;
             }
         } else {
             show_debug_message("Não posso montar aqui!");
         }
    }
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// @description Script de Movimento e Animação Unificado

// ===========================
// 0 - COOLDOWNS E VARIÁVEIS LOCAIS
// ===========================
var _d, _dist, _dx, _dy;
if (attack_cooldown > 0) attack_cooldown -= 1;

key_x = 0;
key_y = 0;

// ===========================
// 1 - INPUT TECLADO
// ===========================
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
    _d = sqrt(key_x*key_x + key_y*key_y);
    key_x /= _d;
    key_y /= _d;

    nx = key_x * move_speed;
    ny = key_y * move_speed;

    // Movimento com Colisão
    if (!place_meeting(x + nx, y, colizao)) x += nx;
    if (!place_meeting(x, y + ny, colizao)) y += ny;

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
        _dx = dest_x - x;
        _dy = dest_y - y;
        _dist = sqrt(_dx*_dx + _dy*_dy);

        if (_dist > move_speed)
        {
            nx = (_dx / _dist) * move_speed;
            ny = (_dy / _dist) * move_speed;

            if (!place_meeting(x + nx, y, colizao)) x += nx;
            if (!place_meeting(x, y + ny, colizao)) y += ny;
        }
        else
        {
            x = dest_x;
            y = dest_y;
            moving = false;
            nx = 0;
            ny = 0;
        }
        prev_x = x;
    }
    else
    {
        nx = 0;
        ny = 0;
    }
}

// Impede sair da room
x = max(0, min(x, room_width  - sprite_width));
y = max(0, min(y, room_height - sprite_height));

// ===========================
// 4 - LÓGICA DE ANIMAÇÃO (SPRITES)
// ===========================

// Prioridade Máxima: Ataque e Dança
if (global.attacking || global.dancing)
{
    // A animação já foi definida nos gatilhos de clique/tecla (ver Seção 5)
}
// Movimento (Teclado ou Mouse)
else if (keyboard_moving || moving)
{
    image_speed = 0.2;

    // DIREÇÃO DO SPRITE
    if (ny < -0.1) {
        sprite_index = ply_walking_up;    // Subindo (ny negativo)
    } else if (ny > 0.1) {
        sprite_index = ply_walking_down;  // Descendo (ny positivo)
    } else {
        sprite_index = ply_walking_left;  // Apenas pros lados
    }

    // FLIP HORIZONTAL (nx)
    if (nx > 0) image_xscale = -1; // Direita (Inverte se original olha esquerda)
    if (nx < 0) image_xscale = 1;  // Esquerda
}
// Parado
else
{
    sprite_index = global.player_sprite;
    image_speed = 0.6;
}

// ===========================
// 5 - GATILHOS DE AÇÃO (Ataque/Dança)
// ===========================

// ATAQUE (MB Direito)
if (!global.attacking && !global.dancing && attack_cooldown <= 0 && mouse_check_button_pressed(mb_right)) {
    if (global.player_sprite == ply_standing) {
        sprite_index = ply_sword;
    } else {
        sprite_index = ply_alt_sword;
    }
    image_index = 0;
    image_speed = 0.5;
    global.attacking = true;
    moving = false; // Cancela movimento do mouse ao atacar
    attack_cooldown = ceil(sprite_get_number(sprite_index) / image_speed);
    alarm[0] = attack_cooldown;
}

// DANÇA (Tecla Q)
if (!global.attacking && !global.dancing && keyboard_check_pressed(ord("Q"))) {
    if (global.player_sprite == ply_standing) {
        sprite_index = ply_dance;
    } else {
        sprite_index = ply_dance_alt;
    }
    image_speed = 6;
    global.dancing = true;
    moving = false; // Cancela movimento do mouse ao dançar
    alarm[1] = room_speed * 6;
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
    file_text_write_string(f2, string(global.casado));
} else {
    file_text_write_string(f2, "0");
}

file_text_close(f2);

// ---- MENSAGEM OPCIONAL ----
if (variable_global_exists("mensagens")) {
    ds_list_add(global.mensagens, "jogo salvo com sucesso!");
    global.dialogo_ativo = true;
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Room Start - Sincronia Forçada
if (variable_global_exists("montado")) {
    if (global.montado == true) {

        // Se o cavalo de controle não existe, cria ele EXATAMENTE onde o player está
        if (!instance_exists(Player_Horse)) {
            var inst;
            inst = instance_create(x, y, Player_Horse);

            // Força o cavalo a herdar as coordenadas de teletransporte do player
            inst.x = x;
            inst.y = y;
        }

        // Esconde o player humano IMEDIATAMENTE
        visible = false;
        moving = false;

        // Se houver um cavalo estático de cenário, remove ele
        if (instance_exists(Cavalo)) {
            with(Cavalo) { instance_destroy(); }
        }
    }
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
