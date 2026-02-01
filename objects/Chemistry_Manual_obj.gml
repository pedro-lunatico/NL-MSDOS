#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
mostrar_sprite = false;
sprite_exibido = chemistry_manual_ui; // coloque o sprite da interface aqui

x_x = 0;
y_x = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (mostrar_sprite) {
    if (mouse_check_button_pressed(mb_left)) {
        if (mouse_x > x_x - 8 && mouse_x < x_x + 8 &&
            mouse_y > y_x - 8 && mouse_y < y_x + 8) {
            mostrar_sprite = false;
        }
    }
}
#define Mouse_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
mostrar_sprite = true;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// desenha o sprite normal do objeto no mundo
draw_self();

// desenha o GUI se ativado
if (mostrar_sprite) {
    // posição central independente da câmera
    xx = view_xview[0] + view_wview[0] / 2;
    yy = view_yview[0] + view_hview[0] / 2;

    draw_sprite(sprite_exibido, 0, xx, yy);

    w = sprite_get_width(sprite_exibido);
    h = sprite_get_height(sprite_exibido);

    // posição do X
    x_x = xx + w/2 - 16;
    y_x = yy - h/2 + 16;

    draw_set_color(c_red);
    draw_line(x_x - 8, y_x - 8, x_x + 8, y_x + 8);
    draw_line(x_x + 8, y_x - 8, x_x - 8, y_x + 8);
}
