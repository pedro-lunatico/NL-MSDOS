#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Clique direito para remover móvel
if (mouse_check_button_pressed(mb_right)) {
    if (position_meeting(mouse_x, mouse_y, id)) {

        // remove da lista global
        i = 0;
        while (i < ds_list_size(global.furniture_list)) {
            it = ds_list_find_value(global.furniture_list, i);
            gx = ds_list_find_value(it, 1);
            gy = ds_list_find_value(it, 2);

            if (gx * global.CELL == x && gy * global.CELL == y) {
                ds_list_delete(global.furniture_list, i);
                ds_list_destroy(it);
                break;
            }
            i += 1;
        }

        // destrói objeto
        instance_destroy();
    }
}
#define Mouse_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=224
invert=0
arg0=TV_SCREEN_ROOM
arg1=13
*/
