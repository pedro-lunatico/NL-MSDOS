#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// ===== INICIALIZAR VARIÁVEIS =====
pspeedx = 0;       // velocidade horizontal
pspeedy = 0;       // velocidade vertical
psize = 4;         // tamanho da partícula
pcolor = c_red;    // cor da partícula
plife = 60;        // duração em steps
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// ===== MOVIMENTO =====
x += pspeedx;
y += pspeedy;

/// ===== REDUZIR VIDA =====
plife -= 1;
if (plife <= 0) instance_destroy();

/// ===== CHECAR COLISÃO COM PLAYER =====
if (place_meeting(x, y, Player_Wonder_Boy)) {
    with (Player_Wonder_Boy) {
        damage_taken += 1;   // aumenta o dano do player
    }
    instance_destroy();       // destrói a partícula ao tocar no player
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// ===== DESENHAR PARTÍCULA =====
draw_set_color(pcolor);
draw_circle(x, y, psize, false);
