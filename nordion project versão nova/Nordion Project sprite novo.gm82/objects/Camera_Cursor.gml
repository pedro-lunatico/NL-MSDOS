#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Garante view ligada e visível via código (opcional, mas útil)
view_enabled = true;
view_visible[0] = true;

// Tamanho da view e do port (resolução 800x600)
view_wview[0] = 800;
view_hview[0] = 600;
view_wport[0] = 800;
view_hport[0] = 600;

// Certifica que a view não está seguindo por propriedades de room
view_object[0] = noone;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Substitua obj_player pelo nome do seu objeto de player, se for diferente
if (instance_exists(MIKUOS_CURSOR)) {
    // calcula posição desejada (centralizada no player)
    cam_x = MIKUOS_CURSOR.x - view_wview[0] / 2;
    cam_y = MIKUOS_CURSOR.y - view_hview[0] / 2;

    // limites da room (tratando rooms menores que a view)
    lim_x = room_width  - view_wview[0];
    lim_y = room_height - view_hview[0];
    if (lim_x < 0) lim_x = 0;
    if (lim_y < 0) lim_y = 0;

    // clamp manual (sem usar clamp/lerp)
    if (cam_x < 0) cam_x = 0; else if (cam_x > lim_x) cam_x = lim_x;
    if (cam_y < 0) cam_y = 0; else if (cam_y > lim_y) cam_y = lim_y;

    // aplica na view 0
    view_xview[0] = cam_x;
    view_yview[0] = cam_y;
}
