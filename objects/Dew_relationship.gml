#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// --- Inicialização do Dew ---

// Destruição automática se já casou e está em Magvel
if (instance_exists(Relationship_control)) {
    if (Relationship_control.casado && room == magvel1) {
        instance_destroy();
        exit;
    }
}

// Listas de Diálogo (Obrigatório criar antes de carregar)
dialogos_desconhecido = ds_list_create();
dialogos_abracar_vc = ds_list_create();
dialogos_beijar_vc = ds_list_create();
dialogos_xingar_vc = ds_list_create();
dialogos_miata_vc = ds_list_create();
dialogos_conversar_vc = ds_list_create();
dialogos_consertar_vc = ds_list_create();

dialogos_abracar = ds_list_create();
dialogos_beijar = ds_list_create();
dialogos_xingar = ds_list_create();
dialogos_miata_dew = ds_list_create();
dialogos_conversar_dew = ds_list_create();
dialogos_inseguranca_dew = ds_list_create();
dialogos_preconceito_dew = ds_list_create();

dialogos_furia_becker = ds_list_create();
dialogos_furia_lorca = ds_list_create();

// Carrega os textos do script externo
scr_carregar_dialogos();

// Status e Controle
dew_health = 100;
respeito_total = 0;
is_berserk = false;
furia_ativa = false;
pode_clicar = false;
pending_dew_response = false;
botao_furia_pendente = false;

// Coalescer
fez_coalescer = false;
cooldown_coalescer = false;
dialogo_cooldown_coalescer = "Charlotte: Me solta, Dew. Eu to exausta... meu corpo nao aguenta mais isso agora. Me deixa em paz.";

// Visual e Menu
menu_ativo = false;
menu_raio = 0;
menu_raio_max = 120;
abertura_velocidade = 0.2;
cor_vidro = make_color_rgb(100, 200, 255); // Azul Ciano Aero
cor_brilho = c_white;
bubble_anim = 0;
texto_atual = "";
falando = "ninguem";
flash_alpha = 0;
flash_sentido = 1;
corte_ativo = false;
corte_anim = 0;
texto_timer = 0;
cutscene_berserk = false;
cutscene_timer = 0;
cutscene_alpha = 0;
faixa_largura = 0;

/// --- Controle de Expressão ---
face_charlotte = spr_portrait_charlotte;
face_dew = spr_portrait_dew;
shake_portrait = 0; //adrenalina
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// --- Step Event: Sistema de Relacionamento e Crise ---

var vx, vy, vw, vh, cx, cy;
vx = view_xview[0]; vy = view_yview[0];
vw = view_wview[0]; vh = view_hview[0];
cx = vx + vw/2; cy = vy + vh/2;

// --- 1. CONTROLE DA CUTSCENE BERSERK (ESTILO GOHAN) ---
if (cutscene_berserk) {
    cutscene_timer += 1;
    // Pular cutscene com clique
    if (mouse_check_button_pressed(mb_left) && cutscene_timer > 10) {
        cutscene_berserk = false;
        is_berserk = true;
        furia_ativa = true;
    }
    exit; // Pausa o restante da lógica enquanto a cena roda
}

// --- 2. PROGRESSÃO DE DIÁLOGO POR CLIQUE ---
if (pode_clicar && mouse_check_button_pressed(mb_left) && !menu_ativo) {
    if (pending_dew_response) {
        falando = "dew";

        // Resposta baseada no botão selecionado
        if (botao_selecionado == "coalescer") {
            if (cooldown_coalescer) {
                if (irandom(100) > 50) texto_atual = "Dew: Voce e tao fria... o Fergus avisou que clones nao amam.";
                else texto_atual = "Dew: Entendo... seu corpo Revolution nao aguenta muito, nao e?";
            } else {
                texto_atual = "Dew: Charlotte... voce e a unica coisa real que eu ja toquei.";
                cooldown_coalescer = true;
            }
        } else {
            // Seleciona das listas de script externo
            var lista_d;
            if (respeito_total < 30) lista_d = dialogos_preconceito_dew;
            else if (respeito_total < 80) lista_d = dialogos_inseguranca_dew;
            else lista_d = dialogos_conversar_dew;
            texto_atual = ds_list_find_value(lista_d, irandom(ds_list_size(lista_d)-1));
        }

        pending_dew_response = false;

        // GATILHO DE CRISE (BERSERK)
        var t_low; t_low = string_lower(string(texto_atual));
        if (string_pos("cria de becker", t_low) > 0 || string_pos("carne sintetica", t_low) > 0) {
            cutscene_berserk = true; // Inicia o efeito Gohan SSJ2
            cutscene_timer = 0;
            cutscene_alpha = 0;
            faixa_largura = 0;
        }
    } else {
        // Limpa diálogo
        texto_atual = ""; falando = "ninguem"; pode_clicar = false;
    }
}

// --- 3. MENU RADIAL (ESTILO THE SIMS) ---
if (menu_ativo) {
    if (menu_raio < 120) menu_raio += (120 - menu_raio) * 0.2;

    var qtd;
    if (respeito_total >= 90) qtd = 6; else qtd = 5;

    for (i = 0; i < qtd; i += 1) {
        var ang, bx, by;
        ang = (360 / qtd) * i;
        bx = cx + lengthdir_x(menu_raio, ang);
        by = cy + lengthdir_y(menu_raio, ang);

        if (point_distance(mouse_x, mouse_y, bx, by) < 40) {
            if (mouse_check_button_pressed(mb_left)) {
                falando = "charlotte"; pode_clicar = true; pending_dew_response = true;

                // Define ação
                if (i == 5) botao_selecionado = "coalescer";
                else {
                    switch(i) {
                        case 0: botao_selecionado = "abracar"; break;
                        case 1: botao_selecionado = "beijar"; break;
                        case 2: botao_selecionado = "xingar"; break;
                        case 3: botao_selecionado = "conversar"; break;
                        case 4: botao_selecionado = "miata"; break;
                    }
                }

                // Texto inicial da Charlotte
                if (botao_selecionado == "coalescer" && cooldown_coalescer) {
                    texto_atual = "Charlotte: Me solta... eu to exausta.";
                    pending_dew_response = false;
                } else {
                    texto_atual = "Charlotte: " + ds_list_find_value(dialogos_desconhecido, irandom(ds_list_size(dialogos_desconhecido)-1));
                }
                menu_ativo = false;
            }
        }
    }
}
#define Keyboard_123
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// --- Menu de Debug Avançado (Nativo GM8) ---
var escolha, valor, sub_escolha, ctrl;

// Busca o controlador para ler/alterar as variáveis globais do relacionamento
ctrl = instance_find(Relationship_control, 0);

if (ctrl == noone) {
    show_message("ERRO: Objeto Relationship_control nao encontrado na sala!");
    exit;
}

message_caption(1, "SISTEMA DE TESTE DE UI - NORDION");
message_alpha(0.9);
message_text_font("Courier New", 10, c_white, 1);

escolha = show_menu_pos(mouse_x, mouse_y, "Afinidade e Pontos|Status de Casamento|TESTAR CUTSCENE SSJ2|TESTAR BALAO (Charlotte)|TESTAR BALAO (Dew)|Reset Coalescer|Reset Total", -1);

switch (escolha) {
    case 0:
        // Acessamos 'pontos' através do controlador 'ctrl'
        valor = get_integer("Pontos (0-100):", ctrl.pontos);
        ctrl.pontos = valor;
        // Sincroniza os contadores para não dar conflito
        ctrl.contador_abracar = valor / 2;
        ctrl.contador_beijar = valor / 2;
        show_message("Afinidade: " + string(ctrl.pontos) + "%");
        break;

    case 1:
        if (show_question("Ativar Casamento?")) ctrl.casado = true; else ctrl.casado = false;
        break;

    case 2: // TESTAR CUTSCENE BERSERK
        cutscene_berserk = true;
        cutscene_timer = 0;
        cutscene_alpha = 0;
        faixa_largura = 0;
        break;

    case 3: // TESTAR BALÃO (Charlotte)
        falando = "charlotte";
        texto_atual = "TESTE DE UI: Eu sou Charlotte Lorca. Este e o meu portrait colado no balao Frutiger Aero.";
        pode_clicar = true;
        break;

    case 4: // TESTAR BALÃO (Dew)
        falando = "dew";
        texto_atual = "TESTE DE UI: Eu sou o Dew. Meu portrait aparece a direita, tambem alinhado ao topo do balao.";
        pode_clicar = true;
        break;

    case 5: // Reset de Coalescer
        cooldown_coalescer = false;
        show_message("Coalescer Disponivel.");
        break;

    case 6: // Reset Total
        if (show_question("Apagar saves de NLMSDOS e reiniciar?")) {
            if (file_exists(global.save_ini_casado)) file_delete(global.save_ini_casado);
            if (file_exists(global.save_ini_room)) file_delete(global.save_ini_room);
            game_restart();
        }
        break;
}
#define Mouse_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Clique no Dew para abrir o Menu
if (!menu_ativo && !pode_clicar) {
    menu_ativo = true;
    menu_raio = 0;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// --- Draw Event: UI Aero, Portraits Colados e Cutscene SSJ2 ---
draw_self()

var vx, vy, vw, vh, dy, dh, cx, cy;
vx = view_xview[0]; vy = view_yview[0];
vw = view_wview[0]; vh = view_hview[0];
cx = vx + vw/2; cy = vy + vh/2;
dh = 120; // Altura fixa da caixa
dy = vy + vh - dh - 20; // Posição Y da caixa de diálogo

// --- 1. DESENHO DOS DIÁLOGOS E PORTRAITS ---
if (texto_atual != "" && texto_atual != "0" && !cutscene_berserk) {

    // Cores Aero baseadas no estado
    var c_vidro;
    if (is_berserk) c_vidro = make_color_rgb(255, 60, 60); else c_vidro = make_color_rgb(150, 220, 255);

    // Seleção de Portraits (Lorca / Conote)
    var spr_c, spr_d;
    if (is_berserk) spr_c = spr_portrait_charlotte_berserk;
    else if (furia_ativa) spr_c = spr_portrait_charlotte_rage;
    else spr_c = spr_portrait_charlotte;

    if (furia_ativa || is_berserk) spr_d = spr_portrait_dew_rage;
    else spr_d = spr_portrait_dew;

    // --- DESENHO DOS PORTRAITS (COLADOS NO TOPO) ---
    var shk_x, shk_y;
    if (is_berserk) { shk_x = random_range(-2,2); shk_y = random_range(-2,2); } else { shk_x = 0; shk_y = 0; }

    // Charlotte (Esquerda) - O pé do portrait encosta em 'dy'
    if (falando == "charlotte") {
        var h_c; h_c = sprite_get_height(spr_c);
        draw_sprite_ext(spr_c, 0, vx + 50 + shk_x, dy - h_c + shk_y, 1, 1, 0, c_white, 1);
    }
    // Dew (Direita) - O pé do portrait encosta em 'dy'
    else if (falando == "dew") {
        var h_d; h_d = sprite_get_height(spr_d);
        draw_sprite_ext(spr_d, 0, vx + vw - 210 + shk_x, dy - h_d + shk_y, 1, 1, 0, c_white, 1);
    }

    // --- CAIXA DE DIÁLOGO (FRUTIGER AERO GLASS) ---
    draw_set_alpha(0.7);
    draw_roundrect_color(vx+30, dy, vx+vw-30, dy+dh, c_vidro, c_white, false);

    // Brilho Glossy Superior
    draw_set_alpha(0.4);
    draw_ellipse_color(vx+60, dy+5, vx+vw-60, dy+dh/2, c_white, c_vidro, false);

    // Borda Branca de Vidro
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_roundrect(vx+30, dy, vx+vw-30, dy+dh, true);

    // --- RENDERIZAÇÃO DO TEXTO ---
    draw_set_font(normal); // Nome da sua fonte no GM8.1
    draw_set_color(c_black); // Preto para contraste no fundo branco/claro
    draw_text_ext(vx+60, dy+35, texto_atual, 22, vw-140);
}

// --- 2. MENU RADIAL (ESTILO THE SIMS) ---
if (menu_ativo && !cutscene_berserk) {
    var qtd;
    if (respeito_total >= 90) qtd = 6; else qtd = 5;

    for (i = 0; i < qtd; i += 1) {
        var ang, bx, by, txt, dist, sobre;
        ang = (360/qtd) * i;
        dist = menu_raio + (sin(current_time/150 + i) * 5); // Efeito de flutuação
        bx = cx + lengthdir_x(dist, ang);
        by = cy + lengthdir_y(dist, ang);

        sobre = (point_distance(mouse_x, mouse_y, bx, by) < 40);

        // Bolha Aero
        draw_set_alpha(0.8);
        var r_sz; if (sobre) r_sz = 46; else r_sz = 40;
        draw_circle_color(bx, by, r_sz, make_color_rgb(100, 200, 255), c_white, false);

        draw_set_alpha(1);
        draw_set_color(c_white);
        draw_circle(bx, by, r_sz, true);

        // Texto da Opção
        draw_set_font(normal);
        draw_set_color(c_black);
        draw_set_halign(fa_center);
        switch(i) {
            case 0: txt = "ABRAÇAR"; break;
            case 1: txt = "BEIJAR"; break;
            case 2: txt = "XINGAR"; break;
            case 3: txt = "CONVERSAR"; break;
            case 4: txt = "MIATA"; break;
            case 5: txt = "COALESCER"; break;
        }
        draw_text(bx, by - 10, txt);
        draw_set_halign(fa_left);
    }
}

// --- 3. CUTSCENE BERSERK (ESTILO GOHAN SSJ2) ---
if (cutscene_berserk) {
    // Escurecimento
    if (cutscene_alpha < 0.85) cutscene_alpha += 0.04;
    draw_set_alpha(cutscene_alpha);
    draw_set_color(c_black);
    draw_rectangle(vx, vy, vx+vw, vy+vh, false);
    draw_set_alpha(1);

    // Faixa Vermelha SSJ2
    if (cutscene_timer > 15) {
        if (faixa_largura < vh) faixa_largura += (vh - faixa_largura) * 0.12;
        if (frac(current_time/80) > 0.5) draw_set_color(c_red); else draw_set_color(make_color_rgb(150, 0, 0));
        draw_rectangle(vx, vy+(vh/2)-(faixa_largura/2), vx+vw, vy+(vh/2)+(faixa_largura/2), false);
    }

    // Portrait Centralizado (Aumentado e Tremendo)
    var p_shk; p_shk = random_range(-5, 5);
    draw_sprite_ext(spr_portrait_charlotte_berserk, 0, cx + p_shk, cy + p_shk, 1.5, 1.5, 0, c_white, 1);

    // Vapor de Adrenalina
    effect_create_above(ef_smoke, cx + random_range(-50, 50), cy + random_range(-50, 50), 1, c_white);

    draw_set_font(normal);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_text(cx, cy + 130, "!!! Berserk Mode !!!");
    draw_set_halign(fa_left);
}

// Limpeza de Estado
draw_set_alpha(1);
draw_set_color(c_white);
