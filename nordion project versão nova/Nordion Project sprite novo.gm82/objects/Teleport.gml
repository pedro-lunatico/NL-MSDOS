#define Collision_player
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Fergus Interior -> Title Screen
if room_get_name(room) == "Fergus Interior" {
    room_goto(Title_Screen);
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Testing -> Main Menu

if room_get_name(room) == "Testing" {
    room_goto(Title_Screen);
}
