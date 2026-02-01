#define Mouse_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Inicializa variável do controlador
ctrl = noone;

// Verifica se existe pelo menos uma instância do controlador
if (instance_exists(controlador_usina_mikubyl)) {
    ctrl = instance_find(controlador_usina_mikubyl, 0); // pega a primeira instância
}

// Aplica efeito se controlador encontrado
if (ctrl != noone) {
    ctrl.Temperatura -= 100;
    if (ctrl.Temperatura < 0) ctrl.Temperatura = 0;
    ctrl.powerup_timer = room_speed * 5;

    // Remove o power-up
    instance_destroy();
}
