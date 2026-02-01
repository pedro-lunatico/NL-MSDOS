#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// --- Inicialização Aero (Charlotte vs RVL - Drift) ---

dialogo_ativo = true;
caracteres_mostrados = 0;
velocidade_letra = 2;
contador = 0;
fala_atual = 0;
room_trocada = false;

// Estética Aero
cor_vidro = make_color_rgb(100, 200, 255);
cor_brilho = c_white;

// Lista de falas (Charlotte desafiando para Drift)
falas = ds_list_create();
ds_list_add(falas, "vc; eu vim te desafiar");
ds_list_add(falas, "RVL; Charlotte... voce nao e boa no drift");
ds_list_add(falas, "vc; vai aceitar ou nao?");
ds_list_add(falas, "RVL; nao diga que eu nao avisei");

// Pausa gameplay
global.dialogo_ativo = true;
texto = "";
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// --- Lógica de Sistema (DS List) ---

if (dialogo_ativo) {

    if (fala_atual < ds_list_size(falas)) {
        texto = ds_list_find_value(falas, fala_atual);

        // Digitação
        if (caracteres_mostrados < string_length(texto)) {
            contador += 1;
            if (contador >= velocidade_letra) {
                caracteres_mostrados += 1;
                contador = 0;
            }
        } else {
            // Avança fala
            if (keyboard_check_pressed(vk_anykey) || mouse_check_button_pressed(mb_left)) {
                fala_atual += 1;
                caracteres_mostrados = 0;
                contador = 0;
            }
        }
    } else {
        // Fim do diálogo -> Transição para a corrida
        if (!room_trocada) {
            room_trocada = true;
            global.dialogo_ativo = false;
            room_goto(monte_silesia_RVL);
        }
    }
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=211
invert=0
arg0=dialogo com os corredores
arg1=1
*/
#define Other_5
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=212
invert=0
arg0=dialogo com os corredores
*/
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// --- Draw Estilo Frutiger Aero (Monte Silesia) ---

draw_self(); // Desenha o objeto no cenário (ex: o carro ou o NPC)

if (dialogo_ativo && fala_atual < ds_list_size(falas)) {
    var vx, vy, vw, vh, dy, dh;
    vx = view_xview[0]; vy = view_yview[0];
    vw = view_wview[0]; vh = view_hview[0];
    dh = 100;
    dy = vy + vh - dh - 20;

    // --- Portrait Charlotte (Apenas se for a tag vc;) ---
    if (string_pos("vc;", texto) > 0) {
        var py;
        py = dy - sprite_get_height(spr_portrait_charlotte);
        draw_sprite_ext(spr_portrait_charlotte, 0, vx + 50, py, 1, 1, 0, c_white, 1);
    }

    // --- Caixa Glass Aero ---
    draw_set_alpha(0.7);
    draw_roundrect_color(vx+30, dy, vx+vw-30, dy+dh, cor_vidro, c_white, false);

    // Efeito Glossy (Brilho superior)
    draw_set_alpha(0.4);
    draw_ellipse_color(vx+60, dy+5, vx+vw-60, dy+dh/2, c_white, cor_vidro, false);

    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_roundrect(vx+30, dy, vx+vw-30, dy+dh, true);

    // --- Texto Limpo ---
    draw_set_color(c_black);
    var t_vis;
    t_vis = string_replace(texto, "vc;", "");
    t_vis = string_replace(t_vis, "RVL;", "");

    draw_text_ext(vx+60, dy+25, string_copy(t_vis, 1, caracteres_mostrados), 20, vw-140);

    // Indicador de "Aperte para continuar" (Seta Aero)
    if (caracteres_mostrados >= string_length(texto)) {
        draw_set_color(cor_vidro);
        draw_text(vx+vw-100, dy+dh-25, "NEXT >");
    }
}
