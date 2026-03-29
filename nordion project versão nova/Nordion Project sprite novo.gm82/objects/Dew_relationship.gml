#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// --- Inicialização do Dew ---

// Destruição automática se já casou e está em Magvel
if (instance_exists(Relationship_control)) {
    if (global.casado && room == magvel1) {
        instance_destroy();
        exit;
    }
}
obj_player = player || player_RE1 || player_RE2 || player_RE3 || Player_Horse || Player_Wonder_Boy
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
// --- Inicialização do Cérebro IA ---
global.memoria_grid_dew = ds_grid_create(4, 0);
global.memoria_grid = ds_grid_create(4, 0)
scr_carregar_memorias(); // Você precisará criar uma versão desse script para o arquivo "memoria_dew.ini"
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
estresse = 0;
categoria_da_ultima_frase = "none";
vergonha = 0;
estresse = 0;
contagem_trocas = 0;
esperando = false;
tempo_sozinha = 0;
onde_estou_resolvido = true;
angulo_antigo = direction;
estado_humor = "Calma";
estado_hipervigilante = false;
contador_relacao = 0;
alguem_viu = false;
executed_dialog_step = false;
global.memoria_grid_dew = -1; // -1 significa que não existe nada ainda

/// --- Controle de Expressão ---
face_charlotte = spr_portrait_charlotte;
face_dew = spr_portrait_dew;
shake_portrait = 0; //adrenalina
esperando = false;

obj_player = player
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// --- STEP EVENT: DEW (RELACIONAMENTO & PRECONCEITO) ---

var vx, vy, vw, vh, cx, cy, dist_player, dist_fergus, i;
var fator_preconceito, chance_surto, ang, bx, by;

// 1. COORDENADAS E DISTÂNCIAS
vx = view_xview[0]; vy = view_yview[0];
vw = view_wview[0]; vh = view_hview[0];
cx = vx + vw/2; cy = vy + vh/2;

if (instance_exists(obj_player)) {
    dist_player = point_distance(x, y, obj_player.x, obj_player.y);
} else { dist_player = 0; }

// 2. MECÂNICA DE DESUMANIZAÇÃO (INFLUÊNCIA DE FERGUS)
if (!variable_local_exists("objeto_status")) objeto_status = 0;

if (instance_exists(Fergus_OBJ)) {
    dist_fergus = distance_to_object(Fergus_OBJ);
    if (dist_fergus < 400) {
        objeto_status += 0.1;
        estresse += 0.05;
    }
}

objeto_status = median(0, objeto_status, 100);
estresse = median(0, estresse, 100);

// Humores baseados em preconceito e estresse
if (objeto_status > 70) {
    estado_humor = "Supremacista";
    cor_menu = c_red;
} else if (estresse > 80) {
    estado_humor = "Instável";
    cor_menu = c_orange;
} else {
    estado_humor = "Protetor";
    cor_menu = c_white;
}

// 3. O SURTO / AGRESSÃO
if (estado_humor == "Supremacista" && dist_player < 50 && !global.quebra_de_confianca) {
    chance_surto = random(100);
    if (mouse_check_button_pressed(mb_left) || chance_surto > 99.5) {
        effect_create_above(ef_explosion, x, y, 0.5, c_red);
        effect_create_above(ef_smoke, x, y, 1, c_black);
        view_xview[0] += irandom_range(-15, 15);
        view_yview[0] += irandom_range(-15, 15);

        global.quebra_de_confianca = true;
        respeito_total -= 30;
        objeto_status += 10;

        texto_atual = "Dew: Você esqueceu o que você é? Você é apenas código e carne sintética!";
        falando = "dew";
        pode_clicar = true;

        with (obj_player) {
            direction = point_direction(other.x, other.y, x, y);
            speed = 8;
            alarm[0] = 10;
        }
    }
}

// 4. LÓGICA DO MENU RADIAL (CORRIGIDA)
if (instance_exists(obj_player) && !pode_clicar && !menu_ativo) {
    if (dist_player <= 45) {
        menu_ativo = true;
        menu_raio = 0;
    }
}

if (menu_ativo) {
    if (menu_raio < 130) menu_raio += (130 - menu_raio) * 0.2;
    if (dist_player > 70) menu_ativo = false;

    // Processamento de clique nos botões do menu
    for (i = 0; i < 6; i += 1) {
        ang = (360 / 6) * i;
        bx = cx + lengthdir_x(menu_raio, ang);
        by = cy + lengthdir_y(menu_raio, ang);

        if (point_distance(mouse_x, mouse_y, bx, by) < 30) {
            if (mouse_check_button_pressed(mb_left)) {
                falando = "charlotte";
                pode_clicar = true;
                pending_dew_response = true;

                // Define a ação
                switch(i) {
                    case 0: botao_selecionado = "abracar"; break;
                    case 1: botao_selecionado = "beijar"; break;
                    case 2: botao_selecionado = "xingar"; break;
                    case 3: botao_selecionado = "conversar"; break;
                    case 4: botao_selecionado = "esperar"; break; // Nova opção
                    case 5: botao_selecionado = "coalescer"; break;
                }
                menu_ativo = false;
            }
        }
    }
}

// 5. PROCESSAMENTO DE DIÁLOGOS E ORDENS
if (pode_clicar && mouse_check_button_pressed(mb_left) && !menu_ativo) {
    if (pending_dew_response) {
        falando = "dew";

        // --- 1. LÓGICA DE ESPERAR (ORDEM) ---
        if (botao_selecionado == "esperar") {
            if (objeto_status > 60) {
                texto_atual = "Dew: Eu não recebo ordens de um clone. Eu vou para onde eu quiser.";
                esperando = false;
            } else {
                texto_atual = "Dew: Tudo bem, Charlotte. Vou ficar por aqui.";
                esperando = true;
            }
        }

        // --- 2. CONVERSA DINÂMICA (ENTRADA DE TEXTO) ---
        else if (botao_selecionado == "conversar") {
            var msg;
            msg = get_string("Falar com o herdeiro:", "");
            if (msg != "") {
                texto_atual = scr_responder_dew(msg); // Usa o cérebro modular
            } else {
                pode_clicar = false;
                falando = "ninguem";
            }
        }

        // --- 3. AÇÕES RADIAIS (USANDO AS DS_LISTS DE MEMÓRIA) ---
        else {
            var lista_alvo;
            lista_alvo = -1;

            // Seleciona a lista baseada no botão e no estado de humor
            switch(botao_selecionado) {
                case "abracar":   lista_alvo = dialogos_abracar; break;
                case "beijar":    lista_alvo = dialogos_beijar; break;
                case "xingar":    lista_alvo = dialogos_xingar; break;
                case "coalescer": lista_alvo = dialogos_coalescer; break;
                default:          lista_alvo = dialogos_amigavel; break;
            }

            // Se o Dew estiver no modo SUPREMACISTA, ele ignora a lista carinhosa
            if (objeto_status > 70 && botao_selecionado != "xingar") {
                texto_atual = "Dew: " + choose("Não me toque.", "Lembre-se do seu lugar, objeto.", "Você é apenas código.");
            }
            else if (lista_alvo != -1 && ds_list_size(lista_alvo) > 0) {
                // Sorteia um diálogo da lista carregada no scr_carregar_dialogos
                var r_idx;
                r_idx = irandom(ds_list_size(lista_alvo) - 1);
                texto_atual = ds_list_find_value(lista_alvo, r_idx);
            } else {
                // Fallback caso a lista esteja vazia
                texto_atual = "Dew: ... (Ele parece distante)";
            }
        }

        pending_dew_response = false;
    }
    else {
        texto_atual = "";
        falando = "ninguem";
        pode_clicar = false;
    }
}

// 6. MOVIMENTAÇÃO (FOLLOW SYSTEM - REGRAS DE CASAMENTO)
// Ele só segue se estiver casado (global.casado == true)
if (global.quebra_de_confianca == true) {
    speed = 0; // Paralisado pelo conflito/remorso
}
else if (global.casado == true && !esperando && !menu_ativo && !pode_clicar) {
    if (dist_player > 500) { x = obj_player.x; y = obj_player.y; }
    else if (dist_player > 60) {
        // Se ele está no modo supremacista, ele "atropela" a Charlotte ao andar
        if (estado_humor == "Supremacista") move_towards_point(obj_player.x, obj_player.y, 6);
        else move_towards_point(obj_player.x, obj_player.y, 4);
    } else {
        speed = 0;
    }
} else {
    speed = 0; // Se não estiver casado, ele não segue automaticamente
}
#define Keyboard_123
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// --- Menu de Debug Avançado: Unidade DEW ---
var escolha, valor, alvo;

// Busca a instância do Dew na sala
alvo = instance_find(obj_dew, 0);

if (alvo == noone) {
    show_message("ERRO: obj_dew nao encontrado nesta sala!");
    exit;
}

message_caption(1, "DEBUG DEW - PROTOCOLO DE HUMANIDADE");
message_alpha(0.85);

escolha = show_menu_pos(mouse_x, mouse_y,
    "Ajustar Objeto_Status (Preconceito)|" +
    "Ajustar Estresse (Surto)|" +
    "Alternar Estado de Casamento|" +
    "Resetar Quebra de Confiança|" +
    "Forçar Surto Visual (Explosão)|" +
    "Verificar Variáveis Atuais|" +
    "Teleportar Dew para Player", -1);

switch (escolha) {
    case 0: // AJUSTAR PRECONCEITO (OBJETO_STATUS)
        valor = get_integer("Status de Objeto (0-100). Acima de 70 = Supremacista:", alvo.objeto_status);
        alvo.objeto_status = median(0, valor, 100);
        show_message("Objeto_Status definido para: " + string(alvo.objeto_status));
        break;

    case 1: // AJUSTAR ESTRESTE
        valor = get_integer("Nível de Estresse (0-100). Acima de 90 = Instável:", alvo.estresse);
        alvo.estresse = median(0, valor, 100);
        show_message("Estresse definido para: " + string(alvo.estresse));
        break;

    case 2: // STATUS DE CASAMENTO
        if (global.casado == true) {
            if (show_question("Dew está casado. Deseja anular o casamento?")) global.casado = false;
        } else {
            if (show_question("Dew é solteiro. Deseja casar com a Charlotte?")) global.casado = true;
        }
        break;

    case 3: // RESETAR TRAUMA
        global.quebra_de_confianca = false;
        alvo.objeto_status = 0;
        alvo.estresse = 0;
        show_message("Trauma resetado. Dew voltará a seguir se estiver casado.");
        break;

    case 4: // TESTAR SURTO
        with(alvo) {
            effect_create_above(ef_explosion, x, y, 1, c_red);
            view_xview[0] += irandom_range(-20, 20);
            view_yview[0] += irandom_range(-20, 20);
            texto_atual = "DEBUG: TESTE DE SURTO DISPARADO.";
            pode_clicar = true;
            falando = "dew";
        }
        break;

    case 5: // INSPEÇÃO DE VARIÁVEIS
        show_message("RELATÓRIO DE UNIDADE:" + "#" +
                     "Humor: " + string(alvo.estado_humor) + "#" +
                     "Preconceito: " + string(alvo.objeto_status) + "%" + "#" +
                     "Estresse: " + string(alvo.estresse) + "%" + "#" +
                     "Casado: " + string(global.casado) + "#" +
                     "Esperando: " + string(alvo.esperando));
        break;

    case 6: // TELEPORTE
        if (instance_exists(obj_player)) {
            alvo.x = obj_player.x;
            alvo.y = obj_player.y;
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



if (instance_exists(player))
{
    if (distance_to_object(player) <= 40)
    {
if (!menu_ativo && !pode_clicar) {
    menu_ativo = true;
    menu_raio = 0;
}}}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// --- Draw Event: Dew (Aero Style) ---
draw_self();

var vx, vy, vw, vh, dy, dh, cx, cy;
vx = view_xview[0]; vy = view_yview[0];
vw = view_wview[0]; vh = view_hview[0];
cx = vx + vw/2; cy = vy + vh/2;

dh = 110;
dy = vy + vh - dh - 30;

// Corrigido: Usando string() para evitar o erro de comparação de argumentos
if (string(texto_atual) != "" && string(texto_atual) != "0" && !cutscene_berserk) {

    // --- Lógica de Portraits ---
    var spr_d;
    spr_d = spr_portrait_dew; // Padrão

    if (categoria_da_ultima_frase == "romance") spr_d = spr_portrait_dew;
    if (categoria_da_ultima_frase == "becker")  spr_d = spr_portrait_dew_rage;
    if (categoria_da_ultima_frase == "confuso") spr_d = spr_portrait_dew;
    if (is_berserk) spr_d = spr_portrait_dew;

    // Desenho Portraits (Ajustados para não flutuar)
    if (falando == "dew") {
        draw_sprite_ext(spr_d, 0, vx + vw - 220, dy - sprite_get_height(spr_d) + 15, 1, 1, 0, c_white, 1);
    } else if (falando == "charlotte") {
        draw_sprite_ext(spr_portrait_charlotte, 0, vx + 50, dy - sprite_get_height(spr_portrait_charlotte) + 15, 1, 1, 0, c_white, 1);
    }

    // --- CAIXA FRUTIGER AERO (Ciano & Branco) ---
    var c1, c2;
    c1 = make_color_rgb(140, 220, 255); // Azul Aero
    c2 = c_white;
    if (is_berserk) { c1 = c_red; c2 = c_maroon; }

    draw_set_alpha(0.75);
    draw_roundrect_color(vx+40, dy, vx+vw-40, dy+dh, c1, c2, false);
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_roundrect(vx+40, dy, vx+vw-40, dy+dh, true); // Borda de brilho

    // --- TEXTO ---
    draw_set_font(normal);
    draw_set_color(c_black);
    draw_text_ext(vx+70, dy+25, texto_atual, 22, vw-160);
}

// --- MENU RADIAL ---
if (menu_ativo && !cutscene_berserk) {
    for (i = 0; i < 6; i += 1) {
        var ang, bx, by, txt, sobre;
        ang = (360/6) * i;
        bx = cx + lengthdir_x(menu_raio, ang);
        by = cy + lengthdir_y(menu_raio, ang);
        sobre = (point_distance(mouse_x, mouse_y, bx, by) < 40);

        // Botão Glossy
        draw_set_alpha(0.8);
        var cb; cb = make_color_rgb(0, 140, 255);
        if (sobre) cb = make_color_rgb(80, 200, 255);
        draw_circle_color(bx, by, 40, cb, c_white, false);

        draw_set_alpha(1);
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
        draw_text(bx, by-8, txt);
        draw_set_halign(fa_left);
    }
}
