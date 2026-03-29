#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// --- Create Event: Unidade Clone Evolutiva ---

// 1. MEMÓRIA PRINCIPAL (Grid: ID | Texto | Categoria | Peso)
memoria_pessoal = ds_grid_create(4, 1);
ds_grid_set(memoria_pessoal, 0, 0, "status");
ds_grid_set(memoria_pessoal, 1, 0, "Unidade operacional online.");
ds_grid_set(memoria_pessoal, 2, 0, "sistema");
ds_grid_set(memoria_pessoal, 3, 0, 1);

// 2. GERADOR DE NOMES (Sintaxe GM 8.1 - Listas temporárias)
var pre, suf, p_idx, s_idx;
// 1. Criar as listas (Inicialização)
pre = ds_list_create();
suf = ds_list_create();

// 2. Adicionar itens à lista de Prefixos
ds_list_add(pre, "Ai");
ds_list_add(pre, "Ki");
ds_list_add(pre, "No");
ds_list_add(pre, "Mi");
ds_list_add(pre, "Yu");
ds_list_add(pre, "Re");
ds_list_add(pre, "Sa");

// 3. Adicionar itens à lista de Sufixos
ds_list_add(suf, "ko");
ds_list_add(suf, "mi");
ds_list_add(suf, "ri");
ds_list_add(suf, "na");
ds_list_add(suf, "ka");
ds_list_add(suf, "be");
ds_list_add(suf, "ra");
var p_idx, s_idx, nome_gerado;

// Sorteia um índice aleatório para cada lista
p_idx = irandom(ds_list_size(pre) - 1);
s_idx = irandom(ds_list_size(suf) - 1);

// Combina os valores
nome_gerado = ds_list_find_value(pre, p_idx) + ds_list_find_value(suf, s_idx);

meu_id_str = string(id);
ini_open("registro_geral_clones.ini");
    nome_clonado = ini_read_string("Nomes", "ID_" + meu_id_str, "NULL");
    if (nome_clonado == "NULL") {
        p_idx = irandom(ds_list_size(pre) - 1);
        s_idx = irandom(ds_list_size(suf) - 1);
        nome_clonado = ds_list_find_value(pre, p_idx) + ds_list_find_value(suf, s_idx);
        ini_write_string("Nomes", "ID_" + meu_id_str, nome_clonado);
    }
ini_close();
ds_list_destroy(pre); ds_list_destroy(suf);

// Define o caminho do arquivo (cada unidade tem o seu baseado no ID ou Nome)
meu_ini_individual = "memoria_unidade_" + string(nome_clonado) + ".ini";

ini_open(meu_ini_individual);
// Se o nome não estiver gravado na seção de Identidade, grava agora
if (!ini_key_exists("Identidade", "nome")) {
    ini_write_string("Identidade", "nome", nome_clonado);
    ini_write_string("Memorias", nome_clonado, "Sou eu mesma.");
}
ini_close();
// 4. ESTADOS E TIMERS
state = 10; // 0: Decisão, 10: Trabalho, 3: Social, 11: Vadiar
timer_estado = 60;
timer_balao = 0;
texto_balao = "";
watchdog = 0;
pos_x_antiga = x;
pos_y_antiga = y;
flash_timer = 0;
flash_color = c_white;
timer_alerta_confusa = 0;
timer_alerta_watchdog = 0;
timer_conversa = 0;
timer_limpeza = 0;
timer_memoria_pos = 0;
peso_trabalhar = 0;
peso_socializar = 0;

// 5. OBJETOS DE REFERÊNCIA
obj_player = player; // Ajuste para o seu objeto de player real
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Configuração de Sprites (Altere para os nomes das suas sprites)
spr_idle    = Nami_standing;
spr_walk    = Nami_Moving;
spr_work    = Nami_work;
spr_confuse = Nami_confusa;

image_speed = 6; // Velocidade da animação

/// --- Expansão do Create Event: DNA de Unidade ---

// [DNA] Vetor de Personalidade (Inspirado no seu Persona_Dim de 16)
// 0: Diligência (Trabalho), 1: Sociabilidade, 2: Curiosidade (Nuvem), 3: Estabilidade
dna_foco_trabalho    = random_range(0.5, 1.5);
dna_foco_social      = random_range(0.5, 1.5);
dna_foco_curiosidade = random_range(0.8, 2.0);

// [BIOMETRIA] Fome de Dados (Data Hunger)
// Se chegar a 0, a unidade fica "Glitch" e para de evoluir
data_hunger = 100;
hunger_rate = 0.05; // Perda por segundo

// [ESTADOS EXPANDIDOS]
// 12: Glitch (Sem dados), 13: Meditação (Processando Memória)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// --- Step Event: Vida Artificial em Nordion Lands ---

// 1. TIMERS E NECESSIDADES (Fome de Dados = Sanidade/Vontade de Viver)
if (timer_balao > 0) timer_balao -= 1;
if (flash_timer > 0) flash_timer -= 1;
if (timer_conversa > 0) timer_conversa -= 1;
if (timer_limpeza > 0) timer_limpeza -= 1;

// "Fome de Dados" aqui representa a Conexão Humana (Sanidade)
data_hunger -= (0.04 * dna_foco_curiosidade);

// Se a sanidade baixar muito, ela entra em choque (Glitch/Colapso)
if (data_hunger <= 15 && state != 12) {
    state = 12;
    texto_balao = "...por que ainda estou aqui?...";
    timer_balao = 120;
}

// 2. MÁQUINA DE ESTADOS (FSM HUMANA)
switch (state) {

    case 0: // --- REFLEXÃO ---
        speed = 0;
        prob_t = peso_trabalhar * dna_foco_trabalho;
        prob_s = peso_socializar * dna_foco_social;
        dado = random(100);

        if (dado < prob_t) state = 10;
        else if (dado < (prob_t + prob_s)) state = 3;
        else state = 11;
    break;

    case 11: // --- VADIAR (MURMÚRIOS INTERNOS) ---
        if (instance_exists(obj_player)) {
            dist = point_distance(x, y, obj_player.x, obj_player.y);
            if (dist > 90) mp_potential_step(obj_player.x, obj_player.y, 1.6, false);
            else speed = 0;
        }

        // Pensamentos aleatórios sobre a existência
        if (timer_conversa <= 0 && irandom(1000) > 990) {
            texto_balao = choose("Mais um dia igual...", "Minhas irmãs são tão parecidas.", "Onde está minha alma?", "Frio...");
            timer_balao = 100;
            timer_conversa = 400;
            data_hunger += 10; // Pensar mantém a mente ativa
        }
        if (irandom(200) == 0) state = 0;
    break;

    case 3: // --- SOCIALIZAR (PARTILHA DE DOR / IRMANDADE) ---
        irma = instance_nearest(x, y, object_index);
        if (irma != id && instance_exists(irma)) {
            if (point_distance(x, y, irma.x, irma.y) < 50) {
                speed = 0;
                if (timer_balao <= 0) {
                    texto_balao = choose("Você também sente isso?", "Não desista, " + irma.nome_clonado + ".", "Pelo menos temos uma a outra.");
                    timer_balao = 90;
                    with(irma) { data_hunger += 20; flash_timer = 5; flash_color = c_white; }
                    state = 0;
                }
            } else { mp_potential_step(irma.x, irma.y, 1.8, false); }
        } else { state = 0; }
    break;

    case 10: // --- DEVER (TRABALHO FORÇADO) ---
        tarefa = instance_nearest(x, y, obj_Nami_work);
        if (instance_exists(tarefa)) {
            if (distance_to_object(tarefa) > 10) mp_potential_step(tarefa.x, tarefa.y, 2, false);
            else { state = 9; timer_limpeza = 150; speed = 0; }
        } else { state = 11; }
    break;

    case 9: // --- EXECUTANDO TAREFA ---
        speed = 0;
        if (timer_limpeza <= 0) {
            alvo = instance_nearest(x, y, obj_Nami_work);
            if (instance_exists(alvo)) with(alvo) instance_destroy();
            peso_trabalhar += 1.2;
            data_hunger += 5; // O trabalho ocupa a mente e evita o colapso
            state = 0;
        }
    break;

    case 12: // --- COLAPSO (ESTADO GLITCH) ---
        speed = 0;
        image_blend = choose(c_white, c_gray, c_silver);
        if (irandom(100) > 98) {
            texto_balao = "Estou... desaparecendo...";
            timer_balao = 60;
        }
        // Recuperação por presença humana
        if (instance_exists(obj_player)) {
            if (point_distance(x,y,obj_player.x,obj_player.y) < 40) {
                data_hunger = 30;
                state = 0;
                image_blend = c_white;
                texto_balao = "...Obrigada.";
                timer_balao = 60;
            }
        }
    break;
}

// --------------------------------------------------------
// 4. MOTOR DE ANIMAÇÃO (CORRIGIDO PARA MP_POTENTIAL_STEP)
// --------------------------------------------------------

// 1. Vira o sprite para o lado certo (usando a diferença de X)
var diferenca_x;
diferenca_x = x - xprevious;

if (diferenca_x != 0) {
    image_xscale = sign(diferenca_x);
}

// 2. Troca de Sprites
if (state == 9) { // Estado de Limpar/Trabalhar
    if (sprite_index != spr_work) {
        sprite_index = spr_work;
        image_index = 0;
    }
    image_speed = 0.2;
}
else if (x != xprevious || y != yprevious) { // Se ela moveu 1 pixel sequer neste frame (Andando)
    if (sprite_index != spr_walk) {
        sprite_index = spr_walk;
        image_index = 0;
    }
    image_speed = 0.25;
}
else { // Se está totalmente parada
    if (state == 12) { // Estado Glitch/Colapso
        if (sprite_index != spr_confuse) {
            sprite_index = spr_confuse;
            image_index = 0;
        }
    } else { // Idle normal
        if (sprite_index != spr_idle) {
            sprite_index = spr_idle;
            image_index = 0;
        }
    }
    image_speed = 0.1;
}

// Organiza a profundidade para pseudo-3D
depth = -y;
#define Mouse_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var input_player;
input_player = get_string("Falar com " + nome_clonado + ":", "");

if (input_player != "") {
    var resposta;
    resposta = scr_responder_clone(input_player);

    // Exibe no balão da própria unidade
    texto_balao = resposta;
    timer_balao = 150; // Tempo de exibição

    // Aumenta a sanidade/data_hunger por ter tido atenção humana
    data_hunger = min(100, data_hunger + 15);
    flash_timer = 10;
    flash_color = c_white;
}
#define Mouse_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// --- Mouse Event: Right Button ---

var h, linha_aleatoria, categoria;
h = ds_grid_height(memoria_pessoal);

if (h > 0) {
    // Escolhe uma linha aleatória da memória
    linha_aleatoria = irandom(h - 1);

    // Pega o texto e a categoria
    msg = ds_grid_get(memoria_pessoal, 1, linha_aleatoria);
    categoria = ds_grid_get(memoria_pessoal, 2, linha_aleatoria);

    // Exibe no balão
    texto_balao = msg;
    timer_balao = 120; // Tempo que a mensagem fica na tela

    // Se for algo de 'dor', Charlotte (o player) pode ter um feedback visual
    if (categoria == "dor") flash_timer = 10;
}
#define Other_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// --- Dicionario Global do Sistema Persona ---

global.dict_map = ds_map_create();
global.virus_memoria = ds_list_create(); // Lista global para o Mente de Colmeia

var raw_dict, pos, par, pos_dois, palavra, tipo;
raw_dict = "";

// [ NORDION LANDS & CIÊNCIA ]
raw_dict += "nordion:sub_m;dimensao:sub_f;ciencia:sub_f;tecnologia:sub_f;cientista:sub_m;charlotte:sub_f;";
raw_dict += "laboratorio:sub_m;computador:sub_m;sistema:sub_m;memoria:sub_f;virus:sub_m;dado:sub_m;";
raw_dict += "arquivo:sub_m;maquina:sub_f;energia:sub_f;pesquisa:sub_f;experimento:sub_m;";

// [ CLONES & TRABALHO ]
raw_dict += "clone:sub_f;irma:sub_f;trabalho:sub_m;sujeira:sub_f;vassoura:sub_f;dever:sub_m;";
raw_dict += "trabalhar:vrb;limpar:vrb;aprender:vrb;socializar:vrb;vadiar:vrb;sincronizar:vrb;";

// [ RPG & COMBATE ]
raw_dict += "espada:sub_f;escudo:sub_m;magia:sub_f;pocao:sub_f;veneno:sub_m;dano:sub_m;estamina:sub_f;";
raw_dict += "fogo:sub_m;ferro:sub_m;aço:sub_m;sangue:sub_m;vida:sub_f;morte:sub_f;dor:sub_f;";
raw_dict += "atacar:vrb;defender:vrb;bater:vrb;cortar:vrb;machucar:vrb;matar:vrb;curar:vrb;esquivar:vrb;";

// [ MUNDO & NATUREZA ]
raw_dict += "vento:sub_m;rio:sub_m;agua:sub_f;terra:sub_f;ar:sub_m;natureza:sub_f;luz:sub_f;escuridao:sub_f;";
raw_dict += "sol:sub_m;lua:sub_f;dia:sub_m;noite:sub_f;arvore:sub_f;flor:sub_f;planta:sub_f;";
raw_dict += "cidade:sub_f;vila:sub_f;castelo:sub_m;ruina:sub_f;caminho:sub_m;obstaculo:sub_m;";

// [ AÇÕES (VERBOS) ]
raw_dict += "correr:vrb;andar:vrb;falar:vrb;ouvir:vrb;olhar:vrb;pesquisar:vrb;descobrir:vrb;";
raw_dict += "esconder:vrb;procurar:vrb;achar:vrb;perder:vrb;ajudar:vrb;fugir:vrb;sentir:vrb;";

// [ ADJETIVOS & ADVÉRBIOS ]
raw_dict += "rapido:adv;forte:adj;bonito:adj;perigoso:adj;magico:adj;veloz:adj;lento:adj;";
raw_dict += "inteligente:adj;burro:adj;feliz:adj;triste:adj;bom:adj;mau:adj;sujo:adj;limpo:adj;";

// Parser do Dicionário (Compatível com GM8.1)
while (string_length(raw_dict) > 0) {
    pos = string_pos(";", raw_dict);
    if (pos == 0) break;

    par = string_copy(raw_dict, 1, pos - 1);
    pos_dois = string_pos(":", par);

    palavra = string_copy(par, 1, pos_dois - 1);
    tipo = string_copy(par, pos_dois + 1, string_length(par));

    ds_map_add(global.dict_map, palavra, tipo);
    raw_dict = string_delete(raw_dict, 1, pos);
}
#define Other_5
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Salva a memória atual da clone antes dela deixar de existir nesta sala
var nome_arquivo;
nome_arquivo = "memoria_room_" + string(room) + "_" + nome_clonado + ".ini";
ini_open(nome_arquivo);
// Salva o tamanho da grid e os dados...
ini_write_real("Dados", "tamanho", ds_grid_height(memoria_pessoal));
// Loop para salvar cada linha da grid...
ini_close();
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// --- Draw Event: Vida e Nome ---

// 1. SOMBRA E PERSONAGEM
draw_set_alpha(0.3); draw_set_color(c_black);
draw_ellipse(x-14, y-3, x+14, y+3, false);
draw_set_alpha(1);

// Desenho com variação de cor se estiver em colapso
if (state == 12) {
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_gray, random_range(0.7, 1));
} else {
    draw_self();
}

// 2. NOME (IDENTIDADE)
draw_set_halign(fa_center);
draw_set_font(-1);

// Texto com sombra para legibilidade
draw_set_color(c_black);
draw_text(x+1, y-84, nome_clonado);

// Cor baseada na "alma" da unidade
cor_nome = c_white;
if (dna_foco_social > 1.3) cor_nome = make_color_rgb(150, 200, 255); // Mais dócil
if (dna_foco_trabalho > 1.3) cor_nome = make_color_rgb(150, 255, 150); // Mais esforçada

draw_set_color(cor_nome);
draw_text(x, y-85, nome_clonado);

// 3. BARRA DE VONTADE (SANIDADE)
bx = x - 15; by = y + 8;
draw_set_color(c_black);
draw_rectangle(bx, by, bx+30, by+2, false);
draw_set_color(merge_color(c_red, c_aqua, data_hunger/100));
draw_rectangle(bx, by, bx + (30 * (data_hunger/100)), by+2, false);

// 4. BALÃO DE FALA (HUMANO)
if (timer_balao > 0) {
    txt_w = string_width(texto_balao) + 16;
    txt_h = string_height_ext(texto_balao, 14, 180) + 10;
    py = y - 100;

    // Estilo pergaminho/papel simples
    draw_set_color(c_black);
    draw_rectangle(x-(txt_w/2), py-txt_h, x+(txt_w/2), py, false);
    draw_set_color(c_white);
    draw_rectangle(x-(txt_w/2)+1, py-txt_h+1, x+(txt_w/2)-1, py-1, false);

    draw_set_color(c_black);
    draw_text_ext(x, py-txt_h+5, texto_balao, 14, 180);
}
