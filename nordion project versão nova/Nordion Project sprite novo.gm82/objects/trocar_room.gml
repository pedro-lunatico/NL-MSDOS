#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Tamanho dos botões
botao_w = 220;
botao_h = 50;
botao_radius = 12;

// Posição inicial
botao_x = 200;
botao_y = 150;

// Espaçamento entre os botões
botao_espaco = 70;

// Textos dos botões
botao_textos[0] = "COZINHA";
botao_textos[1] = "SALA";
botao_textos[2] = "QUARTO DO CASAL";
botao_textos[3] = "CHARLOTTE OLD BEDROOM";
botao_textos[4] = "DISPENSA";

// Rooms correspondentes
botao_rooms[0] = Lyn_APTO;
botao_rooms[1] = sala_Lyn_Apto;
botao_rooms[2] = Lyn_bedroom;
botao_rooms[3] = old_charlotte_room;
botao_rooms[4] = dispensa_Lyn_apto;

// Hover inicial
hover[0] = false;
hover[1] = false;
hover[2] = false;
hover[3] = false;
hover[4] = false;

// Menu invisível inicialmente
menu_visible = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
mx = mouse_x;
my = mouse_y;

// Verifica se clicou no objeto para abrir/fechar menu
if (mouse_check_button_pressed(mb_left)) {
    if (position_meeting(mx, my, id)) { // id do próprio objeto
        menu_visible = !menu_visible; // alterna visibilidade
    }
}

// Se o menu estiver visível, processa hover e clique
if (menu_visible) {
    // Hover
    i = 0;
    while (i < 5) {
        hover[i] = (mx > botao_x && mx < botao_x + botao_w &&
                    my > botao_y + i*botao_espaco && my < botao_y + i*botao_espaco + botao_h);
        i += 1;
    }

    // Clique nos botões
    i = 0;
    while (i < 5) {
        if (hover[i] && mouse_check_button_pressed(mb_left)) {
            room_goto(botao_rooms[i]);
        }
        i += 1;
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_self()

if (menu_visible) {
    draw_set_font(-1); // fonte padrão

    i = 0;
    while (i < 5) {
        bx = botao_x;
        by = botao_y + i*botao_espaco;

        // cor de hover
        if (hover[i]) draw_set_color(c_gray);
        else draw_set_color(c_white);

        // desenha botão arredondado
        draw_roundrect(bx, by, bx + botao_w, by + botao_h, false); // preenchido

        // texto do botão
        draw_set_color(c_black);
        draw_text(bx + 10, by + (botao_h/2 - 6), botao_textos[i]);

        i += 1;
    }
}
