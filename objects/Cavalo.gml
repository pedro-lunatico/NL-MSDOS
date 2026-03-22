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
action_id=603
applies_to=self
*/
if (ds_list_find_index(global.proibidas, room) == -1) {
    if (instance_exists(player)) {
        instance_create(player.x, player.y, Player_Horse);

        // Em vez de instance_destroy(), fazemos isso:
        player.visible = false;
        player.moving = false; // Para o movimento próprio dele

        x = -1000; // Move o cavalo estático para longe
    }
}
