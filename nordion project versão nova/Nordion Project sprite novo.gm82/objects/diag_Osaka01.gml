#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// --- Inicialização Aero (Osaka & Charlotte) ---

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
fala0 = "osaka:oi red head";
fala1 = "vc; oi osaka";

// Opção 1: Rosa
fala1_0 = "vc;onde esta a Rosa?";
fala1_1 = "osaka;esta na primeira porta ao meu lado";
fala1_2 = "vc;obrigada";

// Opção 2: Cthulhu chan e o Cabelo
fala2_0 = "vc; onde esta o seu amigo???";
fala2_1 = "osaka; Cthulhu chan esta meio ocupado agora";
fala2_2 = "osaka; seu cabelo esta pegando fogo???";
fala2_3 = "vc;nao e porque eu sou ruiva que eu estou pegando fogo";
fala2_4 = "osaka; mas ele cresce quando voce fica irritada";
fala2_5 = "vc; eu prometi a minha mae que eu nao ia me transformar denovo";

// Opção 3
fala3_0 = "vc;ate mais osaka";
fala3_1 = "osaka;isso e um lapis?";

max_falas_opcao1 = 3;
max_falas_opcao2 = 6;
max_falas_opcao3 = 2;

texto = "";
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// --- Lógica de Sistema ---

if (dialogo_ativo) {
    // Definindo o texto
    if (fase == 0) {
        if (fala_atual == 0) texto = fala0;
        if (fala_atual == 1) texto = fala1;
        if (fala_atual == 2) fase = 1;
    }
    else if (fase == 2) {
        if (opcao_escolhida == 1) {
            if (fala_atual == 0) texto = fala1_0;
            if (fala_atual == 1) texto = fala1_1;
            if (fala_atual == 2) texto = fala1_2;
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

    // Digitação
    if (caracteres < string_length(texto) && fase != 1) {
        contador += 1;
        if (contador >= velocidade) {
            caracteres += 1;
            contador = 0;
        }
    }
    else if (fase != 1) {
        if (caracteres >= string_length(texto)) {
            if (keyboard_check_pressed(vk_anykey) || mouse_check_button_pressed(mb_left)) {
                fala_atual += 1;
                caracteres = 0;
                contador = 0;
            }
        }
    }

    // Terminar
    if (fase == 2) {
        var m_fala;
        if (opcao_escolhida == 1) m_fala = max_falas_opcao1;
        if (opcao_escolhida == 2) m_fala = max_falas_opcao2;
        if (opcao_escolhida == 3) m_fala = max_falas_opcao3;

        if (fala_atual >= m_fala) {
            if (opcao_escolhida == 3) {
                global.next_x = 112; global.next_y = 264;
                room_goto(Fergus_Interior);
            } else {
                fase = 0; fala_atual = 0; caracteres = 0;
                opcao_escolhida = 0; texto = ""; dialogo_ativo = false;
            }
        }
    }

    // Escolhas
    if (fase == 1 && mouse_check_button_pressed(mb_left)) {
        var vx, vy, vh;
        vx = view_xview[0]; vy = view_yview[0]; vh = view_hview[0];
        if (mouse_x > vx+70 && mouse_x < vx+550 && mouse_y > vy+vh-150 && mouse_y < vy+vh-120) {
            opcao_escolhida = 1; fase = 2; fala_atual = 0; caracteres = 0;
        }
        if (mouse_x > vx+70 && mouse_x < vx+550 && mouse_y > vy+vh-115 && mouse_y < vy+vh-85) {
            opcao_escolhida = 2; fase = 2; fala_atual = 0; caracteres = 0;
        }
        if (mouse_x > vx+70 && mouse_x < vx+550 && mouse_y > vy+vh-80 && mouse_y < vy+vh-50) {
            opcao_escolhida = 3; fase = 2; fala_atual = 0; caracteres = 0;
            global.next_x = 112; global.next_y = 264;
            room_goto(Fergus_Interior);
        }
    }
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=211
invert=0
arg0=a GOD of Secretary
arg1=1
*/
#define Other_5
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=212
invert=0
arg0=a GOD of Secretary
*/
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// --- Draw Estilo Frutiger Aero (Osaka & Charlotte) ---

if (dialogo_ativo) {
    var vx, vy, vw, vh, dy, dh;
    vx = view_xview[0]; vy = view_yview[0];
    vw = view_wview[0]; vh = view_hview[0];
    dh = 120;
    dy = vy + vh - dh - 20;

    // Portrait Charlotte (Primeira Pessoa)
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

    // Texto Limpo
    draw_set_color(c_black);
    var t_vis;
    t_vis = string_replace(texto, "vc;", "");
    t_vis = string_replace(t_vis, "osaka;", "");
    t_vis = string_replace(t_vis, "osaka:", "");
    draw_text_ext(vx+60, dy+30, string_copy(t_vis, 1, caracteres), 22, vw-140);

    // Menu de Opções
    if (fase == 1) {
        var i;
        for (i=0; i<3; i+=1) {
            var bx1, by1, bx2, by2, txt;
            bx1 = vx + 70; bx2 = vx + 550;
            by1 = vy + vh - 150 + (i * 35); by2 = by1 + 30;

            if (i == 0) txt = "1) perguntar da Rosa";
            if (i == 1) txt = "2) perguntar do amigo";
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
