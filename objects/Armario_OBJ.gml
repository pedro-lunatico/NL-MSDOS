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
price = 400; // Cada móvel com seu valor
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
// Clique direito para remover móvel e ganhar reembolso
if (mouse_check_button_pressed(mb_right)) {
    if (position_meeting(mouse_x, mouse_y, id)) {

        // Devolve o dinheiro (Reembolso total)
        global.money += price;

        // Se você ainda usa a global.furniture_list para salvar:
        if (variable_global_exists("furniture_list")) {
            var i, it, gx, gy;
            for (i = 0; i < ds_list_size(global.furniture_list); i += 1) {
                it = ds_list_find_value(global.furniture_list, i);
                gx = ds_list_find_value(it, 1);
                gy = ds_list_find_value(it, 2);

                if (gx * global.CELL == x && gy * global.CELL == y) {
                    ds_list_delete(global.furniture_list, i);
                    ds_list_destroy(it);
                    break;
                }
            }
        }

        // Destrói a instância
        instance_destroy();
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_self();
