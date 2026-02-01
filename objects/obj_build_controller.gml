#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Inicializa lista global de móveis
if (!variable_global_exists("furniture_list")) {
    global.furniture_list = ds_list_create();
}

// --- Grid ---
global.CELL = 32;
global.cols = room_width div global.CELL;
global.rows = room_height div global.CELL;

// --- Móveis disponíveis ---
global.item_name[0] = "Sofa";
global.item_sprite[0] = spr_sofa;
global.item_object[0] = Sofa_OBJ;

global.item_name[1] = "Armario";
global.item_sprite[1] = spr_armario;
global.item_object[1] = Armario_OBJ;

global.item_name[2] = "TV";
global.item_sprite[2] = spr_tv;
global.item_object[2] = Tv_OBJ;

// --- Painel ---
panel_y = 0;
panel_height = 64;

// Móvel selecionado
selected_item = -1;

// Botão salvar
btn_x = 640;
btn_y = 10;
btn_w = 120;
btn_h = 40;

// Mouse
mx = 0;
my = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Atualiza mouse
mx = mouse_x;
my = mouse_y;

// --- Seleção de móveis no painel ---
idx = 0;
while (idx < 3) {
    px = 64 + idx * 96;
    spr_w = sprite_get_width(global.item_sprite[idx]);
    spr_h = sprite_get_height(global.item_sprite[idx]);
    py = panel_y + (panel_height - spr_h) / 2;

    if (mouse_check_button_pressed(mb_left)) {
        if (mx > px - spr_w/2 && mx < px + spr_w/2 &&
            my > panel_y && my < panel_y + panel_height) {
            selected_item = idx;
        }
    }
    idx += 1;
}

// --- Colocar móvel na grid (clique esquerdo) ---
if (mouse_check_button_pressed(mb_left) && selected_item != -1 && my > panel_height) {
    gx = floor(mx / global.CELL);
    gy = floor(my / global.CELL);

    // verifica se já existe móvel nessa posição
    exists_here = false;
    i = 0;
    while (i < ds_list_size(global.furniture_list)) {
        it = ds_list_find_value(global.furniture_list, i);
        if (ds_list_find_value(it, 1) == gx && ds_list_find_value(it, 2) == gy) {
            exists_here = true;
            break;
        }
        i += 1;
    }

    if (!exists_here) {
        // salva na lista
        item = ds_list_create();
        ds_list_add(item, selected_item);
        ds_list_add(item, gx);
        ds_list_add(item, gy);
        ds_list_add(item, global.item_sprite[selected_item]);
        ds_list_add(global.furniture_list, item);

        // cria objeto real
        instance_create(gx * global.CELL, gy * global.CELL, global.item_object[selected_item]);
    }

    selected_item = -1;
}

// --- Botão salvar ---
if (mouse_check_button_pressed(mb_left)) {
    if (mx >= btn_x && mx <= btn_x + btn_w &&
        my >= btn_y && my <= btn_y + btn_h) {

        ini_open("NLMSDOS_APT_SAV.ini");

        i = 0;
        while (i < ds_list_size(global.furniture_list)) {
            it = ds_list_find_value(global.furniture_list, i);
            kind = ds_list_find_value(it, 0);
            gx   = ds_list_find_value(it, 1);
            gy   = ds_list_find_value(it, 2);
            ini_write_real("DATA", string(gx) + "_" + string(gy), kind);
            i += 1;
        }

        ini_close();
        show_message("Jogo salvo!");
    }
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Limpa lista antiga
i = 0;
while (i < ds_list_size(global.furniture_list)) {
    item = ds_list_find_value(global.furniture_list, i);
    ds_list_destroy(item);
    i += 1;
}
ds_list_clear(global.furniture_list);

// Remove móveis antigos da room
with (Sofa_OBJ) instance_destroy();
with (Armario_OBJ) instance_destroy();
with (Tv_OBJ) instance_destroy();

// --- Carrega móveis do INI ---
ini_open("NLMSDOS_APT_SAV.ini");

i = 0;
while (i < global.cols) {
    j = 0;
    while (j < global.rows) {
        k = ini_read_real("DATA", string(i) + "_" + string(j), -1);
        if (k >= 0 && k <= 2) {
            // salva na lista
            item = ds_list_create();
            ds_list_add(item, k);
            ds_list_add(item, i);
            ds_list_add(item, j);
            ds_list_add(item, global.item_sprite[k]);
            ds_list_add(global.furniture_list, item);

            // cria objeto real
            instance_create(i * global.CELL, j * global.CELL, global.item_object[k]);
        }
        j += 1;
    }
    i += 1;
}

ini_close();
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// --- Painel superior ---
draw_set_color(c_gray);
draw_rectangle(0, panel_y, room_width, panel_y + panel_height, false);

// --- Desenha móveis disponíveis no painel ---
idx = 0;
while (idx < 3) {
    px = 64 + idx * 96;
    spr_w = sprite_get_width(global.item_sprite[idx]);
    spr_h = sprite_get_height(global.item_sprite[idx]);
    py = panel_y + (panel_height - spr_h) / 2;

    draw_sprite(global.item_sprite[idx], 0, px - spr_w/2, py);

    if (selected_item == idx) {
        draw_set_color(c_yellow);
        draw_rectangle(px - 32, panel_y, px + 32, panel_y + panel_height, false);
        draw_set_color(c_white);
    }
    idx += 1;
}

// --- Botão salvar ---
if (mx >= btn_x && mx <= btn_x + btn_w &&
    my >= btn_y && my <= btn_y + btn_h) {
    draw_set_color(c_aqua);
} else {
    draw_set_color(c_blue);
}
draw_rectangle(btn_x, btn_y, btn_x + btn_w, btn_y + btn_h, false);
draw_set_color(c_white);
draw_text(btn_x + 10, btn_y + 10, "Salvar");
