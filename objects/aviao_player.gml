#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Velocidades
hspd = 0;
vspd = 0;
max_speed = 5;
accel = 0.3;

// Altura e estado de voo
is_flying = false;
altitude = 0;
max_altitude = 200;

// Ângulo do avião
angle_flight = 0;

// Pontuação
score = 0;

// Posição inicial
x = room_width/2;
y = room_height/2;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// CONTROLE
if (keyboard_check(vk_left))  hspd -= accel;
if (keyboard_check(vk_right)) hspd += accel;
if (keyboard_check(vk_up))    vspd -= accel;
if (keyboard_check(vk_down))  vspd += accel;

// Limites de velocidade
if (hspd > max_speed) hspd = max_speed;
if (hspd < -max_speed) hspd = -max_speed;
if (vspd > max_speed) vspd = max_speed;
if (vspd < -max_speed) vspd = -max_speed;

// Decolagem
if (!is_flying && keyboard_check_pressed(vk_space)) {
    is_flying = true;
    altitude = 10;
    vspd = -2;
}

// Gravidade e altitude
if (is_flying) {
    altitude += vspd;
    if (altitude < 0) {
        altitude = 0;
        is_flying = false; // pousou
    }
}

// Movimento horizontal
x += hspd;
y += vspd;

// Rotação do avião
if (hspd != 0 || vspd != 0) {
    image_angle = point_direction(0,0,hspd,vspd);
}

// Colisão com obstáculos
with (EVA_EMBLEM_Colizao) {
    if (place_meeting(other.x, other.y, id)) {
        other.hspd = 0;
        other.vspd = 0;
        other.altitude = 0;
        other.is_flying = false;
        other.score -= 10; // penalidade
    }
}

// Pontuação por tempo voando
if (is_flying) {
    score += 1;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_color(c_white);
draw_text(10,10,"Score: " + string(score));
draw_text(10,30,"Altitude: " + string(altitude));
