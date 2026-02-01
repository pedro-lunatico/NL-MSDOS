#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Inicialização do Menu Charlotte Trussardi de Lorca

// --- Controle de Exibição e Animação ---
show_inventory = false;
inv_alpha = 0;       // Opacidade para fade-in
scroll_inv = 0;      // Scroll da lista de itens
inv_anim = 0;        // Oscilação de brilho Aero
dance_frame = 0;     // Frame da animação de dança no pedestal

// --- Sistema de Abas (Estilo Fire Emblem) ---
pagina_atual = 1;    // 1: Itens, 2: Romance, 3: Status/Save
item_selecionado = -1;
aguardando_confirmacao = -1; // Index para descarte de item

// --- Identidade e Economia ---
nome_completo = "Charlotte Trussardi de Lorca";
if (!variable_global_exists("money")) global.money = 0;

// --- Cores Estilo Frutiger Aero & Categorias ---
cor_vidro_base = make_color_rgb(0, 140, 240);  // Azul Ciano
cor_lorca_ouro = make_color_rgb(240, 210, 110); // Ouro FE/Lorca

// Cores de texto por tipo de item
cor_quimico  = make_color_rgb(50, 255, 50);   // Verde
cor_pokemon  = make_color_rgb(255, 50, 50);   // Vermelho
cor_especial = make_color_rgb(255, 200, 50);  // Amarelo/Laranja

// --- Inicialização do Inventário (Padrão GM 8.1) ---
if (!variable_global_exists("player_inventory")) {
    global.player_inventory = ds_list_create();
    ds_list_add(global.player_inventory, "Fe");
    ds_list_add(global.player_inventory, "H");
    ds_list_add(global.player_inventory, "O");
    ds_list_add(global.player_inventory, "Ag");
    ds_list_add(global.player_inventory, "Cl");
    ds_list_add(global.player_inventory, "C");
    ds_list_add(global.player_inventory, "makernimite");
    ds_list_add(global.player_inventory, "tepig");
    ds_list_add(global.player_inventory, "volcarona");
    ds_list_add(global.player_inventory, "magikarp");
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// STEP EVENT - inventory_controller

// 1. Controle de Fade e Visibilidade
if (keyboard_check(vk_tab)) {
    if (inv_alpha < 1) inv_alpha += 0.1;
} else {
    if (inv_alpha > 0) inv_alpha -= 0.1;
}

// 2. Lógica Interna do Menu (Apenas se visível)
if (inv_alpha >= 1) {

    // Troca de Páginas (Estilo Fire Emblem)
    if (keyboard_check_pressed(vk_right)) {
        pagina_atual += 1;
        if (pagina_atual > 3) pagina_atual = 1;
        scroll_inv = 0;
    }
    if (keyboard_check_pressed(vk_left)) {
        pagina_atual -= 1;
        if (pagina_atual < 1) pagina_atual = 3;
        scroll_inv = 0;
    }

    // Controle de Scroll (Página 1)
    if (pagina_atual == 1) {
        if (mouse_wheel_up()) scroll_inv -= 20;
        if (mouse_wheel_down()) scroll_inv += 20;
        scroll_inv = max(0, scroll_inv);
    }

    // LÓGICA DE SAVE (Página 3)
    if (pagina_atual == 3) {
        var vx, vy, stat_x, sy;
        vx = view_xview[0]; vy = view_yview[0];
        stat_x = vx + 20 + 125;
        sy = vy + 20 + 120; // Posição Y do botão SAVE

        // Detecta clique no botão SAVE
        if (mouse_x > stat_x+20 && mouse_x < stat_x+100 && mouse_y > sy && mouse_y < sy+25) {
            if (mouse_check_button_pressed(mb_left)) {

                // Executa Save Nativo
                game_save("NLMSDOS");

                // Sistema de Diálogo/Mensagem Global
                if (variable_global_exists("mensagens")) {
                    ds_list_add(global.mensagens, "Jogo salvo com sucesso!");
                    global.dialogo_ativo = true;
                    global.caracteres_mostrados = 0;
                    global.contador = 0;
                    global.mensagem_atual = ds_list_size(global.mensagens) - 1;
                }
            }
        }
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// DRAW EVENT - inventory_controller
if (inv_alpha <= 0) exit;

var vx, vy, vw, vh, px, py, pw, ph, stat_x;
vx = view_xview[0]; vy = view_yview[0];
vw = view_wview[0]; vh = view_hview[0];

// Definições de Layout
px = vx + 20; py = vy + 20;
pw = vw - 40; ph = vh - 40;
stat_x = px + 125;

draw_set_alpha(inv_alpha);

// --- 1. FUNDO BRANCO DEGRADÊ (AERO) ---
draw_set_color(c_white);
draw_set_alpha(inv_alpha * 0.98);
draw_rectangle(vx, vy, vx + vw, vy + vh, false);

draw_set_alpha(inv_alpha * 0.3);
draw_rectangle_color(vx, vy, vx + vw, vy + vh, make_color_rgb(180, 230, 255), make_color_rgb(180, 230, 255), c_white, c_white, false);

// --- 2. PAINEL AZUL COM BORDA METÁLICA (GLASS BG) ---
// Borda Metálica Externa do Inventário
draw_set_alpha(inv_alpha * 0.9);
draw_roundrect_color(stat_x - 2, py - 2, px + pw + 2, py + ph + 2, make_color_rgb(180, 190, 200), make_color_rgb(80, 90, 100), false);

// Painel Azul Interno
draw_set_alpha(inv_alpha * 0.85);
draw_roundrect_color(stat_x, py, px+pw, py+ph, make_color_rgb(0, 110, 210), make_color_rgb(0, 35, 85), false);

// Brilho Glossy Superior
draw_set_alpha(inv_alpha * 0.4);
draw_ellipse_color(stat_x + 5, py + 5, px + pw - 5, py + 100, c_white, make_color_rgb(0, 110, 210), false);

// --- 3. MOLDURA METÁLICA E PORTRAIT ---
var m_x1, m_y1, m_x2, m_y2;
m_x1 = px; m_y1 = py; m_x2 = stat_x - 10; m_y2 = py + 100;

// Fundo Metálico (Degradê de cinzas)
draw_set_alpha(inv_alpha * 0.9);
draw_roundrect_color(m_x1, m_y1, m_x2, m_y2, make_color_rgb(150, 160, 175), make_color_rgb(70, 80, 95), false);

// Borda Metálica Brilhante (Contorno)
draw_set_color(make_color_rgb(220, 230, 240)); draw_set_alpha(inv_alpha * 0.7);
draw_roundrect(m_x1, m_y1, m_x2, m_y2, true);

// Portrait colado na base da moldura
draw_set_alpha(inv_alpha);
spr_h = sprite_get_height(spr_portrait_charlotte) * 0.85;
draw_sprite_ext(spr_portrait_charlotte, 0, m_x1 + 2, m_y2 - spr_h - 1, 0.85, 0.85, 0, c_white, inv_alpha);

// --- 4. MOLDURA LARANJA DO NOME (ESTILO FE) ---
n_y = m_y2 + 5;
n_w = 110;
n_h = 32;

// Fundo Laranja Metálico
draw_set_alpha(inv_alpha * 0.95);
draw_roundrect_color(px, n_y, px + n_w, n_y + n_h, make_color_rgb(255, 160, 50), make_color_rgb(180, 80, 0), false);

// Borda da caixa de nome
draw_set_color(c_white); draw_set_alpha(inv_alpha * 0.6);
draw_roundrect(px, n_y, px + n_w, n_y + n_h, true);

// Nome da Personagem
draw_set_font(normal);
draw_set_color(c_white);
draw_text_ext(px + 5, n_y + 4, "Charlotte T. de Lorca", 14, n_w - 10);

// --- 5. BASE 3D E SPRITE ACIMA DA BASE ---
var ped_x, ped_y;
ped_x = px + 48; ped_y = py + 215;

// Base Aero
draw_set_color(make_color_rgb(0, 50, 90)); draw_set_alpha(inv_alpha * 0.5);
draw_ellipse(ped_x - 30, ped_y - 4, ped_x + 30, ped_y + 12, false);
draw_set_color(make_color_rgb(180, 240, 255)); draw_set_alpha(inv_alpha * 0.9);
draw_ellipse(ped_x - 30, ped_y - 8, ped_x + 30, ped_y + 8, false);
draw_set_color(c_white); draw_set_alpha(inv_alpha * 0.6);
draw_ellipse(ped_x - 30, ped_y - 8, ped_x + 30, ped_y + 8, true);

// Animação e Desenho do Sprite (Posicionado acima da base)
dance_frame += 0.15;
var spr_d; if (global.player_sprite == ply_standing) spr_d = ply_dance; else spr_d = ply_dance_alt;
draw_set_alpha(inv_alpha);
draw_sprite_ext(spr_d, dance_frame, ped_x, ped_y - 25, 1, 1, 0, c_white, inv_alpha);

// --- 6. PÁGINAS DO INVENTÁRIO ---
draw_set_color(c_white);
aba_txt = "Pagina " + string(pagina_atual) + "/3";
draw_text(stat_x + (pw - 125)/2 - string_width(aba_txt)/2, py + 12, aba_txt);

switch(pagina_atual) {
    case 1: // INVENTÁRIO
        item_y = py + 45;
        for (i = 0; i < ds_list_size(global.player_inventory); i += 1) {
            name = ds_list_find_value(global.player_inventory, i);
            iy = item_y + (i * 20) - scroll_inv;
            if (iy > py + 40 && iy < py + ph - 20) {
                draw_set_color(scr_get_item_info(name, 1));
                draw_text(stat_x + 20, iy, name);
            }
        }
    break;

    case 2: // AFINIDADE
        var _p; if (instance_exists(Relationship_control)) _p = Relationship_control.pontos; else _p = 0;
        draw_set_color(c_white);
        draw_text(stat_x + 20, py + 50, "Afinidade Dew: " + string(_p) + "%");
        draw_set_color(c_black); draw_rectangle(stat_x+20, py+70, stat_x+180, py+82, false);
        draw_set_color(make_color_rgb(255, 100, 150));
        draw_rectangle(stat_x+20, py+70, stat_x+20+(160*(_p/100)), py+82, false);
    break;

    case 3: // STATUS & SAVE
        draw_set_color(c_white);
        draw_text(stat_x+20, py+50, "Nivel: " + string(global.nivel));
        draw_text(stat_x+20, py+75, "Diamantes: D$" + string(global.money));

        sy = py + 120;
        draw_set_alpha(inv_alpha * 0.2); draw_roundrect(stat_x+20, sy, stat_x+100, sy+25, false);
        draw_set_alpha(inv_alpha); draw_set_color(c_white);
        draw_roundrect(stat_x+20, sy, stat_x+100, sy+25, true);
        draw_text(stat_x+35, sy+5, "SAVE");
    break;
}

draw_set_alpha(1);
