#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// --- MOVIMENTO BÁSICO ---
hsp = 0;
vsp = 0;
move_speed = 8;
boost_speed = 14;
facing = 1;
solido = colizao; // Certifique-se que o objeto de parede tem esse nome

// --- SISTEMA DE DRIFT (POWER SLIDE) ---
drift_key = vk_space;
is_drifting = false;
drift_timer = 0;      // Acumula para o boost (como no vídeo)
boost_timer = 0;      // Tempo de duração do turbo
drift_power = 0.25;   // O quanto ele "escorrega" lateralmente

// --- ANIMAÇÃO E VISUAL ---
sprite_idle = ply_Horse_Idle;
sprite_run  = ply_Horse;
image_speed = 0.2;

// --- SISTEMA DE DIÁLOGO (BALÃO) ---
idle_timer = 0;
idle_limit = room_speed * 5;
show_idle_balloon = false;
msg_balao = "vc; vai vai anda";
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// ==========================================================
// STEP EVENT COMPLETO - PLAYER_HORSE (GM 8.1)
// ==========================================================

// --- 1. SINCRONIZAR HITBOX (O player humano obedece ao cavalo) ---
if (instance_exists(player)) {
    player.x = x;
    player.y = y;
    player.visible = false; // Mantém invisível enquanto montado
    player.moving = false;
}

// --- 2. LÓGICA DE DESMONTAR (CLIQUE DIREITO) ---
if (mouse_check_button_pressed(mb_right)) {
    // Verifica se a sala permite desmontar (não pode no Touge)
    if (ds_list_find_index(global.proibidas, room) == -1) {

        global.montado = false; // DESLIGA A FLAG DE MONTARIA

        if (instance_exists(player)) {
            player.visible = true; // FAZ O PLAYER SER VISTO NOVAMENTE
            player.x = x;
            player.y = y;
        }

        // Calcula posição para o Cavalo estático não sair da room
        var _spX;
        _spX = x + (48 * facing);
        if (_spX < 32) _spX = 32;
        if (_spX > room_width - 32) _spX = room_width - 32;

        // Gerencia o objeto Cavalo estático no cenário
        if (instance_exists(Cavalo)) {
            Cavalo.x = _spX;
            Cavalo.y = y;
        } else {
            instance_create(_spX, y, Cavalo);
        }

        instance_destroy(); // Destrói o cavalo de controle
        exit;
    }
}

// --- 3. INPUTS (TECLADO) ---
var _key_left, _key_right, _key_up, _key_down, _key_drift;
_key_left  = keyboard_check(vk_left)  or keyboard_check(ord("A"));
_key_right = keyboard_check(vk_right) or keyboard_check(ord("D"));
_key_up    = keyboard_check(vk_up)    or keyboard_check(ord("W"));
_key_down  = keyboard_check(vk_down)  or keyboard_check(ord("S"));
_key_drift = keyboard_check(vk_space);

// --- 4. FÍSICA DE DRIFT ARCADE ---
var _max_vel, _accel, _fric;

// Define velocidade máxima (Boost vs Normal)
if (boost_timer > 0) {
    _max_vel = boost_speed;
    boost_timer -= 1;
} else {
    _max_vel = move_speed;
}

// Lógica de deslize (Drift)
if (_key_drift && (abs(hsp) > 1 or abs(vsp) > 1)) {
    is_drifting = true;
    _accel = 0.3;
    _fric = 0.08;
    drift_timer += 1;
    if (drift_timer > 60) drift_timer = 60;
} else {
    // Ao soltar o drift, aplica o Boost proporcional
    if (is_drifting && drift_timer > 20) boost_timer = drift_timer * 2;
    is_drifting = false;
    drift_timer = 0;
    _accel = 0.8;
    _fric = 0.4;
}

// Aplicar Movimento
if (_key_left)  { hsp -= _accel; facing = -1; }
if (_key_right) { hsp += _accel; facing = 1;  }
if (_key_up)    { vsp -= _accel; }
if (_key_down)  { vsp += _accel; }

// Fricção Manual (GM 8.1)
if (!_key_left && !_key_right) {
    if (abs(hsp) < _fric) hsp = 0; else hsp -= sign(hsp) * _fric;
}
if (!_key_up && !_key_down) {
    if (abs(vsp) < _fric) vsp = 0; else vsp -= sign(vsp) * _fric;
}

hsp = clamp(hsp, -_max_vel, _max_vel);
vsp = clamp(vsp, -_max_vel, _max_vel);

// --- 5. COLISÃO TOUGE (QUICAR + DESLIZAR) ---
if (place_meeting(x + hsp, y, colizao)) {
    if (is_drifting) drift_timer = 0;
    if (abs(hsp) > 3) hsp = -hsp * 0.4;
    else {
        while (!place_meeting(x + sign(hsp), y, colizao)) { x += sign(hsp); }
        hsp = 0;
    }
}
x += hsp;

if (place_meeting(x, y + vsp, colizao)) {
    if (is_drifting) drift_timer = 0;
    if (abs(vsp) > 3) vsp = -vsp * 0.4;
    else {
        while (!place_meeting(x, y + sign(vsp), colizao)) { y += sign(vsp); }
        vsp = 0;
    }
}
y += vsp;

// --- 6. EFEITOS DE PARTÍCULAS ---
if (is_drifting && (global.tick mod 4 == 0)) {
    effect_create_below(ef_smoke, x, y + 16, 0, c_white);
}

// --- 7. LIMITES DA ROOM E ANIMAÇÃO ---
x = clamp(x, 16, room_width - 16);
y = clamp(y, 16, room_height - 16);

image_xscale = facing;

if (abs(hsp) > 0.5 or abs(vsp) > 0.5) {
    sprite_index = sprite_run;
    if (boost_timer > 0) image_speed = 0.6; else image_speed = 0.3;
} else {
    sprite_index = sprite_idle;
    image_speed = 0.1;
}

// Inclinação Visual (Suavização Manual)
var _target_angle;
if (is_drifting) _target_angle = facing * -20; else _target_angle = 0;
image_angle += (_target_angle - image_angle) * 0.1;
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Ao mudar de sala, garante que o cavalo alinhe com o player hitbox
if (instance_exists(player)) {
    x = player.x;
    y = player.y;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Desenha o Cavalo
draw_self();

// HUD de Carga do Drift (Barra amarela igual a jogos arcade)
if (is_drifting && drift_timer > 5) {
    draw_set_color(c_black);
    draw_rectangle(x-21, y-46, x+21, y-39, false); // Borda
    draw_set_color(c_yellow);
    draw_rectangle(x-20, y-45, x-20 + (drift_timer/60)*40, y-40, false); // Barra
}

// Efeito Visual de Boost (Fumaça/Rastro simples)
if (boost_timer > 0) {
    draw_set_blend_mode(bm_add);
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale*1.1, 1.1, image_angle, c_orange, 0.3);
    draw_set_blend_mode(bm_normal);
}

// BALÃO DE AVISO (Ajustado para as Views do GM8.1)
if (show_idle_balloon) {
    var bx, by, bw, bh;
    draw_set_font(-1); // Usa fonte padrão

    // Posição na parte inferior da tela
    bx = view_xview[0] + view_wview[0]/2;
    by = view_yview[0] + view_hview[0] - 60;

    bw = string_width(msg_balao) + 20;
    bh = 30;

    draw_set_color(c_black);
    draw_roundrect(bx-bw/2-2, by-bh/2-2, bx+bw/2+2, by+bh/2+2, false);
    draw_set_color(c_white);
    draw_roundrect(bx-bw/2, by-bh/2, bx+bw/2, by+bh/2, false);

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_black);
    draw_text(bx, by, msg_balao);

    // Reset para não afetar outros draws
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
