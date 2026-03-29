#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// create
dialogo_ativo = true;
caracteres_mostrados = 0;
velocidade_letra = 2;
contador = 0;
fala_atual = 0;
room_trocada = false;
// Usa UM sprite só (com vários frames)
sprite_index = foraver_young_CG; // <-- seu sprite com todos os CGs
image_speed = 0;
image_index = 0;

// Mapa: NOME_DO_CG -> FRAME
cg_frame_map = ds_map_create();
ds_map_add(cg_frame_map, "CG00", 0);
ds_map_add(cg_frame_map, "CG01", 1);
ds_map_add(cg_frame_map, "CG02", 2);
ds_map_add(cg_frame_map, "CG03", 3);
ds_map_add(cg_frame_map, "CG04", 4);
ds_map_add(cg_frame_map, "CG05", 5);
ds_map_add(cg_frame_map, "CG06", 6);

// Lista de falas
falas = ds_list_create();
// CORREÇÃO DE FORMATO: A lista de falas deve usar a CHAVE do mapa (ex: "CG01_spr"),
// seguida do texto. O nome do personagem (amber, esmeralda) deve ser parte do texto ou ignorado pelo sistema.
// SE VOCÊ QUISER O NOME DO PERSONAGEM, ele deve vir APÓS o sprite: "SPRITE_KEY;PERSONAGEM: FALA"
ds_list_add(falas, "CG00;RVL:Calma Supra ja estamos chegando no final da corrida");
ds_list_add(falas, "CG00;RVL:nossa supra porque nao avisou??? oque seu fuscinho esta sangrando voce
deve estar com aquela Hemorragia de Exercio, ne");
ds_list_add(falas, "CG00;RVL:quando for assim avisa a mamae que voce esta cansadinho ouviu?");

// Pausa gameplay
global.dialogo_ativo = true;
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///destroy
// Libera a memória da lista de falas
ds_list_destroy(falas);
// Libera a memória do mapa de sprites
ds_map_destroy(sprite_map);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// STEP EVENT – obj_CG90

if (dialogo_ativo) {

    // Ainda existem falas?
    if (fala_atual < ds_list_size(falas)) {

        // Fala atual
        var fala_completa;
        var pos_separador;
        var nome_cg;
        var texto_da_fala;
        var novo_frame;

        fala_completa = ds_list_find_value(falas, fala_atual);
        pos_separador = string_pos(";", fala_completa);

        // Extrai CG e texto
        nome_cg = string_copy(fala_completa, 1, pos_separador - 1);
        texto_da_fala = string_copy(fala_completa, pos_separador + 1, string_length(fala_completa));

        // ===============================
        // TROCA DE CG (FRAME DO SPRITE)
        // ===============================
        if (ds_map_exists(cg_frame_map, nome_cg)) {
            novo_frame = ds_map_find_value(cg_frame_map, nome_cg);
            image_index = novo_frame;
        }

        image_speed = 0;

        // ===============================
        // DIGITAÇÃO LETRA A LETRA
        // ===============================
        if (caracteres_mostrados < string_length(texto_da_fala)) {

            contador += 1;
            if (contador >= velocidade_letra) {
                caracteres_mostrados += 1;
                contador = 0;
            }

        } else {
            // Avança fala
            if (keyboard_check_pressed(vk_anykey)) {
                fala_atual += 1;
                caracteres_mostrados = 0;
                contador = 0;
            }
        }

    } else {

        // ===============================
        // FIM DO DIÁLOGO
        // ===============================
        if (!room_trocada) {
            room_trocada = true;
            global.dialogo_ativo = false;
            room_goto(Foraver_young_Room_2);
        }
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///draw
// Desenha o sprite da cutscene definido no Step
draw_self();

if (dialogo_ativo) {
    // 1. EXTRAI APENAS O TEXTO PARA SER DESENHADO
    var fala_completa, pos_separador, texto_dialogo, tx, x0, y0, largura, altura, xx, yy, largura_texto, separacao_entre_linhas;

    fala_completa = ds_list_find_value(falas, fala_atual);
    pos_separador = string_pos(";", fala_completa);
    texto_dialogo = string_delete(fala_completa, 1, pos_separador); // Pega tudo após o primeiro ";"

    // Configurações do balão
    x0 = 50;
    y0 = room_height - 110; // Aumentei um pouco a altura para caber mais linhas
    largura = room_width - 100;
    altura = 100;

    // --- Desenho do Balão ---
    draw_set_color(c_black);
    draw_roundrect(x0-2, y0-2, x0+largura+2, y0+altura+2, false);

    draw_set_color(make_color_rgb(245,245,200));
    draw_roundrect(x0, y0, x0+largura, y0+altura, false);

    // --- Configuração do Texto ---
    draw_set_font(normal);

    tx = string_copy(texto_dialogo, 1, caracteres_mostrados);
    xx = x0 + 15;
    yy = y0 + 10;
    largura_texto = largura - 30; // Margem interna para o texto não encostar na borda
    separacao_entre_linhas = 18; // Ajuste conforme o tamanho da sua fonte pkmn_font

    // --- Texto com contorno (Outline) ---
    // No GM8.1, o draw_text_ext faz a quebra automática baseada na largura (w)
    draw_set_color(c_black);
    draw_text_ext(xx-1, yy,   tx, separacao_entre_linhas, largura_texto);
    draw_text_ext(xx+1, yy,   tx, separacao_entre_linhas, largura_texto);
    draw_text_ext(xx,   yy-1, tx, separacao_entre_linhas, largura_texto);
    draw_text_ext(xx,   yy+1, tx, separacao_entre_linhas, largura_texto);

    // Texto Principal
    draw_set_color(c_white);
    draw_text_ext(xx, yy, tx, separacao_entre_linhas, largura_texto);
}
