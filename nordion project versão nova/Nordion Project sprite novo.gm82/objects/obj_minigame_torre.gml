#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// --- Status de Jogo ---
global.pontos = 0;
global.estabilidade = 100;
global.estado_jogo = "SINTONIZANDO"; // Estados: SINTONIZANDO, RITMO, ALARME
global.combo = 0;
global.pontos = 0;
nota_y = 260; // Posição inicial da nota (embaixo para subir)
sinc_timer = 0;

// --- Mecânica de Sintonia (Tablet Jolyne Kujo) ---
global.frequencia_alvo = random(1);
global.frequencia_atual = 0.5;
margem_erro = 0.12; // Tolerância para sincronização no tablet

// --- Variáveis de Ritmo (Project Diva / Rhythm Heaven) ---
nota_x = 640;           // Posição inicial da nota vindo da direita
nota_tecla = vk_anykey; // Tecla que o jogador deve apertar
nota_ativa = false;     // Se existe uma nota na tela no momento
distancia_alvo = 400;   // O x central do monitor onde o acerto deve ocorrer
batida_dupla = 0;       // Contador para o desafio rítmico de emergência

// --- Interface e Estética ---
msg_radio = "Aguardando sinal...";
shaking = 0;            // Intensidade do tremor da tela
cor_neon = make_color_rgb(180, 50, 255); // Roxo industrial da Engage
faisca_timer = 0;       // Timer para controlar a animação das faíscas no gabinete

// --- Configuração do Alarme de Tutorial ---
// O manual aparece após 8 frames para dar tempo do jogo carregar
alarm[11] = 8;
#define Alarm_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=321
invert=0
arg0=vamos para olhar o manual para garantir que eu não cometa nenhum erro
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var texto_manual;

texto_manual = "ENGAGE AIRLINES - MANUAL DE OPERAÇÕES TÉCNICAS" + "#" +
                 "UNIDADE DE PROCESSAMENTO: JOLYNE KUJO" + "#" +
                 "OPERADORA: CHARLOTTE (SÉRIE-CLONE 7E848B)" + "#" +
                 "--------------------------------------------------" + "#" +
                 "DIRETRIZES DE SINCRONIA MOLECULAR:" + "#" +
                 "#" +
                 "I. FASE DE SINTONIA (MOUSE):" + "#" +
                 "Mantenha o sinal no espectro VERDE para abrir o portal." + "#" +
                 "#" +
                 "II. SINCRONIA RÍTMICA (SETAS DO TECLADO):" + "#" +
                 "Vetores direcionais voarão para o centro. Pressione a SETA " +
                 "correspondente quando o ícone sobrepor o ALVO circular." + "#" +
                 "#" +
                 "III. PROTOCOLO DE ESTABILIZAÇÃO (ESPAÇO):" + "#" +
                 "Em caso de alarme, pressione a tecla ESPAÇO em cadência " +
                 "dupla imediata (TOQUE-TOQUE) para evitar o colapso." + "#" +
                 "#" +
                 "IV. AVISO DE DEDUÇÃO FINANCEIRA:" + "#" +
                 "Falhas operacionais resultam em multas de patrimônio e " +
                 "taxação de risco biológico. A eficiência é obrigatória." + "#" +
                 "--------------------------------------------------" + "#" +
                 "INICIAR TRANSMISSÃO AGORA?";

show_message(texto_manual);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// --- 1. GESTÃO DE IMPACTO E SHAKE ---
if (shaking > 0) shaking -= 0.5;

// --- 2. MÁQUINA DE ESTADOS (SINTONIA -> RITMO) ---
switch (global.estado_jogo) {

    case "SINTONIZANDO":
        // Configuração dos limites do Slider no Tablet
        var bx1, bx2, bl;
        bx1 = 280 + 30; // tablet_x + offset
        bx2 = 280 + 190;
        bl = bx2 - bx1;

        // Lógica de arrastar o Slider no Tablet
        if (mouse_check_button(mb_left)) {
            if (mouse_x >= bx1 && mouse_x <= bx2 && mouse_y > 350) {
                global.frequencia_atual = (mouse_x - bx1) / bl;
            }
        }

        // Verifica se a onda está sintonizada (Reage ao seu Draw das ondas)
        if (abs(global.frequencia_atual - global.frequencia_alvo) < 0.05) {
            sinc_timer += 1;
            if (sinc_timer > 30) {
                global.estado_jogo = "RITMO";
                sinc_timer = 0;
                global.combo = 0;
                // Chama seu script ao iniciar a fase de ritmo
                script_execute(scr_gerar_insulto_tp_jk);
            }
        } else {
            sinc_timer = 0;
        }
    break;

    case "RITMO":
        // --- GERAR NOTAS DDR (SUBINDO) ---
        if (nota_ativa == false) {
            var r_tecla; r_tecla = irandom(3);
            if (r_tecla == 0) nota_tecla = vk_left;
            if (r_tecla == 1) nota_tecla = vk_down;
            if (r_tecla == 2) nota_tecla = vk_up;
            if (r_tecla == 3) nota_tecla = vk_right;

            nota_y = 260; // Começa na base do monitor para subir
            nota_ativa = true;
        }

        // Velocidade baseada no combo (Estilo FNF)
        nota_y -= (6 + (global.combo / 10));

        // --- DETECÇÃO DE INPUT (TECLADO) ---
        if (keyboard_check_pressed(vk_anykey)) {
            if (keyboard_check_pressed(nota_tecla)) {
                // Janela de acerto (topo do monitor)
                if (nota_y > 10 && nota_y < 75) {
                    global.combo += 1;

                    // GANHOS ALTOS (Foco em D$ 5.000)
                    var valor_nota;
                    valor_nota = 100 + (global.combo * 20);
                    global.money += valor_nota;
                    global.pontos += 150;

                    nota_ativa = false;
                    shaking = 1;
                } else {
                    // ERRO DE TIMING
                    global.estabilidade -= 5;
                    global.combo = 0;
                    nota_ativa = false;
                    shaking = 8;
                    // O rádio insulta Charlotte por falhar no tempo
                    script_execute(scr_gerar_insulto_tp_jk);
                }
            } else {
                // APERTOU A TECLA ERRADA
                global.estabilidade -= 7;
                global.combo = 0;
                nota_ativa = false;
                shaking = 12;
                // O rádio insulta a "falta de alma" do modelo Jolyne Kujo
                script_execute(scr_gerar_insulto_tp_jk);
            }
        }

        // Se a nota passar direto (MISS)
        if (nota_y < -40) {
            nota_ativa = false;
            global.combo = 0;
            global.estabilidade -= 10;
            // Insulto por negligência
            script_execute(scr_gerar_insulto_tp_jk);
        }

        // A cada 1200 pontos, volta para a sintonia
        if (global.pontos > 0 && (global.pontos mod 1200 == 0)) {
            global.estado_jogo = "SINTONIZANDO";
            global.frequencia_alvo = random(1);
        }
    break;
}

// --- 3. CONDIÇÃO DE DERROTA (SISTEMA DE LUCRO 5K) ---
if (global.estabilidade <= 0) {
    var lucro_base, imposto, total_final;

    lucro_base = floor(global.pontos * 4.2); // Escala para atingir a meta de 5k
    imposto = floor(lucro_base * 0.15);
    total_final = lucro_base - imposto - 300; // 300 é a multa fixa

    global.money += total_final;

    show_message("!!! TURNO FINALIZADO !!!" + "#" +
                 "------------------------------------" + "#" +
                 "Ganhos por Performance: + D$ " + string(lucro_base) + "#" +
                 "Imposto de Origem Sintetica: - D$ " + string(imposto) + "#" +
                 "Multa por Colapso de Sinal: - D$ 300" + "#" +
                 "------------------------------------" + "#" +
                 "Rendimento Liquido: D$ " + string(total_final) + "#" +
                 "Saldo Total: D$ " + string(global.money) + "#" +
                 "------------------------------------" + "#" +
                 "Charlotte foi advertida.por má conduta.");

    room_goto(TP_JOLYNE_KUJO);
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// --- 1. CONFIGURAÇÕES ---
var monitor_x, monitor_y, tablet_x, tablet_y, hud_y;
monitor_x = 240; monitor_y = 60;
tablet_x = 280;  tablet_y = 350;
hud_y = room_height - 60;

var sx, sy, tremor_mao;
sx = random_range(-shaking, shaking);
sy = random_range(-shaking, shaking);
tremor_mao = 0; if (global.estabilidade < 45) tremor_mao = random_range(-2, 2);

// --- 2. MONITOR CRT ---
draw_set_color(make_color_rgb(40, 40, 45));
draw_roundrect(monitor_x-5+sx, monitor_y-5+sy, monitor_x+405+sx, monitor_y+255+sy, false);
draw_set_color(c_black);
draw_rectangle(monitor_x+sx, monitor_y+sy, monitor_x+400+sx, monitor_y+250+sy, false);

// --- [ONDAS DE RÁDIO SINTONIZANDO] ---
// Desenha ondas mesmo no modo ritmo, mas elas ficam "calmas" ou "frenéticas"
var i, amplitude, cor_onda;
amplitude = 15;
if (global.estado_jogo == "SINTONIZANDO") {
    // A amplitude da onda aumenta conforme você erra a sintonia
    amplitude = abs(global.frequencia_atual - global.frequencia_alvo) * 100;
}

cor_onda = make_color_rgb(0, 255, 100); // Verde rádio
if (amplitude > 30) cor_onda = make_color_rgb(200, 50, 255); // Roxo se estiver fora de sintonia

draw_set_color(cor_onda);
for (i = 0; i < 400; i += 5) {
    var yy1, yy2;
    yy1 = sin((current_time * 0.02) + (i * 0.1)) * amplitude;
    yy2 = sin((current_time * 0.02) + ((i+5) * 0.1)) * amplitude;
    draw_line(monitor_x + i + sx, monitor_y + 125 + yy1 + sy, monitor_x + i + 5 + sx, monitor_y + 125 + yy2 + sy);
}

// --- [SETAS ESTILO DDR (TRIÂNGULOS)] ---
if (global.estado_jogo == "RITMO") {
    // Alvos no topo (Triângulos vazios)
    for (i = 0; i < 4; i += 1) {
        draw_set_color(c_white); draw_set_alpha(0.3);
        var tx, ty; tx = monitor_x + 80 + (i*80) + sx; ty = monitor_y + 40 + sy;
        draw_triangle(tx-20, ty+15, tx, ty-15, tx+20, ty+15, true); // Desenha contorno da seta
    }
    draw_set_alpha(1);

    // Nota Ativa (Triângulo Preenchido)
    if (nota_ativa) {
        var col_n, cor_n;
        col_n = 0; cor_n = c_purple; // Left
        if (nota_tecla == vk_down)  { col_n = 1; cor_n = c_aqua; }
        if (nota_tecla == vk_up)    { col_n = 2; cor_n = c_lime; }
        if (nota_tecla == vk_right) { col_n = 3; cor_n = c_red; }

        var nx, ny;
        nx = monitor_x + 80 + (col_n * 80) + sx;
        ny = monitor_y + nota_y + sy;

        draw_set_color(cor_n);
        // Desenha a seta apontando para a direção certa
        if (nota_tecla == vk_up)    draw_triangle(nx-20, ny+20, nx, ny-20, nx+20, ny+20, false);
        if (nota_tecla == vk_down)  draw_triangle(nx-20, ny-20, nx, ny+20, nx+20, ny-20, false);
        if (nota_tecla == vk_left)  draw_triangle(nx+20, ny-20, nx-20, ny, nx+20, ny+20, false);
        if (nota_tecla == vk_right) draw_triangle(nx-20, ny-20, nx+20, ny, nx-20, ny+20, false);
    }
}

// --- 3. TABLET E HUD ---
// (Mantenha o código do Tablet e do HUD que enviamos anteriormente,
// garantindo que o slider atualize a global.frequencia_atual)
draw_sprite_ext(hand_segurando, 0, tablet_x + tremor_mao + 40, tablet_y + tremor_mao + 60, 1.2, 1.2, 0, c_white, 1);
draw_set_color(c_white); draw_roundrect(tablet_x+tremor_mao, tablet_y+tremor_mao, tablet_x+220+tremor_mao, tablet_y+160+tremor_mao, false);
draw_set_color(make_color_rgb(0, 120, 255)); draw_rectangle(tablet_x+10+tremor_mao, tablet_y+10+tremor_mao, tablet_x+210+tremor_mao, tablet_y+120+tremor_mao, false);

if (global.estado_jogo == "SINTONIZANDO") {
    var b_x1, b_x2, b_y, k_x;
    b_x1 = tablet_x + 30; b_x2 = tablet_x + 190; b_y = tablet_y + 65;
    draw_set_color(c_black); draw_line_width(b_x1, b_y, b_x2, b_y, 4);
    k_x = b_x1 + (global.frequencia_atual * (b_x2 - b_x1));
    draw_set_color(c_white); draw_circle(k_x, b_y, 18, false); // Knob maior para facilitar
}

draw_set_color(c_black); draw_set_alpha(0.8);
draw_rectangle(0, hud_y, room_width, room_height, false);
draw_set_alpha(1);
draw_set_color(c_yellow); draw_text(30, hud_y + 20, "CARTEIRA: D$ " + string(global.money));
draw_set_color(c_lime); draw_text(room_width - 160, hud_y + 20, "COMBO: x" + string(global.combo));
draw_healthbar(room_width/2 - 100, hud_y + 25, room_width/2 + 45, hud_y + 45, global.estabilidade, c_dkgray, c_red, c_lime, 0, true, true);
