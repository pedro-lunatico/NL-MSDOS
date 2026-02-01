#define Mouse_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=211
invert=0
arg0=MENU_Select
arg1=0
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=321
invert=0
arg0=vc:que bonitinho o cavalinho!!!
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=211
invert=0
arg0=MENU_Select
arg1=0
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=321
invert=0
arg0=vc:e pensar que tem dimensoes onde cavalo e coisa do passado......
*/
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
action_id=603
applies_to=self
*/
// Inicializa globals caso ainda não existam
if (!variable_global_exists("global_xp")) global_xp = 0;
if (!variable_global_exists("global_xp_max")) global_xp_max = 100;
if (!variable_global_exists("global_nivel")) global_nivel = 1;
if (!variable_global_exists("global_show_levelup_timer")) global_show_levelup_timer = 0;

// Adiciona XP do inimigo
global_xp += 50;

// Level Up
if (global_xp >= global_xp_max) {
    global_xp = 0;
    global_nivel += 1;
    global_show_levelup_timer = 90; // 1,5s de mensagem
    if (sound_exists(level_up_SFX)) sound_play(level_up_SFX);
}

// Destrói o inimigo
instance_destroy();
