#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// --- Inicialização Aero (Fir, Revolution & Charlotte) ---

dialogo_ativo = true;
fala_atual = 0;
caracteres = 0;
contador = 0;
velocidade = 2;
fase = 0;
opcao_escolhida = 0;

// Estética Aero
cor_vidro = make_color_rgb(100, 200, 255);
cor_brilho = c_white;

// --- Diálogos ---
fala0 = "vc;oi meninas";
fala1 = "Fir & Rev;OOOOIIII!!!!!";

// Opção 1: Charlotte poderosa
fala1_0 = "vc;desculpa incomodar voces";
fala1_1 = "Fir de Lorca;nossa charlotte voce cresceu";
fala1_2 = "Revolution;voce nao viu nada amor...... a charlotte ";
fala1_3 = "Revolution;consegue se transformar e ficar extremamente poderosa";
fala1_4 = "Fir de Lorca;Revolution!!!! voce esta afim de outra????";

// Opção 2: Revolution dona de casa
fala2_0 = "vc; porque a Revolution esta desse jeito?";
fala2_1 = "Revolution; e porque eu sou uma dona de casa agora";
fala2_2 = "Fir de Lorca;fica tranquila ela faz isso porque quer";
fala2_3 = "Fir de Lorca;eu ja tentei varias vezes falar para ela sobre isso";
fala2_4 = "Revolution; poxa amor!!!! eu sou tao feia assim???";
fala2_5 = "vc; tao bonitinha voces duas";

// Opção 3
fala3_0 = "vc;vou deixar voces ai garotas";
fala3_1 = "Revolution;quero ver voce me desafiar algum dia no monte silesia";

max_falas_opcao1 = 5;
max_falas_opcao2 = 6;
max_falas_opcao3 = 2;

texto = "";
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (dialogo_ativo) {
    // Definindo o texto atual
    if (fase == 0) {
        if (fala_atual == 0) texto = fala0;
        if (fala_atual == 1) texto = fala1;
        if (fala_atual == 2) fase = 1;
    }
    else if (fase == 2) {
        if (opcao_escolhida == 1) {
            var f; f = fala_atual;
            if (f == 0) texto = fala1_0; if (f == 1) texto = fala1_1;
            if (f == 2) texto = fala1_2; if (f == 3) texto = fala1_3;
            if (f == 4) texto = fala1_4;
        }
        if (opcao_escolhida == 2) {
            var f; f = fala_atual;
            if (f == 0) texto = fala2_0; if (f == 1) texto = fala2_1;
            if (f == 2) texto = fala2_2; if (f == 3) texto = fala2_3;
            if (f == 4) texto = fala2_4; if (f == 5) texto = fala2_5;
        }
        if (opcao_escolhida == 3) {
            if (fala_atual == 0) texto = fala3_0;
            if (fala_atual == 1) texto = fala3_1;
        }
    }

    // Digitação e Avanço
    if (caracteres < string_length(texto) && fase != 1) {
        contador += 1;
        if (contador >= velocidade) { caracteres += 1; contador = 0; }
    } else if (fase != 1) {
        if (caracteres >= string_length(texto)) {
            if (keyboard_check_pressed(vk_anykey) || mouse_check_button_pressed(mb_left)) {
                fala_atual += 1; caracteres = 0; contador = 0;
            }
        }
    }

    // Finalização e Troca de Sala
    if (fase == 2) {
        var m_fala;
        if (opcao_escolhida == 1) m_fala = max_falas_opcao1;
        if (opcao_escolhida == 2) m_fala = max_falas_opcao2;
        if (opcao_escolhida == 3) m_fala = max_falas_opcao3;

        if (fala_atual >= m_fala) {
            if (opcao_escolhida == 3) {
                global.next_x = 256; global.next_y = 1440;
                room_goto(magvel1);
            } else {
                fase = 0; fala_atual = 0; caracteres = 0;
                opcao_escolhida = 0; texto = ""; dialogo_ativo = false;
            }
        }
    }

    // Clique nas Opções
    if (fase == 1 && mouse_check_button_pressed(mb_left)) {
        var vx, vy, vh;
        vx = view_xview[0]; vy = view_yview[0]; vh = view_hview[0];
        if (mouse_x > vx+70 && mouse_x < vx+550 && mouse_y > vy+vh-150 && mouse_y < vy+vh-120) {
            opcao_escolhida = 1; fase = 2; fala_atual = 0;
        }
        if (mouse_x > vx+70 && mouse_x < vx+550 && mouse_y > vy+vh-115 && mouse_y < vy+vh-85) {
            opcao_escolhida = 2; fase = 2; fala_atual = 0;
        }
        if (mouse_x > vx+70 && mouse_x < vx+550 && mouse_y > vy+vh-80 && mouse_y < vy+vh-50) {
            global.next_x = 256; global.next_y = 1440;
            room_goto(magvel1);
        }
    }
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=211
invert=0
arg0=the Revolution of Fir
arg1=1
*/
#define Other_5
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=212
invert=0
arg0=the Revolution of Fir
*/
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// --- Draw Estilo Frutiger Aero (Fir & Revolution) ---

if (dialogo_ativo) {
    var vx, vy, vw, vh, dy, dh;
    vx = view_xview[0]; vy = view_yview[0];
    vw = view_wview[0]; vh = view_hview[0];
    dh = 120;
    dy = vy + vh - dh - 20;

    // Portrait da Charlotte (Apenas tag vc;)
    if (string_pos("vc;", texto) > 0 && fase != 1) {
        var py;
        py = dy - sprite_get_height(spr_portrait_charlotte);
        draw_sprite_ext(spr_portrait_charlotte, 0, vx + 50, py, 1, 1, 0, c_white, 1);
    }

    // Caixa Glass Aero
    draw_set_alpha(0.7);
    draw_roundrect_color(vx+30, dy, vx+vw-30, dy+dh, cor_vidro, c_white, false);
    draw_set_alpha(0.4);
    draw_ellipse_color(vx+60, dy+5, vx+vw-60, dy+dh/2, c_white, cor_vidro, false);
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_roundrect(vx+30, dy, vx+vw-30, dy+dh, true);

    // Texto Limpo (Remove tags de nomes)
    draw_set_color(c_black);
    var t_vis;
    t_vis = string_replace(texto, "vc;", "");
    t_vis = string_replace(t_vis, "Fir de Lorca;", "");
    t_vis = string_replace(t_vis, "Revolution;", "");
    t_vis = string_replace(t_vis, "Fir & Rev;", "");
    draw_text_ext(vx+60, dy+30, string_copy(t_vis, 1, caracteres), 22, vw-140);

    // Menu de Escolhas
    if (fase == 1) {
        var i;
        for (i=0; i<3; i+=1) {
            var bx1, by1, bx2, by2, txt;
            bx1 = vx + 70; bx2 = vx + 550;
            by1 = vy + vh - 150 + (i * 35); by2 = by1 + 30;

            if (i == 0) txt = "1) desculpa por incomodar";
            if (i == 1) txt = "2) porque a Revolution esta assim?";
            if (i == 2) txt = "3) ir embora";

            if (mouse_x > bx1 && mouse_x < bx2 && mouse_y > by1 && mouse_y < by2) {
                draw_set_alpha(0.9);
                draw_roundrect_color(bx1, by1, bx2, by2, cor_vidro, c_white, false);
                draw_set_color(c_black);
            } else {
                draw_set_alpha(0.6);
                draw_roundrect_color(bx1, by1, bx2, by2, cor_vidro, c_white, false);
                draw_set_color(c_white);
            }
            draw_set_alpha(1);
            draw_text(bx1 + 10, by1 + 5, txt);
        }
    }
}
