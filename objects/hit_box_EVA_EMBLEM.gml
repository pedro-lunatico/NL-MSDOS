#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Referência para o boss
boss = instance_nearest(x, y, Boss_EVA_EMBLEM);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!instance_exists(boss)) {
    instance_destroy();
    exit;
}

// Mantém a posição colada no boss
x = boss.x;
y = boss.y;

// ---------------------------
// DANO RECEBIDO DO PLAYER
// ---------------------------
if (boss.hp > 0) {
    with (Player_Wonder_Boy) {
        if (attacking && abs(x - other.x) < 30 && abs(y - other.y) < 30) {
            boss.hp -= 1;
            sound_play(choose(EVA_PAIN, EVA2_PAIN, EVA3_PAIN));
            effect_create_above(ef_smoke, x, y, 0, c_white);
            if (boss.hp <= 0) {
                boss.dead = true;
                effect_create_above(ef_smoke, x, y, 1, c_gray);
                room_goto(ENGAGE_CENTER_ROOM);
            }
        }
    }
}
