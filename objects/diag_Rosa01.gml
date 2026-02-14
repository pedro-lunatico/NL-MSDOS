#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// --- Inicialização da Rosa (Nordion Lands) ---
/// GM8.1 SAFE

// 1. Carregar Banco de Dados Externo
scr_Rosa_Dialogos();

// 2. Controle de Fluxo
dialogo_ativo = true;
fase = 0;           // 0: Intro, 1: Escolha, 2: Resposta Rosa, 3: Berserk (EVA)
caracteres = 0;     // Para o efeito typewriter
velocidade = 1;     // Velocidade do texto (menor = mais rapido)
contador = 0;       // Timer interno do typewriter

// 3. Mecanicas de Dating Sim
raiva_nivel = 0;    // Se chegar a 3, entra em modo Berserk
timer_paciencia = 0;
tempo_limite = 300; // Ajuste conforme a sua Room Speed (300 = aprox 10s em 30fps)
texto_escolhido = "";

// 4. Listas de Interface
opcoes_da_vez = ds_list_create();
// global.c_respostas -> Opcoes da Charlotte (carregado no scr_Rosa)
// global.r_respostas -> Respostas da Rosa (carregado no scr_Rosa)
// global.c_falas     -> Micro-conflitos (carregado no scr_Rosa)

// 5. Variaveis de Texto
texto_exibir = "Rosa|Oi Charlotte... o que te traz aqui?"; // Texto inicial
texto = ""; // Onde o texto final processado fica
t = "";     // Buffer para limpeza de tags no Draw

// 6. Estetica Aero / Visual
cor_vidro = make_color_rgb(100, 200, 255);
background_index[0] = background8;

// 7. Flags de Lorca/Djute (Para o script de desconhecidos)
// Isso garante que se voce encontrar a Fir, o sistema saiba quem ela é
if (!variable_global_exists("conhece_fir")) global.conhece_fir = false;
if (!variable_global_exists("fir_nome_real")) global.fir_nome_real = "Desconhecida";

// 8. Timer especifico para o modo Berserk
timer_berserk = 0;

/* DICA: No GM8.1, lembre-se de colocar no Game End ou no
   Destroy Event deste objeto:
   ds_list_destroy(opcoes_da_vez);
*/
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Step Event
if (dialogo_ativo) {

    var interacao;
    interacao = mouse_check_button_pressed(mb_left) || keyboard_check_pressed(vk_anykey);

    // FASE 0: INTRODUCAO
    if (fase == 0) {
        if (caracteres == 0) {
            texto = ds_list_find_value(global.c_falas, irandom(ds_list_size(global.c_falas)-1));
            background_index[0] = background8; // Expressao Neutra
        }
        if (interacao) {
            if (caracteres < string_length(texto)) caracteres = string_length(texto);
            else { fase = 1; caracteres = 0; ds_list_clear(opcoes_da_vez); }
        }
    }

    // FASE 1: MENU DE ESCOLHAS
    else if (fase == 1) {
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
            timer_paciencia = 0;
        }

        timer_paciencia += 1;
        if (timer_paciencia >= tempo_limite) room_goto(Fergus_Interior);

        // Selecao via mouse no Draw ou teclado aqui
        if (keyboard_check_pressed(ord('1'))) { texto_escolhido = ds_list_find_value(opcoes_da_vez, 0); fase = 2; caracteres = 0; }
        if (keyboard_check_pressed(ord('2'))) { texto_escolhido = ds_list_find_value(opcoes_da_vez, 1); fase = 2; caracteres = 0; }
        if (keyboard_check_pressed(ord('3'))) { texto_escolhido = ds_list_find_value(opcoes_da_vez, 2); fase = 2; caracteres = 0; }
    }

    // FASE 2: RESPOSTA E EXPRESSOES
    else if (fase == 2) {
        if (caracteres == 0) {
            var pos_pipe, tag_sel;
            pos_pipe = string_pos("|", texto_escolhido);
            tag_sel = string_copy(texto_escolhido, 1, pos_pipe - 1);

            // LOGICA DE EXPRESSOES DA ROSA
            switch (tag_sel) {
                case "PASSADO":  background_index[0] = background60; break; // Lembranca dolorosa
                case "FERGUS":   background_index[0] = background63; raiva_nivel += 1; break; // Tensao
                case "GUERRA":   background_index[0] = background62; break; // Frieza militar
                case "CHARLOTTE": background_index[0] = background63; break; // Afeto maternal
                case "EVA":      background_index[0] = background65; break; // Medo da arma
                case "WIIU":     background_index[0] = background64; break; // Diversao
                default:         background_index[0] = background8; break;
            }

            // Busca resposta correspondente
            var lf; lf = ds_list_create();
            for (i=0; i<ds_list_size(global.r_respostas); i+=1) {
                var s; s = ds_list_find_value(global.r_respostas, i);
                if (string_pos(tag_sel, s) > 0) ds_list_add(lf, s);
            }
            if (ds_list_size(lf) > 0) texto = ds_list_find_value(lf, irandom(ds_list_size(lf)-1));
            ds_list_destroy(lf);
        }

        if (interacao) {
            if (caracteres < string_length(texto)) caracteres = string_length(texto);
            else {
                if (raiva_nivel >= 3) { fase = 3; timer_berserk = 0; }
                else { fase = 1; ds_list_clear(opcoes_da_vez); caracteres = 0; }
            }
        }
    }

    // FASE 3: BERSERK (INSTABILIDADE)
    else if (fase == 3) {
        if (caracteres == 0) {
            texto = "Rosa|Não!!!! voce nao e assim Charlotte!!!!";
            background_index[0] = bg_Rosa_Panico;
        }
        timer_berserk += 1;
        view_xview[0] = random_range(-8, 8);
        view_yview[0] = random_range(-8, 8);
        if (timer_berserk > 150) room_goto(Fergus_Fuga);
    }

    // TYPEWRITER
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
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
   ds_list_destroy(opcoes_da_vez);
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// DRAW EVENT - ROSA (VERSAO FINAL SEM ERROS)
/// GM8.1 SAFE

if (!dialogo_ativo) exit;

// -----------------------------
// 1. BASE DA VIEW E VARIAVEIS
// -----------------------------
var vx, vy, vw, vh, cx, cy;
vx = view_xview[0];
vy = view_yview[0];
vw = view_wview[0];
vh = view_hview[0];

cx = vx + vw / 2;
cy = vy + vh / 2;

// Declaracao de variaveis de desenho para evitar erros de escopo
var i, largura_caixa, altura_caixa, bx1, by1, bx2, by2, txt_op, offset_menu;
largura_caixa = 440;
altura_caixa = 28;

// -----------------------------
// 2. CAIXA DE TEXTO (Fases 0, 2 e 3)
// -----------------------------
if (fase != 1) {
    var dy, dh;
    dh = 120;
    dy = vy + vh - dh - 20;

    // Fundo Vidro (Aero)
    draw_set_alpha(0.7);
    draw_roundrect_color(vx + 40, dy, vx + vw - 40, dy + dh, cor_vidro, c_white, false);
    draw_set_alpha(1);

    // Borda
    draw_set_color(c_white);
    draw_roundrect(vx + 40, dy, vx + vw - 40, dy + dh, true);

    // Tratamento de Texto
    draw_set_font(normal);
    draw_set_color(c_black);

    var t_draw;
    t_draw = string(texto);

    // Limpeza de Tags Automatica (Pega o que vem depois do |)
    if (string_pos("|", t_draw) > 0) {
        t_draw = string_copy(t_draw, string_pos("|", t_draw) + 1, string_length(t_draw));
    }

    // Fallback para nomes com ponto e virgula (Rosa; Charlotte;)
    t_draw = string_replace(t_draw, "Rosa;", "");
    t_draw = string_replace(t_draw, "Charlotte;", "");
    t_draw = string_replace(t_draw, "Lorca;", "");

    draw_text_ext(vx + 70, dy + 30, string_copy(t_draw, 1, caracteres), 20, vw - 140);
}

// -----------------------------
// 3. MENU DE OPCOES (Fase 1)
// -----------------------------
if (fase == 1) {
    // Calculo do deslocamento vertical para centralizar o bloco de botoes
    offset_menu = (ds_list_size(opcoes_da_vez) * (altura_caixa + 8)) / 2;

    for (i = 0; i < ds_list_size(opcoes_da_vez); i += 1) {
        bx1 = cx - (largura_caixa / 2);
        by1 = cy - offset_menu + (i * (altura_caixa + 8));
        bx2 = bx1 + largura_caixa;
        by2 = by1 + altura_caixa; // Aqui a variavel by2 e definida com seguranca

        // Limpar texto da opcao para o menu
        txt_op = ds_list_find_value(opcoes_da_vez, i);
        if (string_pos("|", txt_op) > 0) {
            txt_op = string_copy(txt_op, string_pos("|", txt_op) + 1, string_length(txt_op));
        }

        // Mouse Over e Selecao
        if (mouse_x > bx1 && mouse_x < bx2 && mouse_y > by1 && mouse_y < by2) {
            draw_set_alpha(0.9);
            draw_roundrect_color(bx1, by1, bx2, by2, cor_vidro, c_white, false);
            draw_set_color(c_white);
            draw_roundrect(bx1, by1, bx2, by2, true);

            if (mouse_check_button_pressed(mb_left)) {
                texto_escolhido = ds_list_find_value(opcoes_da_vez, i);
                fase = 2;
                caracteres = 0;
            }
        } else {
            draw_set_alpha(0.5);
            draw_roundrect_color(bx1, by1, bx2, by2, c_black, cor_vidro, false);
        }

        // Texto do Botao
        draw_set_alpha(1);
        draw_set_color(c_white);
        draw_text(bx1 + 15, by1 + 6, txt_op);
    }

    // -----------------------------
    // 4. BARRA DE PACIENCIA (REVISADA)
    // -----------------------------
    var bw, barra_x, barra_y;
    bw = (1 - (timer_paciencia / tempo_limite)) * largura_caixa;

    barra_x = cx - (largura_caixa / 2);
    // A barra fica 20 pixels abaixo do ultimo botao possivel
    barra_y = cy + offset_menu + 10;

    // Fundo da barra
    draw_set_alpha(0.3);
    draw_set_color(c_black);
    draw_rectangle(barra_x, barra_y, barra_x + largura_caixa, barra_y + 6, false);

    // Preenchimento da barra
    draw_set_alpha(1);
    if (timer_paciencia / tempo_limite > 0.75) draw_set_color(c_red); else draw_set_color(c_aqua);

    draw_rectangle(barra_x, barra_y, barra_x + bw, barra_y + 6, false);
}

draw_set_alpha(1);
