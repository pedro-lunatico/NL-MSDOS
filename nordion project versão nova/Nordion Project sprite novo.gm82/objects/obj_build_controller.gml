#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// --- DECLARAÇÃO DE INSTÂNCIA (Sem o 'var'!) ---
hud_btn_x = 20;
hud_btn_y = room_height - 70;
hud_btn_w = 140;
hud_btn_h = 50;

pop_w = 600;
pop_h = 400;
pop_x = (room_width - pop_w) / 2;
pop_y = (room_height - pop_h) / 2;

btn_close_x = pop_x + pop_w - 35;
btn_close_y = pop_y + 5;
btn_close_w = 30;
btn_close_h = 30;

catalog_open = false;
selected_item_idx = -1;
anim_wave = 0;
can_place = false;

// --- GLOBAIS ---
global.CELL = 32;
global.catalog_grid = ds_grid_create(3, 0);

// --- SCRIPTS (Sempre por último) ---
scr_scan_furniture();
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
mx = mouse_x;
my = mouse_y;
anim_wave += 0.1;

// 1. CLIQUE NO HUD (LOJA)
if (mouse_check_button_pressed(mb_left)) {
    if (mx > hud_btn_x && mx < hud_btn_x + hud_btn_w && my > hud_btn_y && my < hud_btn_y + hud_btn_h) {
        catalog_open = !catalog_open;
        selected_item_idx = -1;
        exit;
    }
}

// 2. LÓGICA DO CATÁLOGO ABERTO
if (catalog_open) {
    // Botão Fechar (X)
    if (mouse_check_button_pressed(mb_left)) {
        if (mx > btn_close_x && mx < btn_close_x + btn_close_w && my > btn_close_y && my < btn_close_y + btn_close_h) {
            catalog_open = false;
            exit;
        }
    }

    var i, rows, gx, gy, item_p;
    rows = ds_grid_height(global.catalog_grid);

    for (i = 0; i < rows; i += 1) {
        gx = pop_x + 35 + (i mod 3) * 185;
        gy = pop_y + 60 + (i div 3) * 140;

        if (mouse_check_button_pressed(mb_left)) {
            // Se clicar no card do item
            if (mx > gx && mx < gx + 165 && my > gy && my < gy + 125) {
                item_p = ds_grid_get(global.catalog_grid, 2, i);

                // --- VERIFICAÇÃO DE SALDO ---
                if (global.money >= item_p) {
                    selected_item_idx = i;
                    catalog_open = false; // Fecha para poder colocar
                    can_place = false;    // Trava inicial para evitar clique duplo
                    exit;
                } else {
                    // Mensagem de erro personalizada
                    show_message("Saldo insuficiente na conta Azathoth Bank!");
                }
            }
        }
    }
}

// 3. COLOCAR NO CENÁRIO
else if (selected_item_idx != -1) {
    if (mouse_check_button_released(mb_left)) {
        can_place = true;
    }

    if (mouse_check_button_pressed(mb_left) && can_place) {
        if (!(mx > hud_btn_x && mx < hud_btn_x + hud_btn_w && my > hud_btn_y && my < hud_btn_y + hud_btn_h)) {
            var obj_id, preco, snap_x, snap_y;
            obj_id = ds_grid_get(global.catalog_grid, 0, selected_item_idx);
            preco  = ds_grid_get(global.catalog_grid, 2, selected_item_idx);

            snap_x = (mx div global.CELL) * global.CELL;
            snap_y = (my div global.CELL) * global.CELL;

            if (!position_meeting(snap_x + 16, snap_y + 16, obj_build_controller)) {
                instance_create(snap_x, snap_y, obj_id);
                global.money -= preco;

                // Se quiser colocar apenas um e resetar, descomente a linha abaixo:
                // selected_item_idx = -1;
            }
        }
    }

    if (mouse_check_button_pressed(mb_right)) {
        selected_item_idx = -1;
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// --- 0. SEPARAÇÃO PAI/FILHO ---
// Se este código estiver rodando em um móvel (filho), desenha o sprite e sai
if (object_index != obj_build_controller) {
    draw_self();
    exit; // Impede que o móvel tente desenhar o HUD nele mesmo
}

// --- 1. SEGURANÇA E AMBIENTE ---
if (!variable_local_exists("hud_btn_x")) exit;

// --- 2. HUD DA MIKU SHOP ---
// Botão principal
draw_set_color(make_color_rgb(0, 150, 255));
draw_roundrect(hud_btn_x, hud_btn_y, hud_btn_x + hud_btn_w, hud_btn_y + hud_btn_h, false);

// Texto do Botão
draw_set_color(c_white);
draw_text(hud_btn_x + 12, hud_btn_y + 18, "Miku Furniture Shop");

// Moedas/Diamantes com Sombra
draw_set_color(c_black);
draw_text(21, 21, "Diamantes: " + string(global.money));
draw_set_color(c_white);
draw_text(20, 20, "Diamantes: " + string(global.money));

// --- 3. POPUP DO CATÁLOGO ---
if (catalog_open) {
    // Escurecer o cenário atrás
    draw_set_alpha(0.5);
    draw_set_color(c_black);
    draw_rectangle(0, 0, room_width, room_height, false);
    draw_set_alpha(1.0);

    // Janela Aero
    draw_set_color(make_color_rgb(230, 245, 255));
    draw_roundrect(pop_x, pop_y, pop_x + pop_w, pop_y + pop_h, false);

    // Barra de Título
    draw_set_color(make_color_rgb(0, 120, 215));
    draw_roundrect(pop_x, pop_y, pop_x + pop_w, pop_y + 40, false);

    draw_set_color(c_white);
    draw_text(pop_x + 20, pop_y + 12, "CATALOGO DE APARTAMENTO");

    // Botão Fechar (X)
    draw_set_color(c_red);
    draw_circle(btn_close_x + 15, btn_close_y + 15, 12, false);
    draw_set_color(c_white);
    draw_text(btn_close_x + 10, btn_close_y + 8, "X");

    // Desenho dos Itens
    var i, rows, gx, gy, spr, preco, nome_limpo;
    rows = ds_grid_height(global.catalog_grid);

    for (i = 0; i < rows; i += 1) {
        gx = pop_x + 35 + (i mod 3) * 185;
        gy = pop_y + 60 + (i div 3) * 140;

        spr   = ds_grid_get(global.catalog_grid, 1, i);
        preco = ds_grid_get(global.catalog_grid, 2, i);
        nome_limpo = string_replace(object_get_name(ds_grid_get(global.catalog_grid, 0, i)), "obj_", "");

        // Card do Item
        draw_set_color(c_white);
        draw_roundrect(gx, gy, gx + 165, gy + 125, false);

        if (sprite_exists(spr)) {
            draw_sprite(spr, 0, gx + 82 - (sprite_get_width(spr)/2), gy + 15);
        }

        draw_set_color(c_black);
        draw_text(gx + 10, gy + 85, string_upper(nome_limpo));
        draw_set_color(make_color_rgb(0, 150, 0));
        draw_text(gx + 10, gy + 105, "Preco: " + string(preco));
    }
}

// --- 4. PREVIEW (FANTASMA) NO CURSOR ---
if (selected_item_idx != -1 && !catalog_open) {
    var p_spr, p_x, p_y;
    p_spr = ds_grid_get(global.catalog_grid, 1, selected_item_idx);

    // Alinhamento na Grade
    p_x = (mouse_x div global.CELL) * global.CELL;
    p_y = (mouse_y div global.CELL) * global.CELL;

    draw_set_alpha(0.6);
    if (sprite_exists(p_spr)) {
        draw_sprite(p_spr, 0, p_x, p_y);
    }

    // Indicador de Grade
    draw_set_color(c_white);
    draw_rectangle(p_x, p_y, p_x + global.CELL, p_y + global.CELL, true);
    draw_set_alpha(1.0);
}
