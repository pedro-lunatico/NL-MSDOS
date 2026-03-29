#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// --- Create Event: Fergus_OBJ ---

// 1. Variáveis de Estado e Controle (IA)
state = 0;
timer_estado = 200 + random(300);
learning_timer = 0;
target_obj = noone;
texto_balao = "";
timer_balao = 0;
flash_timer = 0;

// 2. Inicialização das Listas
minhas_falas = ds_list_create();
opcoes_da_vez = ds_list_create();

// 3. A GAMBIARRA TÉCNICA (Correção sem mudar o script)
// Em vez de passar a lista por argumento, nós a colocamos na global
// que o seu script está tentando usar lá dentro.
global.f_falas = minhas_falas;

// 4. CHAMADA DO SCRIPT (Sem argumentos para não dar erro)
scr_Fergus_Dialogos();

// 5. Identificação para a Mente de Colmeia
npc_nome = "Fergus";
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
