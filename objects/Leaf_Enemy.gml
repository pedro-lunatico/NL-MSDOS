#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///==============================================================
/// TRAINERS SLIDE (posição inicial e destino)
///==============================================================
trainer_player_x_off = -200;   // começa fora da tela (esquerda)
trainer_enemy_x_off  = 1000;   // começa fora da tela (direita)

trainer_player_target_off = 120;
trainer_enemy_target_off  = 520;

trainer_slide_speed = 10;

///==============================================================
/// ESTADOS DA BATALHA
///==============================================================
battle_active = false;
battle_state = 0;
battle_cooldown = 0;

///==============================================================
/// SPRITES DOS TRAINERS
///==============================================================
spr_trainer_player = player_trainer;
spr_trainer_enemy  = Leaf_trainer;


///==============================================================
/// LISTA DE POKÉMONS DO PLAYER (sem DS, sem arrays)
///==============================================================
/// O jogador pode ter até 4 pokémons no GM8.1 usando variáveis simples.
global.player_pokemon1 = "makernimite";
global.player_pokemon2 = "volcarona";
global.player_pokemon3 = "tepig";
global.player_pokemon4 = "magikarp";

/// quantidade real
global.player_pokemon_count = 4;
/// CREATE EVENT DO INIMIGO

// Variáveis de batalha
battle_active = false;
battle_state = 0;
battle_cooldown = 0;

// Pokémon do player / inimigo
player_pokemon = "";
enemy_pokemon = "";
player_hp = 0;
enemy_hp = 0;

// Página de ataques do player (para o botão "Mais")
player_attack_page = 0;

// Lista de ataques (exemplo)
player_attack1_name = "Choque";
player_attack1_damage = 10;
player_attack1_type = "eletrico";

player_attack2_name = "Psíquico";
player_attack2_damage = 12;
player_attack2_type = "psiquico";

player_attack3_name = "Bola de Fogo";
player_attack3_damage = 15;
player_attack3_type = "fogo";

player_attack4_name = "Água Jato";
player_attack4_damage = 8;
player_attack4_type = "agua";
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///==============================================================
/// 0) NÃO INICIAR SE ESTÁ EM COOLDOWN
///==============================================================
if (battle_cooldown > 0) battle_cooldown -= 1;

///==============================================================
/// 1) TOCAR NO PLAYER → INICIAR BATALHA
///==============================================================
if (!battle_active && battle_cooldown <= 0 && place_meeting(x,y,player))
{
    battle_active = true;
    battle_state = 1;
    battle_cooldown = 60;

    // escolher pokemon inimigo
    r = irandom(3);
    if (r == 0) enemy_pokemon = "makernimite";
    if (r == 1) enemy_pokemon = "volcarona";
    if (r == 2) enemy_pokemon = "magikarp";
    if (r == 3) enemy_pokemon = "tepig";

    // HP do inimigo
    if (enemy_pokemon == "makernimite") enemy_hp = 40;
    if (enemy_pokemon == "volcarona")   enemy_hp = 55;
    if (enemy_pokemon == "magikarp")    enemy_hp = 35;
    if (enemy_pokemon == "tepig")       enemy_hp = 45;

    // resetar posições iniciais
    trainer_player_x_off = -200;
    trainer_enemy_x_off  = 1000;
}

///==============================================================
/// 2) TRAINERS DESLIZANDO
///==============================================================
if (battle_state == 1)
{
    trainer_player_x_off += trainer_slide_speed;
    trainer_enemy_x_off  -= trainer_slide_speed;

    if (trainer_player_x_off >= trainer_player_target_off &&
        trainer_enemy_x_off  <= trainer_enemy_target_off)
    {
        battle_state = 2;
    }
}

///==============================================================
/// 3) DIÁLOGO INICIAL
///==============================================================
if (battle_state == 2)
{
    if (mouse_check_button_pressed(mb_left))
    {
        battle_state = 3;
        if (!variable_local_exists("poke_page")) poke_page = 0;
    }
}

///==============================================================
/// 4) ESCOLHER POKÉMON — SUPORTE “MAIS” COM DUAS OPÇÕES + MAIS
///==============================================================
if (battle_state == 3)
{
    // calcular start da página
    start = poke_page * 2; // 2 pokémons por página

    // pegar os pokémons da página atual
    b1 = ""; b2 = ""; b3 = "Mais";

    if (start == 0) b1 = global.player_pokemon1;
    if (start == 1) b1 = global.player_pokemon2;
    if (start == 2) b1 = global.player_pokemon3;
    if (start == 3) b1 = global.player_pokemon4;

    if (start+1 == 0) b2 = global.player_pokemon1;
    if (start+1 == 1) b2 = global.player_pokemon2;
    if (start+1 == 2) b2 = global.player_pokemon3;
    if (start+1 == 3) b2 = global.player_pokemon4;

    // se não houver mais pokémons após b2, ocultar botão "Mais"
    total_pokemons = global.player_pokemon_count;
    if (start + 2 >= total_pokemons) b3 = "";

    // mostrar menu
    escolha = show_message_ext("Escolha seu Pokémon:", b1, b2, b3);

    if (escolha == 1) player_pokemon = b1;
    else if (escolha == 2) player_pokemon = b2;
    else if (escolha == 3)
    {
        // ir para próxima página
        poke_page += 1;
        // se passou do final, volta para a primeira página
        if (poke_page*2 >= total_pokemons) poke_page = 0;
        battle_state = 3; // mantém no estado de escolha
        exit;
    }
    else exit;

    // definir HP e tipo
    if (player_pokemon == "makernimite") { player_hp = 40; pokemon_type = "eletrico"; }
    if (player_pokemon == "volcarona")   { player_hp = 55; pokemon_type = "psiquico"; }
    if (player_pokemon == "magikarp")    { player_hp = 35; pokemon_type = "agua"; }
    if (player_pokemon == "tepig")       { player_hp = 45; pokemon_type = "fogo"; }

    // resetar página e ir para batalha
    poke_page = 0;
    battle_state = 4;
}

/// =============================================================
/// 5) BATALHA — TURNOS COM ATAQUES E TIPOS
/// =============================================================
/// ===========================
/// STEP EVENT - BATALHA
/// ===========================

if (!battle_active) exit;

/// pegar camera
cx = view_xview[0];
cy = view_yview[0];

/// ================================================
/// 0) SLIDE + DIÁLOGO INICIAL
/// ================================================
if (battle_state == 1 || battle_state == 2)
{
    p_x = cx + trainer_player_x_off;
    e_x = cx + trainer_enemy_x_off;

    draw_sprite(player_trainer, 0, p_x, cy + 360);
    draw_sprite(Leaf_trainer , 0, e_x, cy + 180);

    if (battle_state == 2)
    {
        draw_set_color(c_white);
        draw_text(cx + 260, cy + 300, "Você foi desafiado!");
        draw_text(cx + 250, cy + 330, "Clique para continuar...");
    }
    exit;
}

/// ================================================
/// 1) ESCOLHA DO POKÉMON DO PLAYER
/// ================================================

if (!battle_active) exit;

/// pegar camera
cx = view_xview[0];
cy = view_yview[0];

/// =================================================
/// 0) SLIDE + DIÁLOGO INICIAL
/// =================================================
if (battle_state == 1 || battle_state == 2)
{
    p_x = cx + trainer_player_x_off;
    e_x = cx + trainer_enemy_x_off;

    draw_sprite(player_trainer, 0, p_x, cy + 360);
    draw_sprite(Leaf_trainer , 0, e_x, cy + 180);

    if (battle_state == 2)
    {
        draw_set_color(c_white);
        draw_text(cx + 260, cy + 300, "Você foi desafiado!");
        draw_text(cx + 250, cy + 330, "Clique para continuar...");
    }
    exit;
}

/// =================================================
/// 1) ESCOLHA DO POKÉMON DO PLAYER
/// =================================================
if (battle_state == 3)
{
    // Mostrar 3 pokémons + "Mais" se houver
    b1 = global.player_pokemon1;
    b2 = global.player_pokemon2;
if (global.player_pokemon_count > 2) {
    b3 = "Mais";
} else {
    b3 = global.player_pokemon3;
}

    escolha = show_message_ext("Escolha seu Pokémon:", b1, b2, b3);

    if (escolha == 1) player_pokemon = b1;
    else if (escolha == 2) player_pokemon = b2;
    else if (escolha == 3)
    {
        if (b3 == "Mais")
        {
            // rotaciona os pokémons
            tmp = global.player_pokemon1;
            global.player_pokemon1 = global.player_pokemon4;
            global.player_pokemon4 = tmp;

            tmp = global.player_pokemon2;
            global.player_pokemon2 = global.player_pokemon3;
            global.player_pokemon3 = tmp;

            battle_state = 3;
            exit;
        }
        else player_pokemon = b3;
    }
    else exit;

    // Definir HP e tipo
    if (player_pokemon == "makernimite") { player_hp = 40; pokemon_type = "eletrico"; }
    if (player_pokemon == "volcarona")   { player_hp = 55; pokemon_type = "psiquico"; }
    if (player_pokemon == "magikarp")    { player_hp = 35; pokemon_type = "agua"; }
    if (player_pokemon == "tepig")       { player_hp = 45; pokemon_type = "fogo"; }

    battle_state = 4; // ir para batalha
}

/// =================================================
/// 2) BATALHA - ESCOLHA DE ATAQUES
/// =================================================
if (battle_state == 4 && mouse_check_button_pressed(mb_left))
{
    // ataques do player
    a1 = "Choque";   a1_type = "eletrico"; a1_dmg = 10;
    a2 = "Raio";     a2_type = "eletrico"; a2_dmg = 12;
    a3 = "Agua Jato";a3_type = "agua";     a3_dmg = 8;
    a4 = "Splash";   a4_type = "agua";     a4_dmg = 5;

    // mostrar 3 ataques por vez
   atk1 = a1;
   atk2 = a2;

   if (player_attack_page > 0) {
    atk3 = "Mais";
    } else {
    atk3 = a3;
    }


    attack_choice = show_message_ext("Escolha um ataque:", atk1, atk2, atk3);

    // selecionar ataque
    if (attack_choice == 1) { atk_type = a1_type; atk_dmg = a1_dmg; }
    else if (attack_choice == 2) { atk_type = a2_type; atk_dmg = a2_dmg; }
    else if (attack_choice == 3)
    {
        if (atk3 == "Mais")
        {
            player_attack_page = 1 - player_attack_page; // alterna entre páginas
            battle_state = 4;
            exit;
        }
        else { atk_type = a3_type; atk_dmg = a3_dmg; }
    }
    else exit;

    // calcular dano (super efetivo simples)
    multiplier = 1;
    if (atk_type == "agua" && enemy_pokemon == "tepig") multiplier = 2;
    if (atk_type == "fogo" && enemy_pokemon == "magikarp") multiplier = 2;
    if (atk_type == "eletrico" && enemy_pokemon == "magikarp") multiplier = 2;

    enemy_hp -= atk_dmg * multiplier;

    if (enemy_hp <= 0) { battle_state = 5; exit; }

    // ataque do inimigo
    e1 = "Chama"; e1_type = "fogo"; e1_dmg = 10;
    e2 = "Investida"; e2_type = "normal"; e2_dmg = 8;
    enemy_choice = irandom(1) + 1;
    if (enemy_choice == 1) { e_type = e1_type; e_dmg = e1_dmg; }
    else { e_type = e2_type; e_dmg = e2_dmg; }

    e_multiplier = 1;
    if (e_type == "fogo" && player_pokemon == "magikarp") e_multiplier = 2;
    if (e_type == "agua" && player_pokemon == "tepig") e_multiplier = 2;

    player_hp -= e_dmg * e_multiplier;

    if (player_hp <= 0) { battle_state = 6; exit; }
}

///==============================================================
/// 6) FINAL — WIN / LOSE
///==============================================================
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
draw_self();

// sair se a batalha não está ativa
if (!battle_active) exit;

/// pegar camera atual
cx = view_xview[0];
cy = view_yview[0];

/// fundo escuro
draw_set_alpha(0.7);
draw_set_color(c_black);
draw_rectangle(cx, cy, cx + 1000, cy + 1000, false);
draw_set_alpha(1);

/// ================================================
/// 1) SLIDE + DIÁLOGO (states 1 e 2)
/// ================================================
if (battle_state == 1 || battle_state == 2)
{
    // converter offsets em posição real
    p_x = cx + trainer_player_x_off;
    e_x = cx + trainer_enemy_x_off;

    draw_sprite(spr_trainer_player, 0, p_x, cy + 360);
    draw_sprite(spr_trainer_enemy , 0, e_x, cy + 180);

    if (battle_state == 2)
    {
        draw_set_color(c_white);
        draw_text(cx + 260, cy + 300, "Você foi desafiado!");
        draw_text(cx + 250, cy + 330, "Clique para continuar...");
    }
    exit;
}

/// ================================================
/// 2) BATALHA NORMAL (state >= 3)
/// ================================================
if (battle_state >= 3)
{
    draw_set_color(c_white);

    // Pokémon do player
    if (variable_local_exists("player_pokemon"))
    {
        switch(player_pokemon)
        {
            case "makernimite": draw_sprite(spr_makernimite,0,cx+180,cy+300); break;
            case "volcarona":   draw_sprite(spr_volcarona,0,cx+180,cy+300); break;
            case "magikarp":    draw_sprite(spr_magikarp,0,cx+180,cy+300); break;
            case "tepig":       draw_sprite(spr_tepig,0,cx+180,cy+300); break;
        }
    }

    // Pokémon do inimigo
    if (variable_local_exists("enemy_pokemon"))
    {
        switch(enemy_pokemon)
        {
            case "makernimite": draw_sprite(spr_makernimite,0,cx+480,cy+200); break;
            case "volcarona":   draw_sprite(spr_volcarona,0,cx+480,cy+200); break;
            case "magikarp":    draw_sprite(spr_magikarp,0,cx+480,cy+200); break;
            case "tepig":       draw_sprite(spr_tepig,0,cx+480,cy+200); break;
        }
    }

    // HP
    if (variable_local_exists("player_hp")) draw_text(cx+50,  cy+50, "Player HP: " + string(player_hp));
    if (variable_local_exists("enemy_hp"))  draw_text(cx+500, cy+50, "Enemy HP: "  + string(enemy_hp));
}

/// ================================================
/// 3) RESULTADO DA BATALHA (win / lose)
/// ================================================
if (battle_state == 5)
{
    draw_text(cx+330, cy+500, "Você venceu!");
    draw_text(cx+280, cy+530, "Pressione SPACE para continuar");
}

if (battle_state == 6)
{
    draw_text(cx+330, cy+500, "Você perdeu!");
    draw_text(cx+280, cy+530, "Pressione SPACE para continuar");
}
