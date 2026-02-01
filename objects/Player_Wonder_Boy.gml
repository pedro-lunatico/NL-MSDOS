#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///create
// Estado
state = "idle";
facing = 1;
attacking = false;
jumping = false;

// Movimento
move_speed = 4;
jump_power = -10;
grav = 0.5;
hsp = 0;
vsp = 0;

// Ataque
attack_duration = 15; // duração maior para animação não cortar

// Vida / Dano
hp = 100;           // vida local
dead = false;
can_take_damage = true;

// SPRITES
idle_sprite = ply_Berserker;
walk_sprite = ply_Berserker_Walk;
attack_sprite = ply_Berserker_Sword;

// SFX
sword_SFX = Sword_SFX;
sword2_SFX = Sword2_SFX;
sword3_SFX = Sword3_SFX;
Charlotte_Pain = charlotte_Pain;
Charlotte2_Pain = charlotte2_Pain;
Charlotte3_Pain = charlotte3_Pain;

// Atualiza health global
global.health = hp;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// STEP EVENT do player
// ---------------------------
// CHECAR SE MORREU
// ---------------------------
if (dead) exit;

// ---------------------------
// RESET MOVIMENTO
// ---------------------------
hsp = 0;

// ---------------------------
// INPUT HORIZONTAL
// ---------------------------
if (!attacking) {
    if (keyboard_check(vk_right)) { hsp = move_speed; facing = 1; }
    else if (keyboard_check(vk_left)) { hsp = -move_speed; facing = -1; }
}

// ---------------------------
// PULO
// ---------------------------
if (keyboard_check_pressed(ord("X"))) {
    if (place_meeting(x, y + 1, colizao)) { vsp = jump_power; jumping = true; }
}

// ---------------------------
// GRAVIDADE
// ---------------------------
vsp += grav;
if (vsp > 12) vsp = 12;

// ---------------------------
// MOVIMENTO HORIZONTAL COM COLISÃO
// ---------------------------
if (hsp != 0) {
    if (place_meeting(x + hsp, y, colizao)) { move_contact_solid(sign(hsp), abs(hsp)); hsp = 0; }
}
x += hsp;

// ---------------------------
// COLISÃO VERTICAL
// ---------------------------
if (place_meeting(x, y + vsp, colizao)) {
    while (!place_meeting(x, y + sign(vsp), colizao)) { y += sign(vsp); }
    vsp = 0;
    jumping = false;
}
y += vsp;

// ---------------------------
// ATAQUE
// ---------------------------
if (!attacking && keyboard_check_pressed(ord("Z"))) {
    attacking = true;
    attack_timer = attack_duration;

    var atk_snd;
    atk_snd = choose(Sword_SFX, Sword2_SFX, Sword3_SFX);
    sound_play(atk_snd); // sobreposto
}

// ---------------------------
// TIMER DO ATAQUE
// ---------------------------
if (attacking) {
    attack_timer -= 1;
    if (attack_timer <= 0) attacking = false;
}

// ---------------------------
// DANO NO BOSS
// ---------------------------
with (Boss_EVA_EMBLEM) {
    if (!dead && attacking && abs(x - other.x) < 50 && abs(y - other.y) < 50) {
        hp -= 10;

        var boss_pain_snd;
        boss_pain_snd = choose(EVA_PAIN, EVA2_PAIN, EVA3_PAIN);
        sound_play(boss_pain_snd); // sobreposto

        effect_create_above(ef_smoke, x, y, 0, c_white);

        if (hp <= 0) {
            dead = true;
            effect_create_above(ef_smoke, x, y, 1, c_gray);
            room_goto(ENGAGE_CENTER_ROOM);
        }
    }
}

// ---------------------------
// DANO RECEBIDO DO BOSS
// ---------------------------
with (Boss_EVA_EMBLEM) {
    if (!dead && abs(x - other.x) < 50 && abs(y - other.y) < 50) {
        if (other.can_take_damage) {
            hp -= 5;

            var player_pain_snd;
            player_pain_snd = choose(charlotte_Pain, charlotte2_Pain, charlotte3_Pain);
            sound_play(player_pain_snd); // sobreposto

            effect_create_above(ef_smoke, x, y, 0, c_red);
        }
    }
}

// ---------------------------
// ATUALIZA HEALTH GLOBAL
// ---------------------------
global.health = hp;

// ---------------------------
// MORTE DO PLAYER
// ---------------------------
if (hp <= 0 && !dead) dead = true; // reinício ou game over

// ---------------------------
// ANIMAÇÕES
// ---------------------------
if (attacking) { sprite_index = ply_Berserker_Sword; image_speed = 0.5; }
else if (hsp != 0) { sprite_index = ply_Berserker_Walk; image_speed = 0.3; }
else { sprite_index = ply_Berserker; image_speed = 0.2; }

// ---------------------------
// FLIP HORIZONTAL
// ---------------------------
image_xscale = facing;
