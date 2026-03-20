#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Configuração de Perspectiva
dificuldade = 1.2;
ia_speed = 10 * dificuldade;

// Variáveis de Posição 3D
z_rival = 500;   // Distância (Z) - Quanto maior, mais longe
x_rival = 0;     // Posição lateral relativa ao centro (-100 a 100)

// Configurações da Câmera Pseudo-3D
camera_z = 0;
horizonte_y = 160; // Linha do horizonte na tela
focal_length = 200; // Ajusta a intensidade da perspectiva
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Desenho do Rival com Profundidade

// Definimos o horizonte (mesmo Y onde a pista "começa")
horizon_y = 160;

// O Y do desenho desce conforme o objeto aumenta (fica mais perto da base da tela)
draw_y = horizon_y + (fator_escala * 60);

// Desenha o sprite do inimigo com a escala calculada
// O 'c_red' ajuda a diferenciar do player se você usar o mesmo sprite
draw_sprite_ext(spr_inimigo, image_index, ia_x, draw_y, fator_escala, fator_escala, 0, c_white, 1);

// EFEITO DE PRESSÃO (Luzes no retrovisor)
// Se ele estiver muito perto atrás, desenhamos um brilho branco
if (distancia_rival < 80 && distancia_rival > 0) {
    draw_set_alpha(0.3);
    draw_circle_color(ia_x, draw_y, 40 * fator_escala, c_white, c_black, false);
    draw_set_alpha(1);
}
