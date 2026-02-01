#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Configurações
dist_min = 100;                     // distância para parar
velocidade_path = 4;                // velocidade do NPC na path
seguindo_path = true;               // estado inicial
pos_guardada = 0;                   // posição salva da path

// Sprite inicial (movendo)
sprite_index = Nami_stewardess_moving;
image_index = 0;
image_speed = 0.2;

// Começa seguindo a path e repete quando terminar
path_start(Nami_stewardess3_Path, velocidade_path, 1, false);
// 1 = path_action_restart, false = posição relativa
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Se estiver perto do player: para a path e troca sprite
if (distance_to_object(player) < dist_min) {
    if (seguindo_path) {
        pos_guardada = path_position;           // salva posição atual da path
        path_end();                             // para a path
        speed = 0;
        sprite_index = Nami_stewardess2;       // sprite de parado
        image_index = 0;
        image_speed = 0.2;
        seguindo_path = false;                  // marca que parou
    }
}
// Se o player se afastou: retoma a path e sprite de andar
else {
    if (!seguindo_path) {
        sprite_index = Nami_stewardess_moving; // sprite de andar
        image_index = 0;
        image_speed = 0.2;
        path_start(Nami_stewardess3_Path, velocidade_path, 1, false); // retoma path e repete
        path_position = pos_guardada;           // continua de onde parou
        seguindo_path = true;                    // marca que voltou a seguir
    }
}
#define Mouse_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=321
invert=0
arg0=Nami:Bem vinda a Teleporto Jolyne Kujo
*/
