#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
vel_player = 0;
show_vel = false;
vel_timer = 0;
vel_display_time = 60; // 1 segundo
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Verifica se o player está sobre o objeto
ply = instance_place(x, y, Player_Horse);
if (ply != noone) {
    // Calcula velocidade real do player
    vel_player = sqrt(ply.hsp*ply.hsp + ply.vsp*ply.vsp);
    show_vel = true;
}

// Atualiza timer para sumir o texto
if (show_vel) {
    vel_timer -= 1;
    if (vel_timer <= 0) show_vel = false;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (show_vel) {
    txt = "Mach " + string(floor(vel_player));
    draw_set_color(c_white);
    draw_text(x, y - sprite_height/2 - 10, txt);
}
