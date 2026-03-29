#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Quantidade de inimigos por vez
qtd_inimigos = 1;

// Delay entre ondas (8 segundos)
delay_entre_ondas = 8 * room_speed;

// Inicia o ciclo de criação
alarm[0] = 1;
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Verifica se a quantidade de Namis na sala é menor que 8
if (instance_number(Nami_Guerreira) < 8) {
    px = random(room_width);
    py = random(room_height);

    // Cria apenas uma instância
    instance_create(px, py, Nami_Guerreira);
}

// Reinicia o alarme para tentar criar novamente após o delay
alarm[0] = delay_entre_ondas;
#define Mouse_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=211
invert=0
arg0=dano_de_espada
arg1=0
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=532
relative=1
applies_to=self
invert=0
arg0=8
arg1=0
arg2=0
arg3=2
arg4=33023
arg5=0
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=203
applies_to=self
invert=0
*/
