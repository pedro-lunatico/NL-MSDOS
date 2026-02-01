#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Verifica se o NPC está se movendo no path
if (path_speed != 0) {
    // Ativa animação
    image_speed = 1;

    // Verifica direção horizontal para inverter sprite
    if (x > xprevious) {
        image_xscale = 1; // indo pra direita
    } else if (x < xprevious) {
        image_xscale = -1; // indo pra esquerda
    }

} else {
    // Parado
    image_index = 0;   // trava no primeiro frame
    image_speed = 0;
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=119
applies_to=self
invert=0
arg0=Nami_stewardess2_Path
arg1=4
arg2=1
arg3=0
*/
