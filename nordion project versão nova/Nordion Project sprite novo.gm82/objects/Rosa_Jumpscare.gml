#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// velocidade
move_speed = 3;

// já deu bronca?
falou = false;

// escala pseudo-3D
base_scale = 1;
scale = base_scale;

// animação parada (frame 0)
image_speed = 0;
image_index = 0;

// alvo do player
alvo_id = -1;

// distância
distancia = 0;

// flag: começa a seguir após alarm
seguir = false;

// define tempo para começar a seguir (2 segundos)
alarm[0] = 120;

// controla se a mensagem já foi mostrada
mensagem_mostrada = false;

// --- cria grid de colisão para pathfinding ---
grid = mp_grid_create(0, 0, room_width div 32, room_height div 32, 32, 32);
mp_grid_add_instances(grid, colizao, false); // marca 'colizao' como bloqueio
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
seguir = true;
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=211
invert=0
arg0=cave_sound
arg1=0
*/
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (seguir) {

    // define alvo se existe player
    if (instance_exists(player_RE2)) {
        alvo_id = instance_nearest(x, y, player_RE2);
    } else {
        alvo_id = -1;
    }

    // só segue se alvo válido
    if (alvo_id != -1 && instance_exists(alvo_id)) {

        // distância para o player
        distancia = point_distance(x, y, alvo_id.x, alvo_id.y);

        if (!falou) {

            if (distancia > 40) {
                // segue usando mp_potential_step evitando 'colizao'
                mp_potential_step(alvo_id.x, alvo_id.y, move_speed, false);
                image_speed = 0.2; // anima andando
            } else {
                // perto do player: para e manda mensagem
                image_speed = 0;
                image_index = 0;

                if (!mensagem_mostrada) {
                    show_message("DRa Rosa Mei; charlotte sai daqui!!!!! essa é uma área restrita");
                    mensagem_mostrada = true;
                }

                falou = true;
            }

        } else {
            // já falou: fica parado
            image_speed = 0;
            image_index = 0;
        }

    } else {
        // sem alvo válido: parado
        image_speed = 0;
        image_index = 0;
    }
}

// aplica pseudo-3D
scale = base_scale * (1 + (y / room_height) * 1.5);
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index, image_index, x, y, scale, scale, 0, c_white, 1);
