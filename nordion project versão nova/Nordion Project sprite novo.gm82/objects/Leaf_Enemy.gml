#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///==============================================================
/// INICIALIZAÇÃO E INVENTÁRIO
///==============================================================

// Criar inventário global se não existir
if (!variable_global_exists("player_inventory")) {
    global.player_inventory = ds_list_create();
    ds_list_add(global.player_inventory, "makernimite");
    ds_list_add(global.player_inventory, "tepig");
    ds_list_add(global.player_inventory, "volcarona");
    ds_list_add(global.player_inventory, "magikarp");
}

// Configurações de Slide (Posições)
trainer_player_x_off = -200;
trainer_enemy_x_off  = 1000;
trainer_player_target_off = 120;
trainer_enemy_target_off  = 520;
trainer_slide_speed = 10;

// Estados da Batalha
battle_active = false;
battle_state = 0; // 0:Inativo, 1:Slide, 2:Diálogo, 3:Menu PKMN, 4:Luta, 5:Vitória, 6:Derrota
battle_cooldown = 0;
// Valores de recompensa/perda
money_reward = 600;  // Quanto ganha ao vencer
money_loss = 350;    // Quanto perde ao ser derrotado
money_processed = false; // Garante que o dinheiro seja alterado apenas uma vez

// Sprites e Dados
spr_trainer_player = player_trainer;
spr_trainer_enemy  = Leaf_trainer;
player_pokemon = "";
enemy_pokemon = "";
player_hp = 0;
enemy_hp = 0;
player_attack_page = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///==============================================================
/// LÓGICA DE BATALHA - STEP EVENT (VERSÃO AUTO-DESTRUIÇÃO)
///==============================================================

if (battle_cooldown > 0) battle_cooldown -= 1;

// 1) INICIAR BATALHA
if (battle_active == false && battle_cooldown <= 0 && place_meeting(x, y, player)) {
    battle_active = true;
    battle_state = 1;
    money_processed = false;

    // Dados do Inimigo
    var r; r = irandom(3);
    if (r == 0) { enemy_pokemon = "makernimite"; enemy_hp = 40; }
    if (r == 1) { enemy_pokemon = "volcarona";   enemy_hp = 55; }
    if (r == 2) { enemy_pokemon = "magikarp";    enemy_hp = 35; }
    if (r == 3) { enemy_pokemon = "tepig";       enemy_hp = 45; }

    trainer_player_x_off = -200;
    trainer_enemy_x_off  = 1000;
}

if (battle_active == false) exit;

// 2) SLIDE (Estado 1)
if (battle_state == 1) {
    trainer_player_x_off += trainer_slide_speed;
    trainer_enemy_x_off  -= trainer_slide_speed;
    if (trainer_player_x_off >= trainer_player_target_off) battle_state = 2;
}

// 3) DIÁLOGO (Estado 2)
if (battle_state == 2) {
    if (mouse_check_button_pressed(mb_left)) battle_state = 3;
}

// 4) ESCOLHA PKMN (Estado 3)
if (battle_state == 3) {
    var menu_str, i, item_nome;
    menu_str = "";
    for (i = 0; i < ds_list_size(global.player_inventory); i += 1) {
        item_nome = ds_list_find_value(global.player_inventory, i);
        if (item_nome == "makernimite" || item_nome == "tepig" || item_nome == "volcarona" || item_nome == "magikarp") {
            menu_str += item_nome + "|";
        }
    }
    var escolha; escolha = show_menu_pos(mouse_x, mouse_y, menu_str, -1);
    if (escolha >= 0) {
        var temp_str, sep_pos; temp_str = menu_str;
        repeat (escolha) { sep_pos = string_pos("|", temp_str); temp_str = string_delete(temp_str, 1, sep_pos); }
        player_pokemon = string_copy(temp_str, 1, string_pos("|", temp_str) - 1);
        if (player_pokemon == "makernimite") player_hp = 40;
        if (player_pokemon == "volcarona")   player_hp = 55;
        if (player_pokemon == "magikarp")    player_hp = 35;
        if (player_pokemon == "tepig")       player_hp = 45;
        battle_state = 4;
    }
}

// 5) LUTA OU FUGA (Estado 4)
if (battle_state == 4 && mouse_check_button_pressed(mb_left)) {
    var atk; atk = show_message_ext("Ações:", "Ataque", "Especial", "Fugir");

    if (atk == 1 || atk == 2) {
        var dmg; if (atk == 1) { dmg = 10; } else { dmg = 20; }
        enemy_hp -= dmg;
        if (enemy_hp <= 0) { battle_state = 5; exit; }
        player_hp -= 12;
        if (player_hp <= 0) { battle_state = 6; exit; }
    }
    else if (atk == 3) {
        show_message("Você fugiu!");
        instance_destroy(); // DESTRÓI O TREINADOR AO FUGIR
    }
}

// 6) VITÓRIA (Estado 5)
if (battle_state == 5) {
    if (money_processed == false) { global.money += money_reward; money_processed = true; }
    if (keyboard_check_pressed(vk_space)) instance_destroy(); // DESTRÓI AO VENCER
}

// 7) DERROTA (Estado 6)
if (battle_state == 6) {
    if (money_processed == false) {
        global.money -= money_loss;
        if (global.money < 0) global.money = 0;
        money_processed = true;
    }
    if (keyboard_check_pressed(vk_space)) instance_destroy(); // DESTRÓI AO PERDER
}
#define Collision_player
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
battle_active = true;
#define Mouse_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=211
invert=0
arg0=dano_de_espada
arg1=0
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=532
relative=1
applies_to=self
invert=0
arg0=8
arg1=0
arg2=0
arg3=2
arg4=33023
arg5=0
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=203
applies_to=self
invert=0
*/
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///==============================================================
/// RENDERIZAÇÃO DA BATALHA - DRAW EVENT
///==============================================================

// Enquanto o treinador existir, ele aparece no mapa
draw_self();

if (battle_active == false) exit;

var cx, cy, cw, ch;
cx = view_xview[0]; cy = view_yview[0];
cw = view_wview[0]; ch = view_hview[0];

// FUNDO ESCURO
draw_set_alpha(0.7);
draw_set_color(c_black);
draw_rectangle(cx, cy, cx + cw, cy + ch, false);
draw_set_alpha(1);

// TREINADORES (SÓ NOS ESTADOS INICIAIS)
if (battle_state == 1 || battle_state == 2) {
    draw_sprite(spr_trainer_player, 0, cx + trainer_player_x_off, cy + 360);
    draw_sprite(spr_trainer_enemy, 0, cx + trainer_enemy_x_off, cy + 180);
}

// HUD DE BATALHA
if (battle_state >= 3) {
    draw_set_color(c_yellow);
    draw_text(cx + 20, cy + 20, "Diamantes: D$ " + string(global.money));
    draw_set_color(c_white);
    draw_text(cx + 50, cy + 100, "PKMN: " + string(player_pokemon) + " HP: " + string(player_hp));
    draw_text(cx + cw - 200, cy + 100, "RIVAL: " + string(enemy_pokemon) + " HP: " + string(enemy_hp));
}

// MENSAGENS FINAIS
if (battle_state == 5) {
    draw_set_color(c_lime);
    draw_text(cx + 250, cy + 200, "VITÓRIA! + D$ " + string(money_reward) + "#Pressione ESPAÇO");
}
if (battle_state == 6) {
    draw_set_color(c_red);
    draw_text(cx + 250, cy + 200, "DERROTA... - D$ " + string(money_loss) + "#Pressione ESPAÇO");
}
