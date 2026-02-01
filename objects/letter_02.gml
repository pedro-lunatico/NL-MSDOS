#define Collision_FPS_PLAYER
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=321
invert=0
arg0=seu irmao esta com o THE Letter
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=321
invert=0
arg0=vc:que jogo merda eu tenho mais oque fazer doque jogar essa Bosta
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// --- Troca segura de room (compatível com GM8.1) ---

// Fecha o modo 3D antes de trocar (evita bugs visuais)
d3d_end();

// Salva a posição e direção do jogador
global.player_x = other.x;
global.player_y = other.y;
global.player_z = other.z;
global.player_dir = other.direction;

// Marca que está trocando de room
global.room_trocando = true;

// Troca para a nova room (mude o nome aqui!)
room_goto(Charlotte_APT);
