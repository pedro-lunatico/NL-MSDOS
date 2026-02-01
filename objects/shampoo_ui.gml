#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///create
// Lista de multiplicadores de velocidade
if (!variable_global_exists("global.ds_vel")) {
    global.ds_vel = ds_list_create();
    ds_list_add(global.ds_vel, 1.25);
    ds_list_add(global.ds_vel, 1.5);
    ds_list_add(global.ds_vel, 2);
}

// Controle do diálogo de integridade
global.dialogo_integridade_ativo = false;
global.dialogo_integridade_texto = ds_list_create();
ds_list_add(global.dialogo_integridade_texto, "Rhodon;essa opcao pode quebrar o jogo");
ds_list_add(global.dialogo_integridade_texto, "olha aqui nao me faca morrer denovo");
global.dialogo_integridade_index = 0;

// Guarda a posição original do sprite
rhodon_x = x;
rhodon_y = y;

// Inicializa diálogo
if (global.dialogo_integridade_ativo) {
    texto_completo = ds_list_find_value(global.dialogo_integridade_texto, global.dialogo_integridade_index);
} else {
    texto_completo = "shampoo mesmo morta continua sendo pertubada"; // padrão se não houver diálogo global
}
// ====== Inicialização de variáveis globais ======

// Garante que a variável global existe
if (!variable_global_exists("dialogo_integridade_ativo")) {
    global.dialogo_integridade_ativo = false;
}

// Garante que a lista de diálogos existe
if (!variable_global_exists("dialogo_integridade_texto")) {
    global.dialogo_integridade_texto = ds_list_create();
}

// Garante que o índice do diálogo existe
if (!variable_global_exists("dialogo_integridade_index")) {
    global.dialogo_integridade_index = 0;
}

texto_atual = "";
texto_letra_index = 1;
texto_velocidade = 1; // 1 frame por letra
texto_contador = 0;

dialogo_ativo = true;

// Som opcional por letra
snd_texto = noone;
if (sound_exists(text_sfx)) {
    snd_texto = text_sfx;
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (dialogo_ativo) {

    // Atualiza texto se houver diálogo global ativo
    if (global.dialogo_integridade_ativo) {
        texto_completo = ds_list_find_value(global.dialogo_integridade_texto, global.dialogo_integridade_index);
    }

    // Efeito de digitar letra por letra
    texto_contador += 1;
    if (texto_contador >= texto_velocidade && texto_letra_index <= string_length(texto_completo)) {
        texto_atual = string_copy(texto_completo, 1, texto_letra_index);
        texto_letra_index += 1;
        texto_contador = 0;

        // Toca som por letra
        if (snd_texto != noone) {
            sound_play(snd_texto);
        }
    }

    // Variável para controlar avanço
    var avancar_dialogo;
    avancar_dialogo = false;

    // Teclado
    if (keyboard_check_pressed(vk_anykey)) {
        avancar_dialogo = true;
    }

    // Clique normal do mouse
    if (mouse_check_button_pressed(mb_left)) {
        avancar_dialogo = true;
    }

    // Clique em qualquer objeto (pular diálogo)
    if (mouse_check_button_pressed(mb_left)) {
        var inst;
        inst = instance_position(mouse_x, mouse_y, all); // "all" detecta qualquer instância
        if (inst != noone) {
            avancar_dialogo = true;
        }
    }

    // Se o texto já terminou de aparecer
    if (avancar_dialogo && texto_letra_index > string_length(texto_completo)) {

        if (global.dialogo_integridade_ativo) {
            global.dialogo_integridade_index += 1;

            if (global.dialogo_integridade_index >= ds_list_size(global.dialogo_integridade_texto)) {
                global.dialogo_integridade_ativo = false;

                // Ativa aceleração caso necessário
                global.acelerado = !global.acelerado;
                if (global.acelerado) {
                    global.tab_ativo = true;
                    global.step_mult = ds_list_find_value(global.ds_vel, global.index_vel);
                } else {
                    global.step_mult = 1;
                }

                dialogo_ativo = false;
                instance_destroy();
            } else {
                // Próxima linha do diálogo
                texto_atual = "";
                texto_letra_index = 1;
                texto_contador = 0;
            }
        } else {
            // Diálogo simples
            dialogo_ativo = false;
            instance_destroy();
        }
    }
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=211
invert=0
arg0=settings_song
arg1=1
*/
#define Other_5
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=212
invert=0
arg0=settings_song
*/
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///draw
// Desenha o sprite do Rhodon na posição original
draw_sprite(sprite_index, image_index, rhodon_x, rhodon_y);

// Balão fixo na parte inferior da room
if (dialogo_ativo) {
    balao_width = 400;
    balao_height = 80;
    balao_x = (room_width / 2) - (balao_width / 2);
    balao_y = room_height - balao_height - 10; // 10px acima da borda inferior

    // contorno preto
    draw_set_color(c_white);
    draw_rectangle(balao_x, balao_y, balao_x + balao_width, balao_y + balao_height, false);

    // preenchimento vermelho
    draw_set_color(c_aqua);
    draw_rectangle(balao_x + 2, balao_y + 2, balao_x + balao_width - 2, balao_y + balao_height - 2, true);

    // Texto com sombra
    draw_set_font(normal);
    tx = balao_x + 10;
    ty = balao_y + 10;

    draw_set_color(c_black);
    draw_text(tx-1, ty, texto_atual);
    draw_text(tx+1, ty, texto_atual);
    draw_text(tx, ty-1, texto_atual);
    draw_text(tx, ty+1, texto_atual);

    draw_set_color(c_white);
    draw_text(tx, ty, texto_atual);
}
