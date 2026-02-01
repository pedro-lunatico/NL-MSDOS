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
arg0=Fergus:ta olhando oque falha genetica
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Salvar a posição do Player antes de trocar de room
global.saved_x = player.x;
global.saved_y = player.y;

// Salvar o jogo inteiro (save real)
game_save(global.save_path);

// Indicar para carregar na próxima room
global.load_next_room = true;

// Trocar de room
room_goto(Fergus_Dialogue);
#define Mouse_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Mouse Right Pressed Event do objeto
if (!sound_isplaying(Fergus_Pain)) {
    sound_play(Fergus_Pain);
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=211
invert=0
arg0=Fergus Theme
arg1=1
*/
