#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Surface para desenhar o chão
surface_id = -1;

// Linha do horizonte e escala
horizon_y = 150;
scale_base = 0.5;
scale_max = 2;

// Inicializa posição e ângulo do jogador
px = room_width/2;
py = room_height/2;
player_angle = 0;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Limpa surface
if (surface_exists(surface_id)) surface_free(surface_id);
surface_id = surface_create(room_width, room_height);
surface_set_target(surface_id);
draw_clear(c_black);

// Pega posição e ângulo do player
if (instance_exists(aviao_player)) {
    px = aviao_player.x;
    py = aviao_player.y;
    player_angle = aviao_player.image_angle;
} else {
    px = room_width/2;
    py = room_height/2;
    player_angle = 0;
}

// Desenha o chão linha a linha
y_line = horizon_y;
while (y_line < room_height) {

    // distância do horizonte (0 = longe, 1 = perto)
    distance = (y_line - horizon_y) / (room_height - horizon_y);

    // escala da linha
    scale = scale_base + distance * (scale_max - scale_base);

    // deslocamento lateral conforme ângulo
    offset_x = px + lengthdir_x(distance * 200, player_angle);

    // largura da linha escalada
    line_width = sprite_width * scale;

    // recorta uma faixa de 1px do sprite original
    draw_sprite_part(
        spr_ground,     // sprite do chão
        0,              // subimage
        0,              // origem X no sprite
        0,              // origem Y no sprite
        sprite_width,   // largura
        1,              // altura (1 linha)
        -offset_x,      // posição X na tela
        y_line          // posição Y na tela
    );

    // agora estica essa linha manualmente
    draw_sprite_stretched(
        spr_ground,
        0,
        -offset_x,
        y_line,
        line_width,
        1
    );

    y_line += 1;
}

// Finaliza surface e desenha chão
surface_reset_target();
draw_surface(surface_id, 0, 0);
