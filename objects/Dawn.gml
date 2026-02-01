#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// posição real
px = x;
py = y;

// velocidade
move_speed = 5;

// escala base maior
base_scale = 1; // tamanho base do sprite
scale = base_scale;

// flag de movimento
moving = false;

// sprite de animação
sprite_index = Dawn_spr; // seu sprite de andar
image_speed = 0; // inicia parado
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// resetando movimento
moving = false;

// cálculo do movimento
new_px = px;
new_py = py;

// aplica novo movimento
px = new_px;
py = new_py;

// atualiza a posição do objeto para desenhar
x = px;
y = py;

// ajusta escala com base na profundidade (pseudo-3D)
// agora aumenta mais dramaticamente quando perto da câmera
scale = base_scale * (1 + (py / room_height) * 1.5);
#define Mouse_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=321
invert=0
arg0=Dawn:me deixe em paz estou......... Pesquisando!
*/
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index, image_index, x, y, scale, scale, 0, c_white, 1);
