#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.prox_som <= 0) {
    // Escolhe um som aleatório da lista
    index = irandom(ds_list_size(global.sons) - 1); // sem "var"
    som = ds_list_find_value(global.sons, index);

    // Toca o som
    sound_play(som);

    // Define cooldown aleatório entre 1 e 7 minutos (60 a 420 segundos)
    global.prox_som = room_speed * (60 + irandom(360));
} else {
    global.prox_som -= 1;
}
#define Collision_player_RE3
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=211
invert=0
arg0=Nami_factory_grunidos
arg1=0
*/
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Cria a lista de sons
global.sons = ds_list_create();
ds_list_add(global.sons, torture_ambience_1);
ds_list_add(global.sons, torture_ambience_2);
ds_list_add(global.sons, torture_ambience_3);
ds_list_add(global.sons, torture_ambience_4);
ds_list_add(global.sons, torture_ambience_5);

// Inicializa cooldown (em steps)
global.prox_som = 0;
