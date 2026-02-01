#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// --- Inicialização do Diálogo Estilo Aero ---

dialogo_ativo = true;
fala_atual = 0;
caracteres = 0;
contador = 0;
velocidade = 2;
fase = 0;
opcao_escolhida = 0;

cor_vidro = make_color_rgb(150, 220, 255);
cor_brilho = c_white;

// --- Textos (Agora com tags corretas) ---
fala0 = "Fergus;esta olhando o que? Falha Genetica?";
fala1 = "vc; o que e Respondo?";

fala1_0 = "vc; estou apenas fazendo a ronda";
fala1_1 = "Fergus; acho bom";

fala2_0 = "vc; porque voce nao vai cuidar da sua vida?";
fala2_1 = "Fergus; voce esta brincando com o perigo... cria de becker";

fala3_0 = "vc;até mais Sr Mei kkkkkk";
fala3_1 = "Fergus;sua cria de becker volta aqui voce save muito bem que eu não quero ser um Mei ";

max_falas_opcao1 = 2;
max_falas_opcao2 = 2;
max_falas_opcao3 = 2;

texto = "";
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// --- LÓGICA DE MOVIMENTO (Já adaptada para GM8.1) ---
var _key_left, _key_right, _key_up, _key_down;
_key_left  = keyboard_check(vk_left);
_key_right = keyboard_check(vk_right);
_key_up    = keyboard_check(vk_up);
_key_down  = keyboard_check(vk_down);

// Checa Inatividade
if (keyboard_check(vk_anykey)) {
    idle_timer = 0;
    show_idle_balloon = false;
    caracteres = 0; // Reseta digitação do balão
} else {
    idle_timer += 1;
    if (idle_timer >= idle_limit) {
        show_idle_balloon = true;
    }
}

// Movimentação e Drift (Código anterior otimizado)
var _max_vel;
if (boost_timer > 0) { _max_vel = boost_speed; boost_timer -= 1; } else { _max_vel = move_speed; }

if (_key_left)  { hsp -= 0.5; facing = -1; }
if (_key_right) { hsp += 0.5; facing = 1;  }
if (!_key_left && !_key_right) { hsp -= sign(hsp) * 0.4; if (abs(hsp) < 0.5) hsp = 0; }
if (_key_up)    { vsp -= 0.5; }
if (_key_down)  { vsp += 0.5; }
if (!_key_up && !_key_down) { vsp -= sign(vsp) * 0.4; if (abs(vsp) < 0.5) vsp = 0; }

// Colisão Slide
if (place_meeting(x + hsp, y, solido)) { while (!place_meeting(x + sign(hsp), y, solido)) x += sign(hsp); hsp = 0; }
x += hsp;
if (place_meeting(x, y + vsp, solido)) { while (!place_meeting(x, y + sign(vsp), solido)) y += sign(vsp); vsp = 0; }
y += vsp;

// --- LÓGICA DO BALÃO FRUTIGER ---
if (show_idle_balloon) {
    texto_balao = "vc; vai vai anda"; // Tag para mostrar o portrait da Charlotte/Fir
    if (caracteres < string_length(texto_balao)) {
        contador += 1;
        if (contador >= velocidade) {
            caracteres += 1;
            contador = 0;
        }
    }
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=211
invert=0
arg0=The Conote Empire
arg1=1
*/
#define Other_5
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=212
invert=0
arg0=The Conote Empire
*/
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// 1. Desenha o Cavalo
draw_self();

// 2. HUD de Drift Simples
if (drift_meter > 0) {
    draw_set_color(c_aqua);
    draw_rectangle(x-20, y-45, x-20+(drift_meter/drift_max)*40, y-42, false);
}

// 3. BALÃO DE AVISO (INTERFACE AERO)
if (show_idle_balloon) {
    var vx, vy, vw, vh, dy, dh, bx, bw;
    vx = view_xview[0]; vy = view_yview[0];
    vw = view_wview[0]; vh = view_hview[0];

    dh = 80; // Altura menor para o balão de aviso
    dy = vy + vh - dh - 20;

    // --- Portrait Charlotte ---
    if (string_pos("vc;", texto_balao) > 0) {
        var px, h_p;
        px = vx + 40;
        h_p = sprite_get_height(spr_portrait_charlotte);
        draw_sprite_ext(spr_portrait_charlotte, 0, px, dy - h_p + 10, 0.8, 0.8, 0, c_white, 1);
    }

    // --- CAIXA FRUTIGER AERO GLASS ---
    // Sombra suave
    draw_set_alpha(0.3);
    draw_roundrect_color(vx+30, dy+4, vx+vw-30, dy+dh+4, c_black, c_black, false);

    // Fundo Vidro Azulado
    draw_set_alpha(0.7);
    draw_roundrect_color(vx+30, dy, vx+vw-30, dy+dh, cor_vidro, c_white, false);

    // Brilho Glossy Superior (O toque Frutiger Aero)
    draw_set_alpha(0.4);
    draw_ellipse_color(vx+60, dy+2, vx+vw-60, dy+dh/2, c_white, cor_vidro, false);

    // Borda Branca Fina
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_roundrect(vx+30, dy, vx+vw-30, dy+dh, true);

    // --- TEXTO DIGITADO ---
    draw_set_color(c_black);
    draw_set_font(-1); // Use sua fonte de diálogo aqui

    var t_exibir;
    t_exibir = string_replace(texto_balao, "vc;", "");

    // Desenha apenas os caracteres processados no Step
    draw_text_ext(vx+120, dy+25, string_copy(t_exibir, 1, caracteres), 18, vw-180);
}
