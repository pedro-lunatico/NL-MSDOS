#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Variáveis principais de controle
battle_active = false;
battle_state = 1;
battle_cooldown = 0;

// Configurações de Slide
trainer_player_x_off = -200;
trainer_enemy_x_off  = 1000;
trainer_player_target_off = 120;
trainer_enemy_target_off  = 520;
trainer_slide_speed = 10;

// Status e Dinheiro (D$)
money_reward = 50;
money_loss = 30;
money_processed = false;
player_hp = 0;
enemy_hp = 0;
player_attack_page = 0;

// Sorteio do Inimigo
r = irandom(3);
if (r == 0) enemy_pokemon = "makernimite";
if (r == 1) enemy_pokemon = "volcarona";
if (r == 2) enemy_pokemon = "magikarp";
if (r == 3) enemy_pokemon = "tepig";

// HP Inimigo
if (enemy_pokemon == "makernimite") enemy_hp = 40;
if (enemy_pokemon == "volcarona")   enemy_hp = 55;
if (enemy_pokemon == "magikarp")    enemy_hp = 35;
if (enemy_pokemon == "tepig")       enemy_hp = 45;

image_speed = 0.2;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!battle_active) exit;

// 1) TRAINERS DESLIZANDO
if (battle_state == 1) {
    trainer_player_x_off += trainer_slide_speed;
    trainer_enemy_x_off  -= trainer_slide_speed;
    if (trainer_player_x_off >= trainer_player_target_off) battle_state = 2;
}

// 2) DIÁLOGO
if (battle_state == 2 && mouse_check_button_pressed(mb_left)) {
    battle_state = 3;
}

// 3) ESCOLHA DO POKÉMON (Filtrado do Inventário)
if (battle_state == 3) {
    var menu_str, i, item_nome;
    menu_str = "";
    // Filtro para mostrar APENAS pokemons no menu
    for (i = 0; i < ds_list_size(global.player_inventory); i += 1) {
        item_nome = ds_list_find_value(global.player_inventory, i);
        if (item_nome == "makernimite" || item_nome == "volcarona" || item_nome == "tepig" || item_nome == "magikarp") {
            menu_str += item_nome + "|";
        }
    }

    escolha = show_menu_pos(mouse_x, mouse_y, menu_str + "Fugir|", -1);

    if (escolha >= 0) {
        // Lógica de extração de nome (GM 8.2)
        var temp_str, sep_pos; temp_str = menu_str + "Fugir|";
        repeat (escolha) { sep_pos = string_pos("|", temp_str); temp_str = string_delete(temp_str, 1, sep_pos); }
        player_pokemon = string_copy(temp_str, 1, string_pos("|", temp_str) - 1);

        if (player_pokemon == "Fugir") { instance_destroy(); exit; }

        if (player_pokemon == "makernimite") player_hp = 40;
        if (player_pokemon == "volcarona")   player_hp = 55;
        if (player_pokemon == "magikarp")    player_hp = 35;
        if (player_pokemon == "tepig")       player_hp = 45;
        battle_state = 4;
    }
}

// 4) BATALHA
if (battle_state == 4 && mouse_check_button_pressed(mb_left)) {
    atk_choice = show_message_ext("Ataque:", "Investida", "Especial", "Fugir");

    if (atk_choice == 1 || atk_choice == 2) {
        dmg = 10; if (atk_choice == 2) dmg = 20;
        enemy_hp -= dmg;
        if (enemy_hp <= 0) { enemy_hp = 0; battle_state = 5; exit; }

        player_hp -= 8; // Dano do inimigo
        if (player_hp <= 0) { player_hp = 0; battle_state = 6; exit; }
    } else if (atk_choice == 3) {
        show_message("Você fugiu!");
        instance_destroy();
    }
}

// 5) FINALIZAÇÃO COM DINHEIRO (D$)
if (battle_state == 5) { // Vitória
    if (!money_processed) { global.money += money_reward; money_processed = true; }
    if (keyboard_check_pressed(vk_space)) instance_destroy();
}

if (battle_state == 6) { // Derrota
    if (!money_processed) {
        global.money -= money_loss;
        if (global.money < 0) global.money = 0;
        money_processed = true;
    }
    if (keyboard_check_pressed(vk_space)) instance_destroy();
}
#define Mouse_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
battle_active = true;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_self();
if (!battle_active) exit;

var cx, cy;
cx = view_xview[0];
cy = view_yview[0];

// Fundo escuro
draw_set_alpha(0.7);
draw_set_color(c_black);
draw_rectangle(cx, cy, cx + view_wview[0], cy + view_hview[0], false);
draw_set_alpha(1);

// Trainers
if (battle_state <= 2) {
    draw_sprite(player_trainer, 0, cx + trainer_player_x_off, cy + 360);
    draw_sprite(Rosa_trainer, image_index, cx + trainer_enemy_x_off, cy + 180);
    if (battle_state == 2) {
        draw_set_color(c_white);
        draw_text(cx + 260, cy + 300, "Você foi desafiado!#Clique para continuar...");
    }
}

// Carteira de Diamantes
draw_set_color(c_yellow);
draw_text(cx + 20, cy + 20, "Diamantes: D$ " + string(global.money));
draw_set_color(c_white);

// Sprites dos Pokémons
if (battle_state >= 4) {
    // Player
    if (player_pokemon=="makernimite") draw_sprite(spr_makernimite,0,cx+180,cy+300);
    if (player_pokemon=="volcarona")   draw_sprite(spr_volcarona,0,cx+180,cy+300);
    if (player_pokemon=="magikarp")    draw_sprite(spr_magikarp,0,cx+180,cy+300);
    if (player_pokemon=="tepig")       draw_sprite(spr_tepig,0,cx+180,cy+300);

    // Inimigo
    if (enemy_pokemon=="makernimite") draw_sprite(spr_makernimite,0,cx+480,cy+200);
    if (enemy_pokemon=="volcarona")   draw_sprite(spr_volcarona,0,cx+480,cy+200);
    if (enemy_pokemon=="magikarp")    draw_sprite(spr_magikarp,0,cx+480,cy+200);
    if (enemy_pokemon=="tepig")       draw_sprite(spr_tepig,0,cx+480,cy+200);

    // HP
    draw_text(cx+50, cy+50, "Player HP: " + string(player_hp));
    draw_text(cx+500, cy+50, "Enemy HP: " + string(enemy_hp));
}

// Mensagens Finais
if (battle_state == 5) {
    draw_set_color(c_lime);
    draw_text(cx+300, cy+450, "VENCEU! Ganhou D$ " + string(money_reward));
    draw_text(cx+280, cy+480, "ESPAÇO para continuar");
}
if (battle_state == 6) {
    draw_set_color(c_red);
    draw_text(cx+300, cy+450, "PERDEU! Perdeu D$ " + string(money_loss));
    draw_text(cx+280, cy+480, "ESPAÇO para continuar");
}
