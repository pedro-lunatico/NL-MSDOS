#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Inicializa variáveis globais de progresso
global.nivel = 1;
global.xp = 0;
global.xp_max = 10; // Defina quanto de XP precisa para o lvl 1
global.show_levelup_timer = 0;

// Inicializa variáveis de animação do sprite
image_speed = 0;
image_index = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Lógica de Level Up

// Ganha 1 XP ao apertar botão direito
if (instance_exists(player) && mouse_check_button_pressed(mb_right)) {
    global.xp += 1;

    // Checa se subiu de nível
    if (global.xp >= global.xp_max) {
        global.xp = 0;
        global.nivel += 1;
        global.xp_max += 5; // Aumenta a dificuldade para o próximo nível
        global.show_levelup_timer = 90; // 1,5s de mensagem (considerando 60fps)

        // Som de Level Up
        if (sound_exists(level_up_SFX)) {
            sound_play(level_up_SFX);
        }
    }
}

// Gerencia o Timer e a Animação do Sprite
if (global.show_levelup_timer > 0) {
    global.show_levelup_timer -= 1;

    // Avança a animação do sprite se ele existir
    if (sprite_exists(spr_levelup)) {
        image_index += 0.5; // Ajuste a velocidade da animação aqui
        if (image_index >= sprite_get_number(spr_levelup)) {
            image_index = 0; // Reseta o loop da animação enquanto o timer durar
        }
    }
} else {
    image_index = 0; // Garante que o sprite comece do zero no próximo level up
}
#define Keyboard_84
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var input, comando, resto, v_nome, v_valor, sep_pos;

input = get_string("Digite o comando (ex: tp=magvel1 ou gamerule=health=100):", "");

// --- COMANDO DE TELEPORTE ---
if (string_copy(input, 1, 3) == "tp=") {
    resto = string_delete(input, 1, 3);
    execute_string("if room_exists(" + resto + ") { room_goto(" + resto + "); } else { show_message('Comando invalido: A room nao existe'); }");
}

// --- COMANDO DE VARIÁVEL ---
else if (string_copy(input, 1, 9) == "gamerule=") {
    resto = string_delete(input, 1, 9);
    sep_pos = string_pos("=", resto);

    if (sep_pos > 0) {
        v_nome = string_copy(resto, 1, sep_pos - 1);
        v_valor = string_delete(resto, 1, sep_pos);

        // Tentamos executar a atribuição diretamente.
        // O execute_string é poderoso o suficiente para entender "player.health = 0"
        // Usamos um teste simples para evitar o crash se o objeto/variável não existir.
        if (variable_global_exists(v_nome) || variable_local_exists(v_nome) || string_pos(".", v_nome) > 0) {
            execute_string(v_nome + " = " + v_valor + ";");
            show_message("Gamerule: " + v_nome + " definido para " + v_valor);
        } else {
            // Corrigido aqui: v_nome em vez de var_name
            show_message("Comando invalido: A variavel ou objeto '" + v_nome + "' nao foi encontrado.");
        }
    } else {
        show_message("Formato incorreto. Use gamerule=variavel=valor");
    }
}

else {
    show_message("Comando nao reconhecido.");
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Interface (HUD)

// Calcula posição baseada na View para seguir a câmera no GM 8.1
var cam_x, cam_y, cam_w, cam_h;

if (view_enabled) {
    cam_x = view_xview[0];
    cam_y = view_yview[0];
    cam_w = view_wview[0];
    cam_h = view_hview[0];
} else {
    cam_x = 0;
    cam_y = 0;
    cam_w = room_width;
    cam_h = room_height;
}

// 1. Desenha o texto do Nível
draw_set_color(c_white);
draw_text(20 + cam_x, 20 + cam_y, "Nivel: " + string(global.nivel));

// 2. Barra de XP (Fundo)
draw_set_alpha(0.5);
draw_set_color(c_black);
draw_rectangle(20 + cam_x, 50 + cam_y, 220 + cam_x, 65 + cam_y, false);

// 3. Barra de XP (Preenchimento)
draw_set_alpha(1);
draw_set_color(c_lime);
var xp_fill;
xp_fill = (global.xp / global.xp_max) * 200; // 200 é a largura total da barra
draw_rectangle(20 + cam_x, 50 + cam_y, 20 + cam_x + xp_fill, 65 + cam_y, false);

// 4. Desenha Sprite de Level Up no centro da tela
if (global.show_levelup_timer > 0 && sprite_exists(spr_levelup)) {
    var center_x, center_y;
    center_x = cam_x + (cam_w / 2);
    center_y = cam_y + (cam_h / 2);

    draw_sprite(spr_levelup, image_index, center_x, center_y);
}
