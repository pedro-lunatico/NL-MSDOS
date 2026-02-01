#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Variáveis principais
battle_active = false;
battle_state = 1;
battle_cooldown = 0;

trainer_player_x_off = -200;
trainer_enemy_x_off  = 1000;

trainer_player_target_off = 120;
trainer_enemy_target_off  = 520;
trainer_slide_speed = 10;

player_attack_page = 0;
poke_page = 0;
player_hp = 0;
enemy_hp = 0;

// Escolher Pokémon inimigo aleatório
r = irandom(3);
if (r == 0) enemy_pokemon = "makernimite";
if (r == 1) enemy_pokemon = "volcarona";
if (r == 2) enemy_pokemon = "magikarp";
if (r == 3) enemy_pokemon = "tepig";

// HP inimigo
if (enemy_pokemon == "makernimite") enemy_hp = 40;
if (enemy_pokemon == "volcarona")   enemy_hp = 55;
if (enemy_pokemon == "magikarp")    enemy_hp = 35;
if (enemy_pokemon == "tepig")       enemy_hp = 45;

// Inicializar sprites animados
image_index = 0;
image_speed = 0.2;

// Lista de Pokémon do jogador
global.player_pokemon1 = "makernimite";
global.player_pokemon2 = "volcarona";
global.player_pokemon3 = "tepig";
global.player_pokemon4 = "magikarp";

// Quantidade real de Pokémon
global.player_pokemon_count = 4;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!battle_active) exit;

// =============================================================
// 1) TRAINERS DESLIZANDO
// =============================================================
if (battle_state == 1) {
    trainer_player_x_off += trainer_slide_speed;
    trainer_enemy_x_off  -= trainer_slide_speed;

    if (trainer_player_x_off >= trainer_player_target_off &&
        trainer_enemy_x_off <= trainer_enemy_target_off) {
        battle_state = 2;
    }
}

// =============================================================
// 2) DIÁLOGO INICIAL
// =============================================================
if (battle_state == 2 && mouse_check_button_pressed(mb_left)) {
    battle_state = 3;
    poke_page = 0;
}

// =============================================================
// 3) ESCOLHA DO POKÉMON
// =============================================================
if (battle_state == 3) {
    start = poke_page * 2;
    b1 = global.player_pokemon1;
    b2 = global.player_pokemon2;
    if (start + 2 < global.player_pokemon_count) {
    b3 = "Mais";
} else {
    b3 = "";
}

    escolha = show_message_ext("Escolha seu Pokémon:", b1, b2, b3);

    if (escolha == 1) player_pokemon = b1;
    else if (escolha == 2) player_pokemon = b2;
    else if (escolha == 3) {
        poke_page += 1;
        if (poke_page*2 >= global.player_pokemon_count) poke_page = 0;
        exit;
    } else exit;

    // Definir HP
    if (player_pokemon == "makernimite") player_hp = 40;
    if (player_pokemon == "volcarona")   player_hp = 55;
    if (player_pokemon == "magikarp")    player_hp = 35;
    if (player_pokemon == "tepig")       player_hp = 45;

    battle_state = 4;
}

// =============================================================
// 4) BATALHA
// =============================================================
if (battle_state == 4 && mouse_check_button_pressed(mb_left)) {

    // Definir ataques
    a1 = "Choque"; a1_type = "eletrico"; a1_dmg = 10;
    a2 = "Raio"; a2_type = "eletrico"; a2_dmg = 12;
    a3 = "Agua Jato"; a3_type = "agua"; a3_dmg = 8;
    a4 = "Splash"; a4_type = "agua"; a4_dmg = 5;

    atk1 = a1; atk2 = a2;
    if (player_attack_page > 0) atk3 = "Mais"; else atk3 = a3;

    attack_choice = show_message_ext("Escolha um ataque:", atk1, atk2, atk3);

    if (attack_choice == 1) { atk_type = a1_type; atk_dmg = a1_dmg; }
    else if (attack_choice == 2) { atk_type = a2_type; atk_dmg = a2_dmg; }
    else if (attack_choice == 3) {
        if (atk3 == "Mais") {
            player_attack_page = 1 - player_attack_page;
            exit;
        } else { atk_type = a3_type; atk_dmg = a3_dmg; }
    } else exit;

    // Dano inimigo
    multiplier = 1;
    if (atk_type == "agua" && enemy_pokemon == "tepig") multiplier = 2;
    if (atk_type == "fogo" && enemy_pokemon == "magikarp") multiplier = 2;
    if (atk_type == "eletrico" && enemy_pokemon == "magikarp") multiplier = 2;

    enemy_hp -= atk_dmg * multiplier;
    if (enemy_hp <= 0) { enemy_hp = 0; battle_state = 5; exit; }

    // Ataque inimigo
    e1 = "Chama"; e1_type = "fogo"; e1_dmg = 10;
    e2 = "Investida"; e2_type = "normal"; e2_dmg = 8;
    enemy_choice = irandom(1)+1;
    if (enemy_choice == 1) { e_type=e1_type; e_dmg=e1_dmg; }
    else { e_type=e2_type; e_dmg=e2_dmg; }

    e_multiplier = 1;
    if (e_type=="fogo" && player_pokemon=="magikarp") e_multiplier=2;
    if (e_type=="agua" && player_pokemon=="tepig") e_multiplier=2;

    player_hp -= e_dmg * e_multiplier;
    if (player_hp <= 0) { player_hp = 0; battle_state = 6; exit; }
}

// =============================================================
// 5) FINAL
// =============================================================
if (battle_state == 5 || battle_state == 6)
{
    instance_destroy()
    if (keyboard_check_pressed(vk_anykey))
    {
        battle_active = false;
        battle_state = 0;

        trainer_player_x_off = -200;
        trainer_enemy_x_off  = 1000;

        battle_cooldown = 60;
    }
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
draw_self()
if (!battle_active) exit;

// Fundo escuro
draw_set_alpha(0.7);
draw_set_color(c_black);
draw_rectangle(0,0,800,600,false);
draw_set_alpha(1);

// Slide + diálogo
if (battle_state == 1 || battle_state == 2) {
    draw_sprite(player_trainer, 0, trainer_player_x_off, 360);
    draw_sprite(Rosa_trainer, image_index, trainer_enemy_x_off, 180);

    if (battle_state == 2) {
        draw_set_color(c_white);
        draw_text(260, 300, "Você foi desafiado!");
        draw_text(250, 330, "Clique para continuar...");
    }
    exit;
}

// Pokémon player
if (variable_local_exists("player_pokemon")) {
    if (player_pokemon=="makernimite") draw_sprite(spr_makernimite,0,180,300);
    if (player_pokemon=="volcarona")   draw_sprite(spr_volcarona,0,180,300);
    if (player_pokemon=="magikarp")    draw_sprite(spr_magikarp,0,180,300);
    if (player_pokemon=="tepig")       draw_sprite(spr_tepig,0,180,300);
}

// Pokémon inimigo
if (variable_local_exists("enemy_pokemon")) {
    if (enemy_pokemon=="makernimite") draw_sprite(spr_makernimite,0,480,200);
    if (enemy_pokemon=="volcarona")   draw_sprite(spr_volcarona,0,480,200);
    if (enemy_pokemon=="magikarp")    draw_sprite(spr_magikarp,0,480,200);
    if (enemy_pokemon=="tepig")       draw_sprite(spr_tepig,0,480,200);
}

// HP
if (variable_local_exists("player_hp")) draw_text(50,50,"Player HP: "+string(player_hp));
if (variable_local_exists("enemy_hp")) draw_text(500,50,"Enemy HP: "+string(enemy_hp));

/// ================================================
/// 3) RESULTADO DA BATALHA (win / lose)
/// ================================================
if (battle_state == 5)
{
    draw_text(x+330, y+500, "Você venceu!");
    draw_text(x+280, y+530, "Pressione SPACE para continuar");
}

if (battle_state == 6)
{
    draw_text(x+330, y+500, "Você perdeu!");
    draw_text(x+280, y+530, "Pressione SPACE para continuar");
}
