#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// --- Inicialização Fergus (O Satânico de Nordion) ---

scr_Fergus_Dialogos(); // Carrega a lista global.f_falas com os 45+ diálogos

dialogo_ativo = true;
fase = 0; // 0: Intro, 1: Escolha, 2: Resposta, 3: Berserk
caracteres = 0;
velocidade = 2;
raiva_nivel = 0;
opcao_sel = 0;
texto = "";
contador = 0;
// Estética Aero
cor_vidro = make_color_rgb(100, 200, 255);
texto_exibir = "Fergus: Ora, se não é a Tenente de proveta. Veio polir meus terminais ou vai ficar me encarando com esse olhar de rascunho?";
texto = "";
fase = 0; // Começa na introdução
bg_atual = background7; // BG inicial do laboratório
background_index[0] = bg_atual;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// --- Lógica de Dating Sim & Geopolítica ---

if (dialogo_ativo) {

    // FASE 0: Introdução Sádica do Fergus
    if (fase == 0) {
        texto = texto_exibir;
        if (caracteres >= string_length(texto) && (keyboard_check_pressed(vk_anykey) || mouse_check_button_pressed(mb_left))) {
            fase = 1; // Abre o balão de escolhas
            caracteres = 0;
        }
    }

    // FASE 2: Resposta e Tréplica
    else if (fase == 2) {
        if (caracteres == 0) {
            var tema;
            if (opcao_escolhida == 1) { tema = "FILHOS"; background_index[0] = background7; }
            if (opcao_escolhida == 2) { tema = "GEO";    background_index[0] = background57; }
            if (opcao_escolhida == 3) { tema = "LYN";    background_index[0] = background58; }

            // Sorteia um diálogo do Fergus baseado no tema escolhido
            var lista_temp, i, s;
            lista_temp = ds_list_create();
            for (i=0; i<ds_list_size(global.f_falas); i+=1) {
                s = ds_list_find_value(global.f_falas, i);
                if (string_pos(tema, s) > 0) ds_list_add(lista_temp, s);
            }
            texto = ds_list_find_value(lista_temp, irandom(ds_list_size(lista_temp)-1));
            ds_list_destroy(lista_temp);
        }

        // Avançar após a resposta
        if (caracteres >= string_length(texto) && (keyboard_check_pressed(vk_anykey) || mouse_check_button_pressed(mb_left))) {
            if (opcao_escolhida == 3) raiva_nivel += 1;

            if (raiva_nivel >= 3) {
                fase = 3; // Berserk!
            } else {
                fase = 1; // Volta para o balão de escolhas
                caracteres = 0;
            }
        }
    }

    // Mecanismo de Digitação (Typewriter)
    if (fase != 1 && caracteres < string_length(texto)) {
        contador += 1;
        if (contador >= velocidade) {
            caracteres += 1;
            contador = 0;
        }
    }
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=211
invert=0
arg0=The Conote Empire
arg1=1
*/
#define Other_5
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=212
invert=0
arg0=The Conote Empire
*/
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// --- Draw Estilo Dating Sim Nordion ---

if (dialogo_ativo) {
    var vx, vy, vw, vh, dy, dh, cx, cy;
    vx = view_xview[0]; vy = view_yview[0];
    vw = view_wview[0]; vh = view_hview[0];
    cx = vx + vw/2; cy = vy + vh/2;
    dh = 120; dy = vy + vh - dh - 20;

    // --- LOGICA DE COR (Substituindo o ?) ---
    var cor_fundo;
    if (raiva_nivel >= 2) {
        cor_fundo = make_color_rgb(255, 100, 100); // Vermelho Alerta
    } else {
        cor_fundo = cor_vidro; // Ciano Aero
    }

    // --- CAIXA DE TEXTO (Aero Glass) ---
    draw_set_alpha(0.7);
    draw_roundrect_color(vx+40, dy, vx+vw-40, dy+dh, cor_fundo, c_white, false);

    draw_set_alpha(0.3); // Brilho Glossy
    draw_ellipse_color(vx+100, dy+5, vx+vw-100, dy+dh/2, c_white, cor_fundo, false);

    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_roundrect(vx+40, dy, vx+vw-40, dy+dh, true);

    // --- EXIBIÇÃO DO TEXTO ---
    draw_set_font(normal)
    draw_set_color(c_black);
    if (fase != 1) {
        var t_vis;
        t_vis = string_replace(texto, "Fergus;", "");
        t_vis = string_replace(t_vis, "FILHOS|", "");
        t_vis = string_replace(t_vis, "GEO|", "");
        t_vis = string_replace(t_vis, "LYN|", "");
        t_vis = string_replace(t_vis, "WARS|", "");

        draw_text_ext(vx+70, dy+30, string_copy(t_vis, 1, caracteres), 20, vw-140);
    }

    // --- BALÃO DE OPÇÕES (Fase 1) ---
    if (fase == 1) {
        var i, bx1, by1, bx2, by2, txt_op;
        for (i=0; i<3; i+=1) {
            bx1 = cx - 220; bx2 = cx + 220;
            by1 = cy - 60 + (i * 45); by2 = by1 + 35;

            txt_op = ds_list_find_value(global.c_respostas, i);
            txt_op = string_replace(txt_op, "vc;", "");

            // Hover do Mouse (Colisao Simples GM8)
            if (mouse_x > bx1 && mouse_x < bx2 && mouse_y > by1 && mouse_y < by2) {
                draw_set_alpha(0.9);
                draw_roundrect_color(bx1, by1, bx2, by2, cor_vidro, c_white, false);
                if (mouse_check_button_pressed(mb_left)) {
                    opcao_escolhida = i + 1;
                    fase = 2;
                    caracteres = 0;
                }
            } else {
                draw_set_alpha(0.6);
                draw_roundrect_color(bx1, by1, bx2, by2, c_white, cor_vidro, false);
            }
            draw_set_alpha(1);
            draw_set_color(c_black);
            draw_text_ext(bx1 + 10, by1 + 5, txt_op, 14, 420);
        }
    }
}

// --- EFEITO BERSERK ---
if (fase == 3) {
    draw_set_alpha(0.5); draw_set_color(c_maroon);
    draw_rectangle(vx, vy, vx+vw, vy+vh, false);
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_text(cx - 100, cy, "ERRO: INSTABILIDADE GENETICA");
    // Shake de tela simples
    view_xview[0] += random_range(-5, 5);
    view_yview[0] += random_range(-5, 5);
}
