#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// ---------------------------
// MOVIMENTO / PATRULHA
// ---------------------------
boss_speed  = 2;        // velocidade de patrulha
x1          = x - 100;  // limite esquerdo
x2          = x + 100;  // limite direito
patrol_dir  = 1;        // 1 = direita, -1 = esquerda
attacking   = false;    // estado de ataque
attack_duration = 30;   // duração do ataque (frames)
hsp         = 0;        // velocidade horizontal
vsp         = 0;        // velocidade vertical
facing      = 1;        // 1 = direita, -1 = esquerda

// ---------------------------
// VIDA / ESTADO
// ---------------------------
hp          = 150;       // vida do boss
dead        = false;    // se o boss está morto
can_take_damage = true; // se pode receber dano

// ---------------------------
// SPRITES
// ---------------------------
boss_idle_sprite   = EVA_EMBLEM_IDLE;
boss_walk_sprite   = EVA_EMBLEM_WALK;
boss_attack_sprite = EVA_EMBLEM_ATTACK;

// ---------------------------
// SFX DO BOSS
// ---------------------------
boss_hit_SFX1 = EVA_PAIN;
boss_hit_SFX2 = EVA2_PAIN;
boss_hit_SFX3 = EVA3_PAIN;

// ---------------------------
// patrol
// ---------------------------

patrol_left  = x - 100;
patrol_right = x + 100;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// ---------------------------
// CHECAR SE MORTO
// ---------------------------
if (dead) exit;

// ---------------------------
// PATRULHA HORIZONTAL
// ---------------------------
if (!attacking) {
    x += boss_speed * patrol_dir;
    facing = patrol_dir;

    if (x >= patrol_right) patrol_dir = -1;
    if (x <= patrol_left) patrol_dir = 1;
}

// ---------------------------
// ATAQUE AUTOMÁTICO (opcional)
// ---------------------------
if (!attacking && abs(x - Player_Wonder_Boy.x) < 100 && abs(y - Player_Wonder_Boy.y) < 50) {
    attacking = true;
    attack_timer = attack_duration;
}

// ---------------------------
// TIMER DO ATAQUE
// ---------------------------
if (attacking) {
    attack_timer -= 1;
    if (attack_timer <= 0) attacking = false;
}

// ---------------------------
// DANO AO PLAYER
// ---------------------------
with (Player_Wonder_Boy) {
    if (!dead && abs(x - other.x) < 50 && abs(y - other.y) < 50) {
        if (other.can_take_damage) {
            hp -= 5; // player perde vida
            sound_play(choose(charlotte_Pain, charlotte2_Pain, charlotte3_Pain));
            effect_create_above(ef_smoke, x, y, 0, c_red);
        }
    }
}

// ---------------------------
// DANO RECEBIDO DO PLAYER
// ---------------------------
if (attacking) {
    with (Player_Wonder_Boy) {
        if (other.attacking && abs(x - other.x) < 50 && abs(y - other.y) < 50) {
            hp -= 5; // boss perde vida
            sound_play(choose(EVA_PAIN, EVA2_PAIN, EVA3_PAIN));
            effect_create_above(ef_smoke, x, y, 0, c_white);
        }
    }
}

// ---------------------------
// CHECAR SE MORREU
// ---------------------------
if (hp <= 0 && !dead) {
    dead = true;
    effect_create_above(ef_smoke, x, y, 1, c_gray);
    room_goto(ENGAGE_CENTER_ROOM);
    exit;
}

// ---------------------------
// ANIMAÇÕES
// ---------------------------
if (attacking) {
    sprite_index = EVA_EMBLEM_ATTACK;
    image_speed = 0.5; // animação mais lenta
} else if (patrol_dir != 0) { // patrulha sempre andando
    sprite_index = EVA_EMBLEM_WALK;
    image_speed = 0.3;
} else {
    sprite_index = EVA_EMBLEM_IDLE;
    image_speed = 0.2;
}

// ---------------------------
// FLIP HORIZONTAL
// ---------------------------
image_xscale = facing;

// ---------------------------
// MOVIMENTO HORIZONTAL
// ---------------------------
x += boss_speed * patrol_dir;
facing = patrol_dir;

if (x >= patrol_right) patrol_dir = -1;
if (x <= patrol_left) patrol_dir = 1;
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// ROOM START EVENT
// Toca a música de fundo ao iniciar a room
sound_loop(transformation_Song); // substitua pelo nome da sua música
#define Other_5
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// ROOM END EVENT
// Para a música ao sair da room
sound_stop(transformation_Song);
