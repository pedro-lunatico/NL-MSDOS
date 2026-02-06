#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// CREATE EVENT - Rosa (UI identica ao Fergus)

scr_Rosa_Dialogos(); // carrega global.c_respostas e global.r_respostas

dialogo_ativo = true;

fase = 0; // 0 intro | 1 opcoes | 2 resposta | 3 encerra
caracteres = 0;
velocidade = 2;
contador = 0;

texto = "";
texto_exibir = "Rosa; Voce veio ate aqui sem avisar. Isso e coragem ou curiosidade?";

opcao_sel = 0;
texto_escolhido = "";

tempo_limite = 330;
timer_paciencia = 0;
nivel_incomodo = 0;

// estetica AERO (igual Fergus)
cor_vidro = make_color_rgb(100, 200, 255);

// lista de opcoes sorteadas
opcoes_da_vez = ds_list_create();
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!dialogo_ativo) exit;

var interacao;
interacao = mouse_check_button_pressed(mb_left) || keyboard_check_pressed(vk_anykey);

/// ===============================
/// FASE 0 - INTRO
/// ===============================
if (fase == 0) {

    texto = texto_exibir;

    if (interacao) {
        if (caracteres < string_length(texto)) {
            caracteres = string_length(texto);
        } else {
            fase = 1;
            caracteres = 0;
            timer_paciencia = 0;
        }
    }
}

/// ===============================
/// FASE 1 - OPCOES + PACIENCIA
/// ===============================
else if (fase == 1) {

    // sorteio das opcoes (inalterado)
    if (ds_list_empty(opcoes_da_vez)) {

        var tmp, i;
        tmp = ds_list_create();
        ds_list_copy(tmp, global.c_respostas);

        repeat (3) {
            if (ds_list_size(tmp) > 0) {
                i = irandom(ds_list_size(tmp) - 1);
                ds_list_add(opcoes_da_vez, ds_list_find_value(tmp, i));
                ds_list_delete(tmp, i);
            }
        }

        ds_list_destroy(tmp);
        timer_paciencia = 0; // reset do tempo
    }

    // contagem da paciencia
    timer_paciencia += 1;

    // tempo esgotado
    if (timer_paciencia >= tempo_limite) {

        texto = "Rosa; Eu nao tenho tempo para isso agora.";
        fase = 3;
        caracteres = 0;

        ds_list_clear(opcoes_da_vez);
    }
}

/// ===============================
/// FASE 2 - RESPOSTA DA ROSA
/// ===============================
else if (fase == 2) {

    if (caracteres == 0 && texto == "") {

        var i, s, chave;
        chave = string_copy(
            texto_escolhido,
            1,
            string_pos("|", texto_escolhido) - 1
        );

        for (i = 0; i < ds_list_size(global.r_respostas); i += 1) {
            s = ds_list_find_value(global.r_respostas, i);
            if (string_pos(chave, s) > 0) {
                texto = s;
                break;
            }
        }
    }

    if (interacao) {
        if (caracteres < string_length(texto)) {
            caracteres = string_length(texto);
        } else {
            texto = "";
            fase = 1;
            caracteres = 0;
            ds_list_clear(opcoes_da_vez);
        }
    }
}

/// ===============================
/// FASE 3 - ENCERRAMENTO
/// ===============================
else if (fase == 3) {

    if (interacao && caracteres < string_length(texto)) {
        caracteres = string_length(texto);
    }

    if (interacao && caracteres >= string_length(texto)) {
        dialogo_ativo = false;
    }
}

/// ===============================
/// TYPEWRITER
/// ===============================
if (fase != 1 && caracteres < string_length(texto)) {

    contador += 1;

    if (contador >= velocidade) {
        caracteres += 1;
        contador = 0;
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
