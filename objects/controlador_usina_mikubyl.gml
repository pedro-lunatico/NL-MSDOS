#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Configurações Iniciais
vareta_altura = 0;       // 0 (totalmente inserida) a 100 (totalmente levantada)
energia_total = 0;
temperatura = 300;       // Temperatura base em Kelvin
pressao = 101325;        // Pressão base (Mikuscascais)
alarme_ativo = false;
derretimento_iminente = false;
game_over = false;
energia_gerada = 0;

// Configurações de Dinheiro
global.money = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// --- EVENTO STEP - obj_controlador_usina_mikubyl ---

// Se o jogo acabou, para a execução da lógica
if (game_over == true) { exit; }

// 1. CONTROLES DAS VARETAS (UP / DOWN)
if (keyboard_check(vk_up) || (mouse_check_button(mb_left) && position_meeting(mouse_x, mouse_y, obj_btn_up))) {
    vareta_altura += 0.5;
}
if (keyboard_check(vk_down) || (mouse_check_button(mb_left) && position_meeting(mouse_x, mouse_y, obj_btn_down))) {
    vareta_altura -= 0.5;
}

// Limita a vareta entre 0 (seguro) e 100 (potência máxima)
vareta_altura = clamp(vareta_altura, 0, 100);


// 2. FÍSICA E GERAÇÃO (Mikuscascais e Temperatura)
energia_gerada = vareta_altura * 1.5;
energia_total += energia_gerada;

// Calor: Sobe com a vareta, resfriamento natural de 1.5 por frame
temperatura += (vareta_altura * 0.05) - 1.5;
if (temperatura < 300) { temperatura = 300; }

// Pressão em Mikuscascais (Calculada para ser tensa)
pressao = temperatura * 337;


// 3. SISTEMA DE ALARME (Mikubyl_Alarm_SFX)
if (temperatura > 1200 || pressao > 500000) {
    if (alarme_ativo == false) {
        sound_loop(Mikubyl_Alarm_SFX);
        alarme_ativo = true;
    }
    derretimento_iminente = true;
} else {
    if (alarme_ativo == true) {
        sound_stop(Mikubyl_Alarm_SFX);
        alarme_ativo = false;
    }
    derretimento_iminente = false;
}


// 4. BOTÃO SCRAM (ESPAÇO) - FINALIZAÇÃO SEGURA COM TAXAS
if (keyboard_check_pressed(vk_space) || (mouse_check_button_pressed(mb_left) && position_meeting(mouse_x, mouse_y, obj_btn_space))) {
    game_over = true;
    sound_stop(Mikubyl_Alarm_SFX);

    // Cálculo de Lucro Líquido (25% do bruto após impostos)
    var lucro_bruto; lucro_bruto = floor(energia_total / 3);
    var imposto_ind; imposto_ind = floor(lucro_bruto * 0.40);
    var taxa_clone; taxa_clone = floor(lucro_bruto * 0.35);
    var lucro_final; lucro_final = lucro_bruto - imposto_ind - taxa_clone;

    global.money += lucro_final;

    show_message("SCRAM BEM SUCEDIDO!" + "#" +
                 "Lucro Bruto: " + string(lucro_bruto) + "#" +
                 "Impostos Industriais (40%): -" + string(imposto_ind) + "#" +
                 "Taxa de Clone (35%): -" + string(taxa_clone) + "#" +
                 "Total Creditado: " + string(lucro_final));
}


// 5. CONDIÇÃO DE EXPLOSÃO - PREJUÍZO POR PRESSÃO
if (temperatura > 2500) {
    game_over = true;
    sound_stop(Mikubyl_Alarm_SFX);

    // Lucro que ela teria ganho (antes da multa)
    var lucro_bruto; lucro_bruto = floor(energia_total / 3);
    var imposto_ind; imposto_ind = floor(lucro_bruto * 0.40);
    var taxa_clone; taxa_clone = floor(lucro_bruto * 0.35);
    var lucro_liquido; lucro_liquido = lucro_bruto - imposto_ind - taxa_clone;

    // MULTA CATASTRÓFICA: 15% da pressão em Mikuscascais
    var multa_explosao; multa_explosao = floor(pressao * 0.15);

    // Aplicação no saldo (Pode deixar a conta negativa!)
    global.money += lucro_liquido;
    global.money -= multa_explosao;

    show_message("!!! REATOR EXPLODIU !!!" + "#" +
                 "Ganhos do Turno: +" + string(lucro_liquido) + "#" +
                 "Multa por Dano ao Patrimonio: -" + string(multa_explosao) + "#" +
                 "A pressao de " + string(floor(pressao)) + " Mikuscascais destruiu tudo!" + "#" +
                 "Saldo Final: " + string(global.money));
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var yy; yy = y + 32; // Começa a desenhar 32 pixels abaixo do objeto

draw_set_color(c_orange);
draw_text(x, yy, "ENERGIA TOTAL: " + string(floor(energia_total)));
draw_text(x, yy + 20, "GERACAO ATUAL: " + string(energia_gerada) + " MW");
draw_text(x, yy + 40, "TEMPERATURA: " + string(floor(temperatura)) + " K");
draw_text(x, yy + 60, "PRESSAO: " + string(floor(pressao)) + " Mikuscascais");

// Barra de altura da vareta
draw_rectangle(x - 50, y - 10, x - 40, y + 100, true);
draw_rectangle(x - 50, y + 100, x - 40, y + 100 - vareta_altura, false);

// Alerta Vermelho
if (derretimento_iminente) {
    draw_set_color(c_orange);
    draw_text(x, yy + 90, "!!! ALERTA: DERRETIMENTO IMINENTE !!!");
    draw_text(x, yy + 110, "!!! RISCO DE EXPLOSAO !!!");
}
