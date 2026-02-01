#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Sprite e estado inicial
sprite_index = spr_armario;  // nome do sprite no seu projeto
image_speed = 0;
image_index = 0;

animating = false;       // tocando animação?
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Inicializa variáveis do objeto
animating = false;      // se houver animação
gx = 0;                 // posição na grid X
gy = 0;                 // posição na grid Y
kind = -1;              // tipo do móvel (0=Sofa,1=Armario,2=TV)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// LEFT CLICK sobre este armário → alterna personagem e inicia animação
if (mouse_check_button_pressed(mb_left)) {
    if (position_meeting(mouse_x, mouse_y, id)) {

        // Troca de personagem
        if (global.player_sprite == ply_standing) {
            global.player_sprite = ply_alt;
        } else {
            global.player_sprite = ply_standing;
        }

        // Inicia a animação (só se não estiver tocando)
        if (!animating) {
            image_index = 0;
            image_speed = 0.3; // ajuste a velocidade como preferir
            animating  = true;
        }
    }
}

// Se está animando e chegou ao último frame → para a animação
if (animating && image_index >= sprite_get_number(sprite_index) - 1) {
    image_speed = 0;
    image_index = 0;     // volta pro primeiro frame (se preferir, remova esta linha para parar no último)
    animating  = false;
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Clique direito para remover móvel
if (mouse_check_button_pressed(mb_right)) {
    if (position_meeting(mouse_x, mouse_y, id)) {

        // remove da lista global
        i = 0;
        while (i < ds_list_size(global.furniture_list)) {
            it = ds_list_find_value(global.furniture_list, i);
            gx = ds_list_find_value(it, 1);
            gy = ds_list_find_value(it, 2);

            if (gx * global.CELL == x && gy * global.CELL == y) {
                ds_list_delete(global.furniture_list, i);
                ds_list_destroy(it);
                break;
            }
            i += 1;
        }

        // destrói objeto
        instance_destroy();
    }
}
