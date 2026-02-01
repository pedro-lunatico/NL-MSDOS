#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// 1. Inicializa variáveis globais IMEDIATAMENTE para evitar erro no Floor
global.camx = x;
global.camy = y;
global.camsin = 0;
global.camcos = 0;
global.wave = 0;

// 2. Variáveis de Voo (Estilo Pilotwings)
vspd = 0;          // Velocidade de deslocamento (thrust)
max_vspd = 8;      // Velocidade máxima
accel = 0.1;       // O quão rápido ganha velocidade
pitch = 0;         // Inclinação para cima/baixo
z = 100;           // Altitude inicial (começa voando)
zspeed = 0;        // Velocidade vertical
roll = 0;          // Inclinação visual das asas

// 3. Configurações 3D
d3d_start();
d3d_set_hidden(true);
d3d_set_lighting(false);
texture_set_interpolation(false);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// --- Controles de Pilotagem ---
// Aceleração (W / S)
if (keyboard_check(ord('W'))) vspd += accel;
if (keyboard_check(ord('S'))) vspd -= accel;
vspd = clamp(vspd, 0, max_vspd); // Impede de ir de ré

// Direção e Roll (A / D)
if (keyboard_check(ord('A'))) {
    direction += 2;
    roll = lerp(roll, 30, 0.1); // Inclina a asa para a esquerda
} else if (keyboard_check(ord('D'))) {
    direction -= 2;
    roll = lerp(roll, -30, 0.1); // Inclina a asa para a direita
} else {
    roll = lerp(roll, 0, 0.1); // Endireita as asas
}

// Pitch - Subir e Descer (Seta Cima / Baixo)
// Em simuladores, "Cima" desce o bico e "Baixo" sobe.
if (keyboard_check(vk_up))    pitch -= 2;
if (keyboard_check(vk_down))  pitch += 2;
pitch = clamp(pitch, -60, 60);

// --- Física de Movimento ---
// Move o player na direção horizontal
x += lengthdir_x(vspd, direction);
y += lengthdir_y(vspd, direction);

// A altitude (z) muda baseada no pitch e na velocidade
// Se estiver rápido e apontando para cima, sobe mais.
zspeed = -sin(degtorad(pitch)) * vspd;
z += zspeed;

// Gravidade mínima (se parar de acelerar, o avião cai)
if (vspd < 2) z -= 0.5;

// Chão simples
if (z < 0) { z = 0; vspd *= 0.9; }

// --- Atualiza variáveis para o cenário (Corrige o Erro) ---
global.camx = x;
global.camy = y;
global.camsin = sin(direction * pi / 180);
global.camcos = cos(direction * pi / 180);
global.wave += 0.2;
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Suavização da posição da câmera para os objetos de cenário
// Isso faz com que o global.camx "siga" o avião com um leve atraso visual
global.camx += (x - global.camx) * 0.5;
global.camy += (y - global.camy) * 0.5;

global.camsin = sin(direction * pi / 180);
global.camcos = cos(direction * pi / 180);
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// 1. Define a posição da câmera atrás do avião
dist = 60; // Distância atrás
alt = 20;  // Altura da câmera
cx = x - lengthdir_x(dist, direction);
cy = y - lengthdir_y(dist, direction);
cz = z + alt;

// 2. Define para onde a câmera olha (um pouco à frente do avião)
tx = x + lengthdir_x(100, direction);
ty = y + lengthdir_y(100, direction);
tz = z + (sin(degtorad(-pitch)) * 100);

// 3. Ativa a projeção
d3d_set_projection(cx, cy, cz, tx, ty, tz, 0, 0, 1);

// 4. Desenha o "Avião" (Placeholder)
draw_set_color(c_white);
// Corpo do avião
d3d_draw_block(x-4, y-4, z-2, x+4, y+4, z+2, -1, 1, 1);
// Asas (que inclinam com o Roll)
d3d_transform_set_identity();
d3d_transform_add_rotation_z(direction);
d3d_transform_add_rotation_x(roll); // Inclinação lateral
d3d_transform_add_translation(x, y, z);
d3d_draw_block(-15, -2, -0.5, 15, 2, 0.5, -1, 1, 1);
d3d_transform_set_identity();
