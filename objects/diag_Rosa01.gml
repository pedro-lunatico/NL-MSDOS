#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// --- Inicialização Aero (Rosa & Charlotte) ---

dialogo_ativo = true;
fala_atual = 0;
caracteres = 0;
contador = 0;
velocidade = 2;
fase = 0;
opcao_escolhida = 0;

// Configurações Visuais Aero
cor_vidro = make_color_rgb(100, 200, 255); // Ciano Aero
cor_brilho = c_white;

// --- Diálogos Rosa/Charlotte ---
fala0 = "Rosa:oi Charlotte";
fala1 = "vc; o que e Respondo?";

fala1_0 = "vc;como anda os seus filhos?";
fala1_1 = "Rosa; bem eles comecaram o semestre na faculdade";
fala1_2 = "Rosa; Osian esta fazendo Biologia ea Dawn esta fazendo Quimica";

fala2_0 = "vc; oque voce esta fazendo?";
fala2_1 = "Rosa; usando edicao genetica para criar o projecto NX";
fala2_2 = "vc;o mas o ultimo projecto nao era o suficiente?";
fala2_3 = "Rosa;Claro que nao eu quero mais controle algo";
fala2_4 = "Rosa;mas exato nao querendo ser desrespeitosa com voce mas....";
fala2_5 = "Rosa;controle e a algo que nossa ciencia precisa";

fala3_0 = "vc;ate mais senhorita Conote";
fala3_1 = "Rosa;que Lindo Charlotte voce reconhece meu casamento diferente da Miku";
fala3_2 = "vc;nao liga pra isso a Miku so esta com ciumes, ate mais";

max_falas_opcao1 = 3;
max_falas_opcao2 = 6;
max_falas_opcao3 = 3;

texto = "";
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// --- Lógica de Progressão ---

if (dialogo_ativo) {
    // Definição do texto por fase
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
            if (keyboard_check_pressed(vk_anykey)) {
                fala_atual += 1;
                caracteres = 0;
                contador = 0;
            }
        }
    }

    // Terminar diálogos
    if (fase == 2) {
        var m_fala;
        if (opcao_escolhida == 1) m_fala = max_falas_opcao1;
        if (opcao_escolhida == 2) m_fala = max_falas_opcao2;
        if (opcao_escolhida == 3) m_fala = max_falas_opcao3;

        if (fala_atual >= m_fala) {
            if (opcao_escolhida == 3) {
                global.next_x = 360; global.next_y = 232;
                room_goto(Fergus_Interior);
            } else {
                fase = 0; fala_atual = 0; caracteres = 0;
                opcao_escolhida = 0; texto = ""; dialogo_ativo = false;
            }
        }
    }
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=211
invert=0
arg0=The Dimensional Girl
arg1=1
*/
#define Other_5
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=212
invert=0
arg0=The Dimensional Girl
*/
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// --- Draw Estilo Frutiger Aero (Sem Portrait Rosa) ---

if (dialogo_ativo) {
    var vx, vy, vw, vh, dy, dh;
    vx = view_xview[0]; vy = view_yview[0];
    vw = view_wview[0]; vh = view_hview[0];
    dh = 120;
    dy = vy + vh - dh - 20;

    // --- Portrait da Charlotte (Apenas quando ela fala) ---
    if (string_pos("vc;", texto) > 0 && fase != 1) {
        var py;
        py = dy - sprite_get_height(spr_portrait_charlotte);
        draw_sprite_ext(spr_portrait_charlotte, 0, vx + 50, py, 1, 1, 0, c_white, 1);
    }

    // --- Caixa Glass Aero ---
    draw_set_alpha(0.7);
    draw_roundrect_color(vx+30, dy, vx+vw-30, dy+dh, cor_vidro, c_white, false);

    draw_set_alpha(0.4); // Brilho Glossy
    draw_ellipse_color(vx+60, dy+5, vx+vw-60, dy+dh/2, c_white, cor_vidro, false);

    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_roundrect(vx+30, dy, vx+vw-30, dy+dh, true);

    // --- Texto Limpo ---
    draw_set_color(c_black);
    var t_vis;
    t_vis = string_replace(texto, "vc;", "");
    t_vis = string_replace(t_vis, "Rosa;", "");
    t_vis = string_replace(t_vis, "Rosa:", "");
    draw_text_ext(vx+60, dy+30, string_copy(t_vis, 1, caracteres), 22, vw-140);

    // --- Menu de Opções ---
    if (fase == 1) {
        var i;
        for (i=0; i<3; i+=1) {
            var bx1, by1, bx2, by2, txt;
            bx1 = vx + 70; bx2 = vx + 550;
            by1 = vy + vh - 150 + (i * 35); by2 = by1 + 30;

            if (i == 0) txt = "1) perguntar dos filhos";
            if (i == 1) txt = "2) perguntar oque voce esta fazendo";
            if (i == 2) txt = "3) ir embora";

            if (mouse_x > bx1 && mouse_x < bx2 && mouse_y > by1 && mouse_y < by2) {
                draw_set_alpha(0.9);
                draw_roundrect_color(bx1, by1, bx2, by2, cor_vidro, c_white, false);
                draw_set_color(c_black);
                if (mouse_check_button_pressed(mb_left)) {
                    opcao_escolhida = i + 1;
                    fase = 2; fala_atual = 0; caracteres = 0;
                }
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
