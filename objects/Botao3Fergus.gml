#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
dialogo_ativo = true
fala_atual = 0;
caracteres = 0;
contador = 0;
velocidade = 2;
fase = 0; // 0 = fala normal, 1 = escolha
opcao_escolhida = 0;

// --- Fala inicial ---
fala0 = "esta olhando oque?Falha Genetica?"
fala1 = "vc;oque e Respondo?"

// --- Fala pós escolha 1 ---
fala1_0 = "vc;estou apenas fazendo a ronda"
fala1_1 = "Fergus;acho bom"

// --- Fala pós escolha 2 ---
fala2_0 = "vc;porque voce nao vai cuidar da sua vida?"
fala2_1 = "Fergus;voce esta brincando com o perigo......
cria de becker"

// --- Fala pós escolha 3 ---
fala3_0 = "ê ameaça o viajante!";
fala3_1 = "Ele foge assustado.";

texto = "";
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (dialogo_ativo) {

    // --- Definindo a fala atual ---
    if (fase == 0) {
        if (fala_atual == 0) texto = fala0;
        if (fala_atual == 1) texto = fala1;
        if (fala_atual == 2) texto = fala2;
        if (fala_atual == 3) texto = fala3; // ponto de escolha
    }
    else if (fase == 2) {
        // pós-escolha
        if (opcao_escolhida == 1) {
            if (fala_atual == 0) texto = fala1_0;
            if (fala_atual == 1) texto = fala1_1;
        }
        if (opcao_escolhida == 2) {
            if (fala_atual == 0) texto = fala2_0;
            if (fala_atual == 1) texto = fala2_1;
        }
        if (opcao_escolhida == 3) {
            if (fala_atual == 0) texto = fala3_0;
            if (fala_atual == 1) texto = fala3_1;
        }
    }

    // --- Digitação letra a letra ---
    if (caracteres < string_length(texto) && fase != 1) {
        contador += 1;
        if (contador >= velocidade) {
            caracteres += 1;
            contador = 0;
        }
    } else if (fase != 1) {
        // Avança fala no Z
        if (keyboard_check_pressed(ord("Z"))) {
            fala_atual += 1;

            // Quando chega na fala de escolha
            if (fase == 0 && fala_atual == 4) {
                fase = 1;
            }

            // Quando termina pós-escolha
            if (fase == 2 && fala_atual > 1) {
                dialogo_ativo = false;
            }

            caracteres = 0;
            contador = 0;
        }
    }

    // --- Fase de escolha ---
    if (fase == 1 && mouse_check_button_pressed(mb_left)) {
        // Opção 1
        if (mouse_x > 70 && mouse_x < 550 && mouse_y > room_height-150 && mouse_y < room_height-120) {
            opcao_escolhida = 1;
            fase = 2;
            fala_atual = 0;
            caracteres = 0;
        }

        // Opção 2
        if (mouse_x > 70 && mouse_x < 550 && mouse_y > room_height-115 && mouse_y < room_height-85) {
            opcao_escolhida = 2;
            fase = 2;
            fala_atual = 0;
            caracteres = 0;
        }

        // Opção 3
        if (mouse_x > 70 && mouse_x < 550 && mouse_y > room_height-80 && mouse_y < room_height-50) {
            opcao_escolhida = 3;
            fase = 2;
            fala_atual = 0;
            caracteres = 0;
            room_goto(Fergus)
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
        draw_text(80, room_height-145, "1) responder formalmente")

        // Opção 2
        draw_set_color(make_color_rgb(100,100,100));
        draw_roundrect(70, room_height-115, 550, room_height-85, false);
        draw_set_color(c_white);
        draw_text(80, room_height-110, "2) zombar")

        // Opção 3
        draw_set_color(make_color_rgb(100,100,100));
        draw_roundrect(70, room_height-80, 550, room_height-50, false);
        draw_set_color(c_white);
        draw_text(80, room_height-75, "3) ir embora")
    }
}
