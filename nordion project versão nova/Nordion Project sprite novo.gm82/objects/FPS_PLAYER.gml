#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//all the regular variables.

{
  //camera stuff
  global.camx = x;
  global.camy = y;
  global.camsin = sin(direction*pi/180);
  global.camcos = cos(direction*pi/180);

  global.paint = 0;
  //player stuff
  friction = 0.2;
  pitch = 0;
  health = 100;
  falling = 0;
  depth = 100;
  deathcam = 0;
  spd = 0;
  global.wave = 0;

  //3D stuff
  d3d_start();
  d3d_set_hidden(true);
  d3d_set_lighting(false);
  d3d_set_culling(false);
  texture_set_interpolation(false);
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if place_meeting(x,y,FPS_FLOOR_TETO) {
z = 8;
exit;
} else if place_meeting(x,y,FPS_FLOOR_TETO) {
z = 6;
exit;
} else if place_meeting(x,y,FPS_Floor) {
z = 4;
exit;
} else if place_meeting(x,y,FPS_Floor) {
z = 2;
exit;
} else {
z = 0;
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//bullets
global.bullets = 60;
global.shells = 0;
global.rockets = 0;
global.cells = 0;
global.switch_note = 0;     //whether we're touching a switch or not

//which guns we have!
fist = 1;
pistol = 1;
chainsaw = 0;
minigun = 0;
shotgun = 0;
rifle = 0;
plasma_rifle = 0;
rocket_launcher = 0;
bfg = 0;
//room for one last gun here
// Evita erro de variável indefinida
i = noone;

// Variáveis de controle inicial
// Variáveis iniciais do player
falling = 0;
deathcam = 0;
spd = 0;
z = 0;
pitch = 0;
global.wave = 0;

// Direção inicial e velocidade base
direction = 0;
base_speed = 4;

// Evita erro com variável i
i = noone;

// Se quiser, podemos já definir um objeto alvo — exemplo: porta
if (instance_exists(obj_wall1_hor)) {
    i = instance_nearest(x, y, obj_wall1_hor);
}
// --- Variáveis iniciais do FPS Player ---
z = 0;              // altura do jogador
zspeed = 0;         // velocidade vertical
direction = 0;      // direção em graus
terceira_pessoa = 0; // começa em primeira pessoa
colisao = colizao; // nome do objeto de colisão

// variáveis de controle de movimento
global.wave = 0;
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// --- Garante que variáveis globais existem ---
if (!variable_global_exists("room_trocando")) {
    global.room_trocando = false;
    global.player_x = 0;
    global.player_y = 0;
    global.player_z = 0;
    global.player_dir = 0;
}

// --- Ativa modo 3D ao entrar na room ---
d3d_start();
d3d_set_culling(false);
d3d_set_hidden(true);
d3d_set_lighting(false);

// --- Se veio de outra room, restaura posição e direção ---
if (global.room_trocando) {
    x = global.player_x;
    y = global.player_y;
    z = global.player_z;
    direction = global.player_dir;
    global.room_trocando = false;
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// --------------------------------------------------
// Controle de câmera (mouselook)
// --------------------------------------------------
var mx, my;
mx = display_mouse_get_x();
my = display_mouse_get_y();

direction -= (mx - display_get_width() / 2) / 5;
pitch += (my - display_get_height() / 2) / 5;

if (pitch > 100) pitch = 100;
if (pitch < -100) pitch = -100;

display_mouse_set(display_get_width() / 2, display_get_height() / 2);

// --------------------------------------------------
// Controle de movimento
// --------------------------------------------------
var forward, strafe, move_speed, dx, dy;
forward = 0;
strafe = 0;

if (keyboard_check(ord('W'))) forward += 1;
if (keyboard_check(ord('S'))) forward -= 1;
if (keyboard_check(ord('A'))) strafe -= 1;
if (keyboard_check(ord('D'))) strafe += 1;

move_speed = 4;
if (keyboard_check(vk_shift)) move_speed = 6;

// Calcula o movimento
dx = 0;
dy = 0;

if (forward != 0) {
    dx += lengthdir_x(move_speed * forward, direction);
    dy += lengthdir_y(move_speed * forward, direction);
}
if (strafe != 0) {
    dx += lengthdir_x(move_speed * strafe, direction + 90);
    dy += lengthdir_y(move_speed * strafe, direction + 90);
}

// --------------------------------------------------
// Colisão simples com obj_colisao
// --------------------------------------------------
var new_x, new_y;
new_x = x;
new_y = y;

passo = 2; // passos pequenos para não atravessar
dist = point_distance(0, 0, dx, dy);
steps = max(1, ceil(dist / passo));

step_x = dx / steps;
step_y = dy / steps;

for (s = 0; s < steps; s += 1) {
    if (!place_meeting(new_x + step_x, new_y, colisao)) {
        new_x += step_x;
    }
    if (!place_meeting(new_x, new_y + step_y, colisao)) {
        new_y += step_y;
    }
}

// Aplica posição final
x = new_x;
y = new_y;

// --------------------------------------------------
// Simulação de gravidade simples
// --------------------------------------------------
if (place_meeting(x, y, colisao)) {
    zspeed = 0;
} else {
    zspeed -= 0.5;
}
z += zspeed;
if (z < 0) {
    z = 0;
    zspeed = 0;
}

// --------------------------------------------------
// Projeção da câmera 3D
// --------------------------------------------------
d3d_set_projection(
    x, y, z + 10 + sin(global.wave / 4),
    x + cos(direction * pi / 180),
    y - sin(direction * pi / 180),
    z + 10 + sin(global.wave / 4),
    0, 0, 1
);
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//camera stuff
{
  global.camx = x;
  global.camy = y;
  global.camsin = sin(direction*pi/180);
  global.camcos = cos(direction*pi/180);
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
{
  // set the projection
  d3d_set_projection(x,y,z+10+sin(global.wave/4),x+cos(direction*pi/180),y-sin(direction*pi/180),z+10+sin(global.wave/4),0,0,1);
  draw_set_alpha(1);
  draw_set_color(c_white);
}
