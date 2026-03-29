#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// --- Inicialização Aero (Colton & Charlotte) ---

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
fala0 = "Colton;como vai Charlotte?";
fala1 = "vc; oi Colton......";
fala2 = "vc; o que eu pergunto?";

// Opção 1: Idade/Laboratório
fala1_0 = "vc;voce nao e jovem demais para ter seu proprio laboratorio?";
fala1_1 = "Colton;eu sou o Herdeiro das industrias de noobfield";
fala1_2 = "Colton;que se localizava no polo industrial de unova lands";
fala1_3 = "vc;entao voce e herdeiro do polo industrial que";
fala1_4 = "vc;Nordion Lands criou apos a criacao da ENGAGE?";
fala1_5 = "Colton;exatamente";

// Opção 2: O que está fazendo
fala2_0 = "vc;oque voce esta fazendo?";
fala2_1 = "Colton;projetando um commandblock com ia com machine learn verdadeira";
fala2_2 = "vc;machine learn???? maquinas podem aprender???";
fala2_3 = "Colton;nao como os humanos..... a menos que voce";
fala2_4 = "Colton;esteja usando um computador neural..... mas basicamente computadores";
fala2_5 = "Colton;aprendem testado oque diversas vezes uma determinda acao";
fala2_6 = "vc;mas vem ca........";
fala2_7 = "vc;voce esta programando em pe????";
fala2_8 = "Colton;Claro!!!!! para programar voce tenque pensar";
fala2_9 = "Colton;na mecanica.... nao e apenas colocar um monte de codigo aleatorio";

// Opção 3
fala3_0 = "vc;vou indo garoto ve se corrije os bugs do MikuOffice isso me tira do serio";
fala3_1 = "Colton;isso e mole pra mim, e tipo tirar doce de crianca";
fala3_2 = "vc;olha se voce quer ser um cientista respeitado se espelha na Rosa,o Fergus nao e um bosta";

max_falas_opcao1 = 6;
max_falas_opcao2 = 10;
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
    // Seleção de Texto
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
            if (fala_atual == 4) texto = fala1_4;
            if (fala_atual == 5) texto = fala1_5;
        }
        if (opcao_escolhida == 2) {
            var f; f = fala_atual;
            if (f == 0) texto = fala2_0; if (f == 1) texto = fala2_1;
            if (f == 2) texto = fala2_2; if (f == 3) texto = fala2_3;
            if (f == 4) texto = fala2_4; if (f == 5) texto = fala2_5;
            if (f == 6) texto = fala2_6; if (f == 7) texto = fala2_7;
            if (f == 8) texto = fala2_8; if (f == 9) texto = fala2_9;
        }
        if (opcao_escolhida == 3) {
            if (fala_atual == 0) texto = fala3_0;
            if (fala_atual == 1) texto = fala3_1;
        }
    }

    // Digitação letra a letra
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

    // Finais de Diálogo
    if (fase == 2) {
        var m_fala;
        if (opcao_escolhida == 1) m_fala = max_falas_opcao1;
        if (opcao_escolhida == 2) m_fala = max_falas_opcao2;
        if (opcao_escolhida == 3) m_fala = max_falas_opcao3;

        if (fala_atual >= m_fala) {
            if (opcao_escolhida == 3) {
                room_goto(Noobfield_Labs);
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
            opcao_escolhida = 1; fase = 2; fala_atual = 0; caracteres = 0;
        }
        if (mouse_x > vx+70 && mouse_x < vx+550 && mouse_y > vy+vh-115 && mouse_y < vy+vh-85) {
            opcao_escolhida = 2; fase = 2; fala_atual = 0; caracteres = 0;
        }
        if (mouse_x > vx+70 && mouse_x < vx+550 && mouse_y > vy+vh-80 && mouse_y < vy+vh-50) {
            room_goto(Noobfield_Labs);
        }
    }
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=211
invert=0
arg0=A Code Guy
arg1=1
*/
#define Other_5
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=212
invert=0
arg0=A Code Guy
*/
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (dialogo_ativo) {
    x0 = 50;
    y0 = room_height - 180;
    largura = room_width - 100;
    altura = 100;

    // Balão bege
    draw_set_color(make_color_rgb(245,245,200));
    draw_roundrect(x0, y0, x0+largura, y0+altura, false);

    draw_set_color(c_black);
    draw_text_ext(x0+10, y0+10, string_copy(texto,1,caracteres), largura-20, -1);

    // Se estiver na fase de escolha, desenha opções
    if (fase == 1) {
        // Opção 1
        draw_set_color(make_color_rgb(100,100,100));
        draw_roundrect(70, room_height-150, 550, room_height-120, false);
        draw_set_color(c_white);
        draw_text(80, room_height-145, "1) perguntar da idade");

        // Opção 2
        draw_set_color(make_color_rgb(100,100,100));
        draw_roundrect(70, room_height-115, 550, room_height-85, false);
        draw_set_color(c_white);
        draw_text(80, room_height-110, "2)  perguntar oque esta fazendo");

        // Opção 3
        draw_set_color(make_color_rgb(100,100,100));
        draw_roundrect(70, room_height-80, 550, room_height-50, false);
        draw_set_color(c_white);
        draw_text(80, room_height-75, "3) ir embora");
    }
}
