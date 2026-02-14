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
tempo_limite = 330; // 10 segundos (se a room for 30fps)
timer_paciencia = 0;
texto_escolhido = "";
t = ""
// Estética Aero
cor_vidro = make_color_rgb(100, 200, 255);
texto_exibir = "Fergus: Ora, se nao e a Tenente de proveta. Veio polir meus terminais ou vai ficar me encarando com esse olhar de cria de becker?";
texto = "";
fase = 0; // Começa na introdução
bg_atual = background7; // BG inicial do laboratório
background_index[0] = bg_atual;

// Lista para armazenar as 3 opções sorteadas da vez
opcoes_da_vez = ds_list_create();
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// --- Lógica de Dating Sim: Reset de Timer e Teleporte ---

if (dialogo_ativo) {

    // Captura interação para pular texto
    var interacao;
    interacao = mouse_check_button_pressed(mb_left) || keyboard_check_pressed(vk_anykey);

    // FASE 0: Introdução
    if (fase == 0) {
        texto = texto_exibir;
        if (interacao) {
            if (caracteres < string_length(texto)) {
                caracteres = string_length(texto);
            } else {
                fase = 1;
                caracteres = 0;
                timer_paciencia = 0; // Inicia o timer do zero
            }
        }
    }

    // FASE 1: Menu de Opções com Sorteio e Timer
    else if (fase == 1) {
        // Sorteia as opções se a lista estiver vazia
        if (ds_list_empty(opcoes_da_vez)) {
            var lista_temp, ind;
            lista_temp = ds_list_create();
            ds_list_copy(lista_temp, global.c_respostas);
            repeat(3) {
                if (ds_list_size(lista_temp) > 0) {
                    ind = irandom(ds_list_size(lista_temp) - 1);
                    ds_list_add(opcoes_da_vez, ds_list_find_value(lista_temp, ind));
                    ds_list_delete(lista_temp, ind);
                }
            }
            ds_list_destroy(lista_temp);
            timer_paciencia = 0; // RESET DO TEMPO ao gerar novas opções
        }

        // Contagem regressiva
        timer_paciencia += 1;

        // SE O TEMPO ACABAR: Teleporta para a room "Fergus"
        if (timer_paciencia >= tempo_limite) {
            ds_list_clear(opcoes_da_vez);
            room_goto(Fergus);
        }
    }

    // FASE 2: Resposta e Tréplica
    else if (fase == 2) {
        if (caracteres == 0) {
            var tema;
            if (string_pos("Dawn", texto_escolhido) > 0) { tema = "FILHOS"; background_index[0] = background57; }
            else if (string_pos("Pangeia", texto_escolhido) > 0) { tema = "GEO"; background_index[0] = background59; }
            else { tema = "LYN"; background_index[0] = background58; }

            if (raiva_nivel >= 2) {
                texto = "Fergus; E-espere... Charlotte, controle sua endocrinologia! Mantenha a calma!";
            } else {
                var lf, i, s; lf = ds_list_create();
                for (i=0; i<ds_list_size(global.f_falas); i+=1) {
                    s = ds_list_find_value(global.f_falas, i);
                    if (string_pos(tema, s) > 0) ds_list_add(lf, s);
                }
                if (ds_list_size(lf) > 0) texto = ds_list_find_value(lf, irandom(ds_list_size(lf)-1));
                ds_list_destroy(lf);
            }
        }

        if (interacao) {
            if (caracteres < string_length(texto)) {
                caracteres = string_length(texto);
            } else {
                if (string_pos("LYN", texto_escolhido) > 0) raiva_nivel += 1;

                if (raiva_nivel >= 3) {
                    fase = 3; timer_berserk = 0; caracteres = 0;
                } else {
                    fase = 1;
                    caracteres = 0;
                    ds_list_clear(opcoes_da_vez); // Limpa para resetar o timer no próximo frame
                }
            }
        }
    }

    // FASE 3: BERSERK
    else if (fase == 3) {
        if (caracteres == 0) texto = "Charlotte; Eu vou te mostrar quem é rascunho!";

        if (interacao && caracteres < string_length(texto)) {
            caracteres = string_length(texto);
        }

        timer_berserk += 1;
        view_xview[0] += random_range(-10, 10);
        view_yview[0] += random_range(-10, 10);

        if (timer_berserk > 180) room_goto(Fergus_Fuga);
    }

    // Efeito Typewriter
    if (fase != 1 && caracteres < string_length(texto)) {
        contador += 1;
        if (contador >= velocidade) { caracteres += 1; contador = 0; }
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
/// ===============================
/// DRAW EVENT - ROSA (AERO + PACIENCIA)
/// ===============================

if (!dialogo_ativo) exit;

// -----------------------------
// BASE DA VIEW
// -----------------------------
var vx, vy, vw, vh, cx, cy;
vx = view_xview[0];
vy = view_yview[0];
vw = view_wview[0];
vh = view_hview[0];

cx = vx + vw / 2;
cy = vy + vh / 2;

// -----------------------------
// CAIXA DE TEXTO
// -----------------------------
var dy, dh;
dh = 120;
dy = vy + vh - dh - 20;

// fundo vidro
draw_set_alpha(0.7);
draw_roundrect_color(
    vx + 40, dy,
    vx + vw - 40, dy + dh,
    cor_vidro, c_white, false
);
draw_set_alpha(1);

// borda
draw_set_color(c_white);
draw_roundrect(
    vx + 40, dy,
    vx + vw - 40, dy + dh,
    true
);

// -----------------------------
// TEXTO COM FILTRO DE KEYWORDS
// -----------------------------
draw_set_font(normal);
draw_set_color(c_black);

if (fase != 1) {

    var t;
    t = string(texto);

    // filtro absoluto
    t = string_replace(t, "Rosa;", "");
    t = string_replace(t, "Charlotte;", "");
    t = string_replace(t, "PASSADO|", "");
    t = string_replace(t, "FERGUS|", "");
    t = string_replace(t, "GUERRA|", "");
    t = string_replace(t, "CHARLOTTE|", "");
    t = string_replace(t, "EVA|", "");
    t = string_replace(t, "WIIU|", "");
    t = string_replace(t, "ITEM_", "");
    t = string_replace(t, "|", "");
    t = string_replace(t, "Fergus;", "");
    t = string_replace(t, "Charlotte;", "");
    t = string_replace(t, "vc;", "");
    t = string_replace(t, "FILHOS|", "");
    t = string_replace(t, "GEO|", "");
    t = string_replace(t, "LYN|", "");
    t = string_replace(t, "WARS|", "");

    draw_text_ext(
        vx + 70,
        dy + 30,
        string_copy(t, 1, caracteres),
        20,
        vw - 140
    );
}

// -----------------------------
// MENU DE OPCOES CENTRALIZADO
// -----------------------------
if (fase == 1) {

    var i;
    var largura_caixa, altura_caixa;
    var bx1, by1, bx2, by2;
    var txt_op;

    largura_caixa = 440;
    altura_caixa = 24;

    for (i = 0; i < ds_list_size(opcoes_da_vez); i += 1) {

        bx1 = cx - (largura_caixa / 2);
        by1 = cy - (ds_list_size(opcoes_da_vez) * altura_caixa / 2)
              + (i * (altura_caixa + 6));
        bx2 = bx1 + largura_caixa;
        by2 = by1 + altura_caixa;

        txt_op = ds_list_find_value(opcoes_da_vez, i);
        txt_op = string_copy(
            txt_op,
            string_pos("|", txt_op) + 1,
            string_length(txt_op)
        );

        if (
            mouse_x > bx1 && mouse_x < bx2 &&
            mouse_y > by1 && mouse_y < by2
        ) {

            draw_set_alpha(0.9);
            draw_roundrect_color(
                bx1, by1, bx2, by2,
                cor_vidro, c_white, false
            );

            if (mouse_check_button_pressed(mb_left)) {
                texto_escolhido = ds_list_find_value(opcoes_da_vez, i);
                fase = 2;
                caracteres = 0;
            }

        } else {

            draw_set_alpha(0.6);
            draw_roundrect_color(
                bx1, by1, bx2, by2,
                c_white, cor_vidro, false
            );
        }

        draw_set_alpha(1);
        draw_set_color(c_black);
        draw_text_ext(
            bx1 + 12,
            by1 + 5,
            txt_op,
            16,
            largura_caixa - 24
        );
    }

    // -----------------------------
    // BARRA DE PACIENCIA (IGUAL FERGUS)
    // -----------------------------
    var bw;
    bw = (1 - (timer_paciencia / tempo_limite)) * 440;

    draw_set_color(c_white);
    draw_rectangle(
        cx - 220,
        cy + (ds_list_size(opcoes_da_vez) * altura_caixa / 2) + 18,
        (cx - 220) + bw,
        cy + (ds_list_size(opcoes_da_vez) * altura_caixa / 2) + 24,
        false
    );
}

draw_set_alpha(1);
