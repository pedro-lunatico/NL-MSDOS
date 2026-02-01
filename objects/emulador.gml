#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Caminho da pasta onde os Included Files serão exportados automaticamente
game_folder = working_directory + "\GameData\";

/// Caminhos completos dos arquivos na pasta
bat_path = game_folder + "ROM_NORDION_LANDS.BAT";
emu_path = game_folder + "vba.exe";
rom_path = game_folder + "game.gb";

/// Flag para não abrir mais de uma vez
bat_opened = false;
#define Mouse_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=321
invert=0
arg0=CARRENGANDO GRAVAÇÃO DAS CAMERAS POV PRIMEIRA DIMENSAO DA CIENCIA
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///emulador
// Ao clicar no objeto, abre o .BAT que executa o emulador
if (!bat_opened && file_exists(bat_path)) {
    execute_program(bat_path, false, false);
    bat_opened = true;
} else if (!file_exists(bat_path)) {
    show_message("Erro: .BAT não encontrado em " + bat_path);
}
