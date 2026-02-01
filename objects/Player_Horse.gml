#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// --- MOVIMENTO E VELOCIDADE ---
hsp = 0;
vsp = 0;
move_speed = 10;      // <--- O ERRO FOI AQUI, AGORA ESTÁ DEFINIDA
boost_speed = 18;
facing = 1;
solido = colizao;    // Nome do objeto de parede

// --- DRIFT / BOOST ---
drift_key = vk_space;
is_drifting = false;
drift_meter = 0;
drift_max = 85;
boost_timer = 0;

// --- ANIMAÇÃO ---
sprite_idle = ply_Horse_Idle;
sprite_run  = ply_Horse;
image_speed = 0.2;

// --- SISTEMA DE DIÁLOGO / BALÃO AERO ---
idle_timer = 0;
idle_limit = room_speed * 5;
show_idle_balloon = false;
caracteres = 0;
contador = 0;
velocidade = 2; // Velocidade do texto
texto_balao = "";

cor_vidro = make_color_rgb(150, 220, 255);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// 1. INPUTS
var _key_left, _key_right, _key_up, _key_down;
_key_left  = keyboard_check(vk_left);
_key_right = keyboard_check(vk_right);
_key_up    = keyboard_check(vk_up);
_key_down  = keyboard_check(vk_down);

// 2. CHECA INATIVIDADE (Para o Balão)
if (keyboard_check(vk_anykey)) {
    idle_timer = 0;
    show_idle_balloon = false;
} else {
    idle_timer += 1;
    if (idle_timer >= idle_limit) {
        show_idle_balloon = true;
    }
}

// 3. VELOCIDADE E ACELERAÇÃO
// Se estiver no boost, a velocidade máxima aumenta
var _max_vel;
if (boost_timer > 0) {
    _max_vel = boost_speed;
    boost_timer -= 1;
} else {
    _max_vel = move_speed;
}

// Cálculo de movimentação suave (evita trancos em pistas estreitas)
if (_key_left)  { hsp -= 0.5; facing = -1; }
if (_key_right) { hsp += 0.5; facing = 1;  }
if (!_key_left && !_key_right) { hsp -= sign(hsp) * 0.4; if (abs(hsp) < 0.5) hsp = 0; }

if (_key_up)    { vsp -= 0.5; }
if (_key_down)  { vsp += 0.5; }
if (!_key_up && !_key_down) { vsp -= sign(vsp) * 0.4; if (abs(vsp) < 0.5) vsp = 0; }

// Limita a velocidade máxima
if (abs(hsp) > _max_vel) hsp = sign(hsp) * _max_vel;
if (abs(vsp) > _max_vel) vsp = sign(vsp) * _max_vel;

// 4. COLISÃO SLIDE (O segredo para não enroscar)
// Tenta mover no X
if (place_meeting(x + hsp, y, solido)) {
    while (!place_meeting(x + sign(hsp), y, solido)) { x += sign(hsp); }
    hsp = 0;
}
x += hsp;

// Tenta mover no Y
if (place_meeting(x, y + vsp, solido)) {
    while (!place_meeting(x, y + sign(vsp), solido)) { y += sign(vsp); }
    vsp = 0;
}
y += vsp;

// 5. LÓGICA DE DRIFT
if (keyboard_check(drift_key) && (hsp != 0 || vsp != 0)) {
    is_drifting = true;
    drift_meter += 1;
    if (drift_meter > drift_max) drift_meter = drift_max;
} else {
    if (is_drifting && drift_meter > 20) {
        boost_timer = drift_meter; // Ativa o boost proporcional ao drift
    }
    is_drifting = false;
    drift_meter = 0;
}

// 6. ANIMAÇÃO
if (hsp != 0 || vsp != 0) {
    sprite_index = sprite_run;
    if (boost_timer > 0) image_speed = 0.5; else image_speed = 0.3;
} else {
    sprite_index = sprite_idle;
    image_speed = 0.1;
}

image_xscale = facing;

// Inclinação no Drift
if (is_drifting) {
    image_angle = facing * -10;
} else {
    image_angle = 0;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Desenha o cavalo (Lorca/Fir)
draw_self();

// HUD de Drift (Apenas se estiver carregando)
if (drift_meter > 0) {
    draw_set_color(c_yellow);
    draw_rectangle(x - 20, y - 45, x - 20 + (drift_meter/drift_max)*40, y - 40, false);
    draw_set_color(c_black);
    draw_rectangle(x - 20, y - 45, x + 20, y - 40, true);
}

// ---------------------------
// BALÃO DE AVISO (Ajustado para GM8.1)
if (show_idle_balloon) {
    var bx, by, bw, bh, msg;
    msg = "vc; vai vai anda";

    // Posição baseada na View atual
    bx = view_xview[0] + view_wview[0]/2;
    by = view_yview[0] + view_hview[0] - 80;

    bw = string_width(msg) + 20;
    bh = 30;

    // Sombra/Borda do balão
    draw_set_color(c_black);
    draw_roundrect(bx - bw/2 - 2, by - bh/2 - 2, bx + bw/2 + 2, by + bh/2 + 2, false);

    // Fundo do balão
    draw_set_color(c_white);
    draw_roundrect(bx - bw/2, by - bh/2, bx + bw/2, by + bh/2, false);

    // Texto
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_black);
    draw_text(bx, by, msg);

    // Reset dos alinhamentos para não quebrar outros textos do jogo
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
