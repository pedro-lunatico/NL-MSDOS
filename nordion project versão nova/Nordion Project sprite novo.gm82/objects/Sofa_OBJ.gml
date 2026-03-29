#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// --- Inicialização do Spawner ---
dew_criado = false;
offset_x = 48; // Distância para o Dew não nascer em cima do spawner
offset_y = 0;
price = 700; // Cada móvel com seu valor
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// --- Controle de Spawn e Remoção ---

// 1. Lógica de Spawn (Apenas se Casado)
if (instance_exists(Relationship_control)) {
    var ctrl;
    ctrl = instance_find(Relationship_control, 0);

    if (global.casado && !dew_criado) {
        // Verifica se já existe um Dew na room para não duplicar
        if (instance_number(Dew_relationship) == 0) {
            instance_create(x + offset_x, y + offset_y, Dew_relationship);
            dew_criado = true;
        }
    }
}

// Clique direito para remover móvel e ganhar reembolso
if (mouse_check_button_pressed(mb_right)) {
    if (position_meeting(mouse_x, mouse_y, id)) {

        // Devolve o dinheiro (Reembolso total)
        global.money += price;

        // Se você ainda usa a global.furniture_list para salvar:
        if (variable_global_exists("furniture_list")) {
            var i, it, gx, gy;
            for (i = 0; i < ds_list_size(global.furniture_list); i += 1) {
                it = ds_list_find_value(global.furniture_list, i);
                gx = ds_list_find_value(it, 1);
                gy = ds_list_find_value(it, 2);

                if (gx * global.CELL == x && gy * global.CELL == y) {
                    ds_list_delete(global.furniture_list, i);
                    ds_list_destroy(it);
                    break;
                }
            }
        }

        // Destrói a instância
        instance_destroy();
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_self();
