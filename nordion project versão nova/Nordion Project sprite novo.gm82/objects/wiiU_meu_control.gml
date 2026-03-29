#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Caminho local
path = working_directory + "\GameData\IntegratedGames\";
file_list = ds_list_create();

// Preenche a lista usando o script recursivo
scr_find_files(path, file_list);

// Configuração da Grade (Estilo Wii U)
colunas = 4;
espacamento_x = 160;
espacamento_y = 150;
margem_x = 60;
margem_y = 80;

// Variáveis de Controle
selected_index = -1;
scroll_y = 0;
anim_wave = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Scroll com a rodinha do mouse
if (mouse_wheel_up()) scroll_y += 30;
if (mouse_wheel_down()) scroll_y -= 30;
if (scroll_y > 0) scroll_y = 0; // Limite superior

selected_index = -1;

// Lógica de colisão na grade
for (i = 0; i < ds_list_size(file_list); i += 1) {
    var gx, gy;
    gx = margem_x + (i mod colunas) * espacamento_x;
    gy = margem_y + (i div colunas) * espacamento_y + scroll_y;

    // Área do clique (Card de 140x120)
    if (mouse_x > gx && mouse_x < gx + 140 && mouse_y > gy && mouse_y < gy + 120) {
        selected_index = i;
        if (mouse_check_button_pressed(mb_left)) {
            var file_to_run;
            file_to_run = ds_list_find_value(file_list, i);
            execute_program(file_to_run, "", false);
        }
    }
}

anim_wave += 0.05; // Velocidade do brilho de fundo
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// --- FUNDO GRADIENTE ---
draw_rectangle_color(0, 0, room_width, room_height, c_white, c_white, make_color_rgb(170, 230, 255), make_color_rgb(100, 190, 240), false);

// Elipse de Brilho Central (Efeito Wii U Menu)
draw_set_alpha(0.4);
draw_ellipse_color(-100, -100, room_width + 100, 300 + sin(anim_wave)*20, c_white, c_aqua, false);
draw_set_alpha(1.0);

// --- DESENHO DOS CARDS ---
for (i = 0; i < ds_list_size(file_list); i += 1) {
    var gx, gy, full_path, nome;
    gx = margem_x + (i mod colunas) * espacamento_x;
    gy = margem_y + (i div colunas) * espacamento_y + scroll_y;

    full_path = ds_list_find_value(file_list, i);
    nome = filename_name(full_path);
    nome = string_replace(nome, ".exe", "");
    nome = string_replace(nome, ".bat", "");

    // 1. Sombra e Seleção
    if (selected_index == i) {
        draw_set_alpha(0.6);
        draw_roundrect_color(gx-4, gy-4, gx+144, gy+124, c_yellow, c_white, false);
        draw_set_alpha(1.0);
    }

    // 2. Corpo do Card (Degradê de Vidro)
    var c_top, c_bot;
    c_top = make_color_rgb(245, 250, 255);
    c_bot = make_color_rgb(210, 235, 250);
    draw_roundrect_color(gx, gy, gx+140, gy+120, c_top, c_bot, false);

    // 3. Brilho Glossy Aero (Elipse branca no topo do card)
    draw_set_alpha(0.7);
    draw_ellipse_color(gx+5, gy+2, gx+135, gy+50, c_white, c_top, false);
    draw_set_alpha(1.0);

    // 4. Borda e Texto
    draw_set_color(c_white);
    draw_roundrect(gx, gy, gx+140, gy+120, true);

    draw_set_color(c_black);
    draw_set_halign(fa_center);
    draw_text_ext(gx + 70, gy + 65, nome, 16, 130);
}

// --- OVERLAY DE BOLHAS FRUTIGER ---
draw_set_alpha(0.2);
draw_circle(150, room_height - 100 + cos(anim_wave)*20, 30, false);
draw_circle(room_width - 100, room_height - 200 + sin(anim_wave)*15, 50, false);
draw_set_alpha(1.0);
