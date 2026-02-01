#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// CREATE EVENT - crafting_table

// Menu de crafting
menu_visible = false;
menu_x = 100;
menu_y = 50;
menu_w = 300;
menu_h = 250;

// Lista temporária de seleção
crafting_items = ds_list_create();

// Hover
hover_index = -1;

// Receitas (cada ds_list = reagentes..., resultado)
recipes = ds_list_create();

// Exemplo: H2O (mantive se quiser)
r1 = ds_list_create();
ds_list_add(r1,"H"); ds_list_add(r1,"H"); ds_list_add(r1,"O"); ds_list_add(r1,"H2O"); ds_list_add(recipes,r1);

// Solução Regenerativa (H + O + O)
r8 = ds_list_create();
ds_list_add(r8, "H"); ds_list_add(r8, "O"); ds_list_add(r8, "O"); ds_list_add(r8, "Solução Regenerativa"); ds_list_add(recipes, r8);

// Nuvem Catalisadora (Ag + Cl)
r9 = ds_list_create();
ds_list_add(r9, "Ag"); ds_list_add(r9, "Cl"); ds_list_add(r9, "Nuvem Catalisadora"); ds_list_add(recipes, r9);

// Composto Inflamável (C + H + H)
r10 = ds_list_create();
ds_list_add(r10, "C"); ds_list_add(r10, "H"); ds_list_add(r10, "H"); ds_list_add(r10, "Composto Inflamável"); ds_list_add(recipes, r10);

// Reagente de Ferrugem Ativa (Fe + O)
r11 = ds_list_create();
ds_list_add(r11, "Fe"); ds_list_add(r11, "O"); ds_list_add(r11, "Reagente de Ferrugem Ativa"); ds_list_add(recipes, r11);

// Agente Purificador (Ag + H + O)
r12 = ds_list_create();
ds_list_add(r12, "Ag"); ds_list_add(r12, "H"); ds_list_add(r12, "O"); ds_list_add(r12, "Agente Purificador"); ds_list_add(recipes, r12);

// Carga Asfixiante (C + O + O)
r13 = ds_list_create();
ds_list_add(r13, "C"); ds_list_add(r13, "O"); ds_list_add(r13, "O"); ds_list_add(r13, "Carga Asfixiante"); ds_list_add(recipes, r13);

// Liga Instável (Fe + C + O)
r14 = ds_list_create();
ds_list_add(r14, "Fe"); ds_list_add(r14, "C"); ds_list_add(r14, "O"); ds_list_add(r14, "Liga Instável"); ds_list_add(recipes, r14);

// Gás Irritante (H + Cl)
r15 = ds_list_create();
ds_list_add(r15, "H"); ds_list_add(r15, "Cl"); ds_list_add(r15, "Gás Irritante"); ds_list_add(recipes, r15);

// Garantir inventário global (caso ainda não exista)
if (!variable_global_exists("player_inventory")) {
    global.player_inventory = ds_list_create();
    // opcional: preencher aqui
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// STEP EVENT - crafting_table

// Abre menu ao clicar na instância
if (mouse_check_button_pressed(mb_left) && position_meeting(mouse_x, mouse_y, id)) {
    menu_visible = true;
}

// Processa menu quando visível
if (menu_visible) {

    // Hover sobre inventário (cadeia de slots)
    inv = global.player_inventory;
    mx = mouse_x;
    my = mouse_y;
    base_x = menu_x + 10;
    base_y = menu_y + 110;
    gap = 36;

    hover_index = -1;
    inv_size = ds_list_size(inv);
    for (i = 0; i < inv_size; i += 1) {
        ix = base_x + (i mod 6) * gap;
        iy = base_y + (i div 6) * gap;
        if (mx > ix && mx < ix + 32 && my > iy && my < iy + 32) {
            hover_index = i;
            break;
        }
    }

    // --- Selecionar elemento (esquerdo) ---
    if (mouse_check_button_pressed(mb_left) && hover_index != -1) {
        val = ds_list_find_value(inv, hover_index);

        // VALIDAÇÃO SEGURA (somente strings não vazias)
        if (is_string(val) && string_length(val) > 0) {
            // Conta quantas vezes 'val' já está em crafting_items
            already_selected = 0;
            sel_sz = ds_list_size(crafting_items);
            for (ii = 0; ii < sel_sz; ii += 1) {
                if (ds_list_find_value(crafting_items, ii) == val) already_selected += 1;
            }

            // Conta quantas vezes 'val' aparece no inventário global
            have_in_inventory = 0;
            inv_sz2 = ds_list_size(global.player_inventory);
            for (jj = 0; jj < inv_sz2; jj += 1) {
                if (ds_list_find_value(global.player_inventory, jj) == val) have_in_inventory += 1;
            }

            if (already_selected < have_in_inventory) {
                ds_list_add(crafting_items, val);
            } else {
                // comentário: se quiser feedback discreto, descomente a linha abaixo
                // show_message("Você não possui mais '" + string(val) + "' para usar.");
            }
        }
    }

    // Botão LIMPAR (área visual)
    clear_x1 = menu_x + 110;
    clear_y1 = menu_y + menu_h - 40;
    clear_x2 = menu_x + 190;
    clear_y2 = menu_y + menu_h - 15;
    if (mouse_check_button_pressed(mb_left)) {
        if (mouse_x > clear_x1 && mouse_x < clear_x2 && mouse_y > clear_y1 && mouse_y < clear_y2) {
            ds_list_clear(crafting_items);
        }
    }

    // Botão X (fechar)
    bx = menu_x + menu_w - 15;
    by = menu_y + 15;
    br = 12;
    if (mouse_check_button_pressed(mb_left)) {
        if (point_distance(mouse_x, mouse_y, bx, by) <= br) {
            menu_visible = false;
            ds_list_clear(crafting_items);
        }
    }

    // --- CRAFT (direito) ---
    if (mouse_check_button_pressed(mb_right)) {
        crafted = false;
        R = ds_list_size(recipes);

        // percorre receitas
        for (r = 0; r < R; r += 1) {
            rec = ds_list_find_value(recipes, r);
            recipe_len = ds_list_size(rec) - 1; // último = resultado

            // tamanho precisa bater
            if (ds_list_size(crafting_items) != recipe_len) continue;

            // cria temp_list com reagentes da receita
            temp_list = ds_list_create();
            for (i2 = 0; i2 < recipe_len; i2 += 1) {
                ds_list_add(temp_list, ds_list_find_value(rec, i2));
            }

            // comparar seleção vs receita (ordem não importa, conta ocorrências)
            matched = true;
            // para cada reagente único na temp_list vamos conferir necessidade x fornecido
            checked_items = ds_list_create();
            temp_sz = ds_list_size(temp_list);
            for (ti = 0; ti < temp_sz; ti += 1) {
                el = ds_list_find_value(temp_list, ti);

                // evitar recalcular para o mesmo elemento repetido
                if (ds_list_find_index(checked_items, el) != -1) continue;
                ds_list_add(checked_items, el);

                // conta quantas vezes 'el' é necessário na receita (need)
                need = 0;
                for (a = 0; a < temp_sz; a += 1) {
                    if (ds_list_find_value(temp_list, a) == el) need += 1;
                }

                // conta quantas vezes 'el' foi provido na seleção (provided)
                provided = 0;
                sel_sz2 = ds_list_size(crafting_items);
                for (b = 0; b < sel_sz2; b += 1) {
                    if (ds_list_find_value(crafting_items, b) == el) provided += 1;
                }

                if (provided < need) {
                    matched = false;
                    break;
                }
            }

            ds_list_destroy(checked_items);

            if (matched) {
                // adiciona resultado
                result_name = ds_list_find_value(rec, recipe_len);
                ds_list_add(global.player_inventory, result_name);

     // remove os reagentes usados do inventário global - remove a mesma quantidade usada
                sel_count = ds_list_size(crafting_items);
                for (s = 0; s < sel_count; s += 1) {
                    item_to_remove = ds_list_find_value(crafting_items, s);
                    idx = ds_list_find_index(global.player_inventory, item_to_remove);
                    if (idx != -1) {
                        ds_list_delete(global.player_inventory, idx);
                    }
                }

                // feedback e limpeza
                show_message("Você criou: " + string(result_name));
                ds_list_clear(crafting_items);
                crafted = true;

                ds_list_destroy(temp_list);
                break;
            }

            ds_list_destroy(temp_list);
        }

        if (!crafted) {
            show_message("Combinação inválida!");
        }
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// DRAW EVENT - interface do menu de crafting (quando menu_visible == true)
if (menu_visible) {
    // Fundo escurecido (transparência)
    draw_set_alpha(0.5);
    draw_set_color(c_black);
    draw_rectangle(0, 0, room_width, room_height, true);
    draw_set_alpha(1);

    // Menu base com sombra
    draw_set_color(make_color_rgb(8, 24, 40));
    draw_rectangle(menu_x, menu_y, menu_x + menu_w, menu_y + menu_h, true);
    draw_set_color(make_color_rgb(200, 200, 200));
    draw_rectangle(menu_x - 2, menu_y - 2, menu_x + menu_w + 2, menu_y + menu_h + 2, false);

    // Título com destaque
    draw_set_color(make_color_rgb(0, 220, 120));
    draw_text(menu_x + 12, menu_y + 8, "CRAFTING LAB");

    // Instruções com pulsação
    pulsar = 0.75 + sin(current_time / 300) * 0.25;
    draw_set_alpha(pulsar);
    draw_set_color(c_white);
    draw_text(menu_x + 12, menu_y + 30, "Clique nos elementos para adicionar. Clique direito para criar.");
    draw_set_alpha(1);

    // Ingredientes selecionados
    draw_set_color(c_white);
    draw_text(menu_x + 10, menu_y + 50, "Ingredientes selecionados:");
    yy = menu_y + 70;
    sel_size = ds_list_size(crafting_items);
    for (k = 0; k < sel_size; k += 1) {
        draw_text(menu_x + 20, yy, ds_list_find_value(crafting_items, k));
        yy += 16;
    }

    // Botão CRAFTAR (visual)
    craft_x1 = menu_x + 10;
    craft_y1 = menu_y + menu_h - 40;
    craft_x2 = menu_x + 100;
    craft_y2 = menu_y + menu_h - 15;
    draw_set_color(make_color_rgb(60, 180, 80));
    draw_rectangle(craft_x1, craft_y1, craft_x2, craft_y2, true);
    draw_set_color(c_black);
    draw_text(craft_x1 + 10, craft_y1 + 8, "CRAFTAR (dir)");

    // Botão LIMPAR
    clear_x1 = menu_x + 110;
    clear_y1 = menu_y + menu_h - 40;
    clear_x2 = menu_x + 190;
    clear_y2 = menu_y + menu_h - 15;
    draw_set_color(make_color_rgb(200, 140, 40));
    draw_rectangle(clear_x1, clear_y1, clear_x2, clear_y2, true);
    draw_set_color(c_black);
    draw_text(clear_x1 + 10, clear_y1 + 8, "LIMPAR");

    // Botão X (fechar)
    bx = menu_x + menu_w - 15;
    by = menu_y + 15;
    br = 12;
    draw_set_color(c_red);
    draw_circle(bx, by, br, false);
    draw_set_color(c_white);
    draw_text(bx - 4, by - 6, "X");

    // Inventário (grade)
    inv = global.player_inventory;
    base_x = menu_x + 10;
    base_y = menu_y + 110;
    gap = 36;
    inv_size = ds_list_size(inv);
    for (i = 0; i < inv_size; i += 1) {
        ix = base_x + (i mod 6) * gap;
        iy = base_y + (i div 6) * gap;

        // Slot
        if (i == hover_index) draw_set_color(make_color_rgb(70, 220, 120));
        else draw_set_color(make_color_rgb(40, 110, 60));
        draw_rectangle(ix, iy, ix + 32, iy + 32, true);

        // Item text
        draw_set_color(c_black);
        it = ds_list_find_value(inv, i);
        draw_text(ix + 4, iy + 8, string(it));
    }

    // Hover particle / círculo
    if (hover_index != -1 && hover_index < ds_list_size(global.player_inventory)) {
        hix = base_x + (hover_index mod 6) * gap;
        hiy = base_y + (hover_index div 6) * gap;
        draw_set_color(make_color_rgb(255, 255, 255));
        r = 4 + sin(current_time / 200) * 2;
        draw_circle(hix + 16, hiy + 16, r, false);
    }

    // Partículas leves de fundo (decoração, poucas para performance)
    draw_set_color(make_color_rgb(0, 200, 80));
    for (p = 0; p < 6; p += 1) {
        px = menu_x + 8 + irandom(menu_w - 16);
        py = menu_y + 8 + irandom(menu_h - 16);
        draw_point(px, py);
    }
}
