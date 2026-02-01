#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// A velocidade e direção são definidas pelo Nami_Burglar
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Destrói o tiro se sair da room
if (x < 0 || x > room_width || y < 0 || y > room_height) {
    instance_destroy();
}
#define Collision_player
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Incrementa hits recebidos
player_hits += 1;

// Destroi o tiro do player
instance_destroy();
