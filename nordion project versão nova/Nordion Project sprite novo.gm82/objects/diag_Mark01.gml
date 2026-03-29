#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// --- Inicialização Aero (Mark & Charlotte) ---

dialogo_ativo = true;
fala_atual = 0;
caracteres = 0;
contador = 0;
velocidade = 2;
fase = 0; // 0 = normal, 1 = escolha, 2 = pós-escolha
opcao_escolhida = 0;

// Estética Aero
cor_vidro = make_color_rgb(100, 200, 255);
cor_brilho = c_white;

// --- Diálogos ---
fala0 = "mark:oi Filhona";
fala1 = "vc; oi pai";
fala2 = "vc; o que e Respondo?";

// Opção 1
fala1_0 = "vc;como anda a vida?";
fala1_1 = "mark; as coisas estao calmas.....";
fala1_2 = "mark; tipo uma base militar sem o perigo eminente de uma guerra e bizarro";
fala1_3 = "mark; e tipo voce estar num lugar bem movimentado mas so tem voce";

// Opção 2
fala2_0 = "vc;que chaves sao essa?";
fala2_1 = "mark; sao do meu novo briquidinho!!!";
fala2_2 = "mark; filhona eu comprei um azathoth Skywalk";
fala2_3 = "vc;pai!!!!!!!!";
fala2_4 = "vc;nosso salario e bem precario";
fala2_5 = "mark; fica tranquila!!!!! eu parcelei em 32 prestações";

// Opção 3
fala3_0 = "vc;ate mais pai";
fala3_1 = "mark;por favor sao se esforce filha";
fala3_2 = "vc;eu sei o berserk mode destroi meu corpo eu to ligada nisso";

max_falas_opcao1 = 4;
max_falas_opcao2 = 6;
max_falas_opcao3 = 3;

texto = "";
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// --- Lógica de Sistema ---

if (dialogo_ativo) {

    // --- Seleção de Texto ---
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
            if (fala_atual == 3) texto = fala1_3;
        }
        if (opcao_escolhida == 2) {
            if (fala_atual == 0) texto = fala2_0;
            if (fala_atual == 1) texto = fala2_1;
            if (fala_atual == 2) texto = fala2_2;
            if (fala_atual == 3) texto = fala2_3;
            if (fala_atual == 4) texto = fala2_4;
            if (fala_atual == 5) texto = fala2_5;
        }
        if (opcao_escolhida == 3) {
            if (fala_atual == 0) texto = fala3_0;
            if (fala_atual == 1) texto = fala3_1;
        }
    }

    // --- Digitação ---
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

    // --- Finais de Diálogo ---
    if (fase == 2) {
        var m_fala;
        if (opcao_escolhida == 1) m_fala = max_falas_opcao1;
        if (opcao_escolhida == 2) m_fala = max_falas_opcao2;
        if (opcao_escolhida == 3) m_fala = max_falas_opcao3;

        if (fala_atual >= m_fala) {
            if (opcao_escolhida == 3) {
                room_goto(ENGAGE_CENTER_ROOM);
            } else {
                fase = 0; fala_atual = 0; caracteres = 0;
                opcao_escolhida = 0; texto = ""; dialogo_ativo = false;
            }
        }
    }

    // --- Clique nas Opções (Fase 1) ---
    if (fase == 1 && mouse_check_button_pressed(mb_left)) {
        var vx, vy, vh;
        vx = view_xview[0]; vy = view_yview[0]; vh = view_vhview[0];

        // Opção 1
        if (mouse_x > vx+70 && mouse_x < vx+550 && mouse_y > vy+vh-150 && mouse_y < vy+vh-120) {
            opcao_escolhida = 1; fase = 2; fala_atual = 0; caracteres = 0;
        }
        // Opção 2
        if (mouse_x > vx+70 && mouse_x < vx+550 && mouse_y > vy+vh-115 && mouse_y < vy+vh-85) {
            opcao_escolhida = 2; fase = 2; fala_atual = 0; caracteres = 0;
        }
        // Opção 3
        if (mouse_x > vx+70 && mouse_x < vx+550 && mouse_y > vy+vh-80 && mouse_y < vy+vh-50) {
            room_goto(ENGAGE_CENTER_ROOM);
        }
    }
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=211
invert=0
arg0=The Father of Fire Head
arg1=1
*/
#define Other_5
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=212
invert=0
arg0=The Father of Fire Head
*/
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// --- Draw Estilo Frutiger Aero (Mark & Charlotte) ---

if (dialogo_ativo) {
    var vx, vy, vw, vh, dy, dh;
    vx = view_xview[0]; vy = view_yview[0];
    vw = view_wview[0]; vh = view_hview[0];
    dh = 120;
    dy = vy + vh - dh - 20;

    // --- Portrait Charlotte (Tag vc;) ---
    if (string_pos("vc;", texto) > 0 && fase != 1) {
        var py;
        py = dy - sprite_get_height(spr_portrait_charlotte);
        draw_sprite_ext(spr_portrait_charlotte, 0, vx + 50, py, 1, 1, 0, c_white, 1);
    }

    // --- Caixa Glass Aero ---
    draw_set_alpha(0.7);
    draw_roundrect_color(vx+30, dy, vx+vw-30, dy+dh, cor_vidro, c_white, false);

    draw_set_alpha(0.4); // Brilho Glossy Superior
    draw_ellipse_color(vx+60, dy+5, vx+vw-60, dy+dh/2, c_white, cor_vidro, false);

    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_roundrect(vx+30, dy, vx+vw-30, dy+dh, true);

    // --- Texto Limpo ---
    draw_set_color(c_black);
    var t_vis;
    t_vis = string_replace(texto, "vc;", "");
    t_vis = string_replace(t_vis, "mark;", "");
    t_vis = string_replace(t_vis, "mark:", "");
    draw_text_ext(vx+60, dy+30, string_copy(t_vis, 1, caracteres), 22, vw-140);

    // --- Menu de Opções ---
    if (fase == 1) {
        var i;
        for (i=0; i<3; i+=1) {
            var bx1, by1, bx2, by2, txt;
            bx1 = vx + 70; bx2 = vx + 550;
            by1 = vy + vh - 150 + (i * 35); by2 = by1 + 30;

            if (i == 0) txt = "1) perguntar da vida";
            if (i == 1) txt = "2) perguntar das chaves";
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
