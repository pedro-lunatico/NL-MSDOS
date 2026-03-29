#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// CREATE EVENT

// ================================
// Inicializa variáveis do portal
// ================================
dialogo_ativo = false;   // impede que o diálogo se repita
velocidade = 2;          // se você quiser controlar animação, mas não usado com show_message

// Room de destino
rm_destino = EVA_EMBLEM_HANGAR;

// Raio de ativação (não obrigatório se usar só Collision)
raio_ativacao = 32;

// ================================
// Define as falas do diálogo
// ================================
falas[0] = "Eu tenho que me transformar para passar por aqui.";
falas[1] = "Para me mover nessa transformação eu uso o teclado.";
falas[2] = "Z para atacar, X para pular e as setas para se mover.";

// Número total de falas
total_falas = 3;

// Inicializa o texto atual e contador (não usados com show_message, mas podem ficar)
texto = "";
caracteres = 0;
contador = 0;
fala_atual = 0;
#define Collision_player
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Collision Event com player

if (!dialogo_ativo) {
    dialogo_ativo = true;

    // Garante que a variável global existe
    if (!variable_global_exists("global_nivel")) global_nivel = 1;

    if (global_nivel < 3) {
        // Teleporta o player para coordenadas seguras (exemplo: x=100, y=100)
        other.x = 416;
        other.y = 128;

        // Mostra mensagem de nível insuficiente
        show_message("Você precisa ser nível 3 para passar!");

        dialogo_ativo = false; // permite tentar novamente
    }
    else {
        // Mostra cada fala sequencialmente
        for (i = 0; i < total_falas; i += 1) {
            show_message(falas[i]);
        }

        // Teleporta para a room de destino
        room_goto(rm_destino);
    }
}
