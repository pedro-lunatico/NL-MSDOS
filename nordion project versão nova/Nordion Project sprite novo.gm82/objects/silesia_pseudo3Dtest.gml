#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// --- CONFIGURAÇÕES DO MOTOR ---
pista_tamanho = 1500;
segment_length = 200;
track_width = 1500;
cam_height = 1000;
cam_depth = 1 / tan((80/2) * pi/180);

// --- GERAÇÃO DO TOUGE E CENÁRIO ---
var i;
for (i = 0; i < pista_tamanho; i += 1) {
    // 1. Curvatura (Estilo JS Racer)
    if (i > 100 && i < 300) road_curve[i] = 2;
    else if (i > 400 && i < 700) road_curve[i] = -3;
    else if (i > 800 && i < 1100) road_curve[i] = 4;
    else road_curve[i] = 0;

    // 2. Relevo
    road_y[i] = sin(i/30) * 400 + (i * -32);

    // 3. Cenário (0 = Nada, 1 = Árvore Esq, 2 = Árvore Dir, 3 = Guard Rail)
    road_sprite[i] = 0;

    // Coloca árvores aleatórias a cada 8 segmentos
    if (i mod 8 == 0) {
        road_sprite[i] = choose(1, 2);
    }

    // Se for uma curva muito fechada, coloca Guard Rail em vez de árvore
    if (abs(road_curve[i]) > 1) {
        road_sprite[i] = 3;
    }
}

// --- PLAYER E RIVAL ---
position = 0;
player_x = 0;
p_scale = 1.5;
vel = 0;
vel_max = 80;
vel_boost = 120; // Velocidade de ultrapassagem

// Rival começa 30 segmentos na frente
rival_pos = 30 * segment_length;
rival_x = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// --- ACELERAÇÃO DO PLAYER ---
var _key_accel, _key_left, _key_right;
_key_accel = keyboard_check(vk_up);
_key_left  = keyboard_check(vk_left);
_key_right = keyboard_check(vk_right);

if (_key_accel) vel += 2; else vel -= 1;
vel = clamp(vel, 0, vel_boost); // Permite chegar no boost!

// Avançar na pista
position += vel;
if (position >= pista_tamanho * segment_length) position = 0;

// --- MOVIMENTO E CENTRÍFUGA ---
speed_ratio = vel / vel_max;
if (_key_left)  player_x -= 0.04 * speed_ratio;
if (_key_right) player_x += 0.04 * speed_ratio;

var player_seg;
player_seg = floor(position / segment_length);
player_x -= (speed_ratio * road_curve[player_seg] * 0.015);
player_x = clamp(player_x, -2, 2);

// --- IA DO RIVAL (ELÁSTICO DE TOUGE) ---
var dist_atual, rival_vel;
dist_atual = rival_pos - position;

// A Mágica do JS Racer: O rival reage à sua posição
if (dist_atual < 500) {
    // Se você colar nele, ele usa o "boost" para não deixar passar
    rival_vel = vel_max * 1.05;
    // Ele joga o carro pro meio para te bloquear
    rival_x *= 0.9;
} else if (dist_atual > 3000) {
    // Se você ficar muito pra trás, ele tira o pé
    rival_vel = vel_max * 0.8;
} else {
    // Velocidade normal de cruzeiro
    rival_vel = vel_max * 0.95;
}

rival_pos += rival_vel;
if (rival_pos >= pista_tamanho * segment_length) rival_pos = 0;

// Ziguezague nas retas
if (dist_atual >= 500) rival_x = sin(current_time / 800) * 0.4;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var base_seg, max_y, x_offset, curve_inc, i, cam_z, p_scale_local, shake, p_angle;

p_scale_local = 1.5;
base_seg = floor(position / segment_length);
cam_z = position;
max_y = view_hview[0];
x_offset = 0;
curve_inc = 0;

// 1. Fundo
draw_set_color(make_color_rgb(15, 15, 35));
draw_rectangle(0, 0, view_wview[0], view_hview[0]/2, false);

// 2. Renderização Front-to-Back
for (i = 0; i < 80; i += 1) {
    var s1, s2, z_dist1, project_scale1, p1_x, p1_y, p1_w;
    var z_dist2, project_scale2, p2_x, p2_y, p2_w;

    s1 = (base_seg + i) mod pista_tamanho;
    s2 = (s1 + 1) mod pista_tamanho;

    z_dist1 = (i * segment_length) - (position mod segment_length);
    if (z_dist1 <= 0) {
        x_offset += curve_inc; curve_inc += road_curve[s1];
        continue;
    }

    project_scale1 = cam_depth / z_dist1;
    p1_w = project_scale1 * track_width * (view_wview[0]/2);
    p1_x = (view_wview[0]/2) + (project_scale1 * (x_offset - player_x * track_width) * (view_wview[0]/2));
    p1_y = (view_hview[0]/2) - (project_scale1 * (cam_height + road_y[s1] - road_y[base_seg]) * (view_hview[0]/2));

    x_offset += curve_inc; curve_inc += road_curve[s1];

    z_dist2 = ((i+1) * segment_length) - (position mod segment_length);
    if (z_dist2 <= 0) continue;

    project_scale2 = cam_depth / z_dist2;
    p2_w = project_scale2 * track_width * (view_wview[0]/2);
    p2_x = (view_wview[0]/2) + (project_scale2 * (x_offset - player_x * track_width) * (view_wview[0]/2));
    p2_y = (view_hview[0]/2) - (project_scale2 * (cam_height + road_y[s2] - road_y[base_seg]) * (view_hview[0]/2));

    if (p1_y >= max_y) continue;
    max_y = p1_y;

    // --- CHÃO LATERAL ---
    var col_ground, col_rumble;
    if ((floor((base_seg + i) / 3) mod 2) == 0) {
        col_ground = make_color_rgb(10, 40, 10); col_rumble = c_red;
    } else {
        col_ground = make_color_rgb(20, 60, 20); col_rumble = c_white;
    }
    draw_set_color(col_ground);
    draw_rectangle(0, p1_y, view_wview[0], p2_y, false);

    // --- PISTA E ZEBRAS (COM O BUG CORRIGIDO) ---
    var abs_w1, abs_w2;
    abs_w1 = abs(p1_w); abs_w2 = abs(p2_w);

    // Asfalto Sólido Base
    draw_set_color(c_dkgray);
    draw_primitive_begin(pr_trianglestrip);
        draw_vertex(p1_x - abs_w1, p1_y);
        draw_vertex(p1_x + abs_w1, p1_y);
        draw_vertex(p2_x - abs_w2, p2_y);
        draw_vertex(p2_x + abs_w2, p2_y);
    draw_primitive_end();

    // Textura da Pista
    draw_sprite_pos(road_3d, 0, p2_x - abs_w2, p2_y, p2_x + abs_w2, p2_y, p1_x + abs_w1, p1_y, p1_x - abs_w1, p1_y, 1);

    // Zebras
    draw_set_color(col_rumble);
    var r_w1, r_w2;
    r_w1 = abs_w1 * 0.15; r_w2 = abs_w2 * 0.15;

    draw_primitive_begin(pr_trianglestrip); // Esquerda
        draw_vertex(p1_x - abs_w1 - r_w1, p1_y); draw_vertex(p1_x - abs_w1, p1_y);
        draw_vertex(p2_x - abs_w2 - r_w2, p2_y); draw_vertex(p2_x - abs_w2, p2_y);
    draw_primitive_end();

    draw_primitive_begin(pr_trianglestrip); // Direita
        draw_vertex(p1_x + abs_w1, p1_y); draw_vertex(p1_x + abs_w1 + r_w1, p1_y);
        draw_vertex(p2_x + abs_w2, p2_y); draw_vertex(p2_x + abs_w2 + r_w2, p2_y);
    draw_primitive_end(); // <-- ESTE ERA O QUE FALTAVA!

    // --- CENÁRIO (ÁRVORES E GUARD RAILS) ---
    var item_scale;
    item_scale = project_scale1 * 3.0; // Ajusta o tamanho dos objetos

    if (road_sprite[s1] == 1) { // Árvore Esquerda
        draw_sprite_ext(tree_spr, 0, p1_x - abs_w1 - (abs_w1 * 0.5), p1_y, item_scale, item_scale, 0, c_white, 1);
    }
    else if (road_sprite[s1] == 2) { // Árvore Direita
        draw_sprite_ext(tree_spr, 0, p1_x + abs_w1 + (abs_w1 * 0.5), p1_y, item_scale, item_scale, 0, c_white, 1);
    }
    else if (road_sprite[s1] == 3) { // Guard Rail (desenha nas duas bordas para simular barreira na curva)
        draw_sprite_ext(guardrail_spr, 0, p1_x - abs_w1, p1_y, item_scale, item_scale, 0, c_white, 1);
        draw_sprite_ext(guardrail_spr, 0, p1_x + abs_w1, p1_y, item_scale, item_scale, 0, c_white, 1);
    }

    // --- RIVAL ---
    if (floor(rival_pos / segment_length) == s1) {
        var rs, rx;
        rs = project_scale1 * 1.5;
        rx = p1_x + (project_scale1 * (rival_x * track_width) * (view_wview[0] / 2));
        draw_sprite_ext(revolution_back3D, 0, rx, p1_y, rs * 100, rs * 100, 0, c_white, 1);
    }
}

// 7. PLAYER
if (vel > 0) shake = sin(current_time / 20) * (vel / 10); else shake = 0;
p_angle = -road_curve[base_seg] * 4;
draw_sprite_ext(charlotte_horse_back3D, 0, view_wview[0] / 2, view_hview[0] - 70 + shake, p_scale_local, p_scale_local, p_angle, c_white, 1);
