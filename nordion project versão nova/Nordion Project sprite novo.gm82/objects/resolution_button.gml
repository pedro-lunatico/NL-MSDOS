#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Lista de resoluções
res_total = 6;
res_largura[0] = 800;   res_altura[0] = 600;
res_largura[1] = 1024;  res_altura[1] = 768;
res_largura[2] = 1280;  res_altura[2] = 720;
res_largura[3] = 1366;  res_altura[3] = 768;
res_largura[4] = 1600;  res_altura[4] = 900;
res_largura[5] = 1920;  res_altura[5] = 1080;

res_index = 0;

// Fade
mudando_res = false;
fade_alpha = 0;
fade_speed = 0.12;
// ===========================
// VARIÁVEIS DE DIÁLOGO
// ===========================
mostrar_dialogo = false;
dialogo_texto = "";
dialogo_alpha = 0;
dialogo_y_offset = 0;
dialogo_timer = 0;
dialogo_tempo_max = room_speed * 4; // 4 segundos

// ===========================
// VARIÁVEIS DO BALÃO
// ===========================
balao_w = 740;    // largura inicial
balao_h = 80;     // altura
balao_x = 0;
balao_y = 0;
balao_largura = 0;
balao_altura = 0;
dialogo_texto = "";


// ===========================
// VARIÁVEIS DO PORTRAIT
// ===========================
portrait_x = 70;
portrait_y = 0;


// ===========================
// VARIÁVEIS DO FADE
// ===========================
fade_alpha = 0;


// ===========================
// VARIÁVEIS DE RESOLUÇÃO
// (se você usa troca de resolução com fade)
// ===========================
res_index = 0;
mudando_res = false;


// Dialogos
shampoo_dialogos = ds_list_create();
ds_list_add(shampoo_dialogos, "Shampoo nao acredita que deve diminuir a resolucao outra vez...");
ds_list_add(shampoo_dialogos, "Shampoo observa que seu PC e tao lento que ela precisa falar disso de novo.");
ds_list_add(shampoo_dialogos, "Shampoo se diverte as custas do seu PC fraco, diminuindo para 800x600...");
ds_list_add(shampoo_dialogos, "Shampoo tenque sempre explicar a resolucao, voce idiota.");
ds_list_add(shampoo_dialogos, "Shampoo mais uma vez falando da resolucao deste jogador...");
ds_list_add(shampoo_dialogos, "Shampoo odeia voces cientista.");
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// ===================== STEP EVENT =====================

// --- Controle do fade de transição ---
if (mudando_res) {
    fade_alpha += fade_speed;

    // Escureceu totalmente -> muda resolução
    if (fade_alpha >= 1) {
        fade_alpha = 1;

        // Atualiza índice de forma segura
        res_index += 1;
        if (res_index >= res_total) res_index = 0;

        // Largura e altura atuais
        largura = res_largura[res_index];
        altura  = res_altura[res_index];

        // Aplica resolução
        display_set_size(largura, altura);
        window_set_size(largura, altura);
        window_center();

        // Diálogo da Shampoo
        frase_idx = irandom(ds_list_size(shampoo_dialogos)-1);
        dialogo_texto = ds_list_find_value(shampoo_dialogos, frase_idx) +
                        ": " + string(largura) + " x " + string(altura);
        mostrar_dialogo = true;
        dialogo_timer = dialogo_tempo_max;
        dialogo_alpha = 0;
        dialogo_y_offset = 20;

        // Começa a clarear o fade
        fade_speed = -abs(fade_speed);
    }

    // Clarear fade -> fim da transição
    if (fade_alpha <= 0 && fade_speed < 0) {
        fade_alpha = 0;
        fade_speed = abs(fade_speed);
        mudando_res = false;
    }
}

// --- Controle do diálogo animado ---
if (mostrar_dialogo) {
    // Fade de entrada
    if (dialogo_alpha < 1) dialogo_alpha = min(dialogo_alpha + 0.05, 1);

    // Movimento de subida do balão
    if (dialogo_y_offset > 0) dialogo_y_offset = max(dialogo_y_offset - 1.5, 0);

    // Contador de tempo
    dialogo_timer -= 1;
    if (dialogo_timer <= 0) {
        dialogo_alpha -= 0.05;
        if (dialogo_alpha <= 0) {
            mostrar_dialogo = false;
            dialogo_alpha = 0;
        }
    }
}
#define Mouse_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!mudando_res)
{
    mudando_res = true;
    fade_alpha = 0;
    fade_speed = abs(fade_speed);
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_self()
// --- Balão de diálogo animado ---
if (mostrar_dialogo) {
    var balao_w, balao_h, balao_x, balao_y;
    balao_w = 740;
    balao_h = 80;
    balao_x = (room_width / 2) - (balao_w / 2);
    balao_y = room_height - balao_h - 10 + dialogo_y_offset;

    draw_set_alpha(dialogo_alpha);

    // ============================
    // DESENHAR O PORTRAIT ANTES
    // ============================
    if (sprite_exists(shampoo_portrait)) {
        var portrait_x, portrait_y;
        portrait_x = balao_x + 370;
        portrait_y = balao_y + balao_h / 2 - 32;
        draw_sprite(shampoo_portrait, 0, portrait_x, portrait_y);
    }

    // ============================
    // AGORA DESENHA O BALÃO POR CIMA
    // ============================
    // Fundo branco
    draw_set_color(c_white);
    draw_rectangle(balao_x, balao_y, balao_x + balao_w, balao_y + balao_h, false);

    // Borda aqua
    draw_set_color(c_aqua);
    draw_rectangle(balao_x, balao_y, balao_x + balao_w, balao_y + balao_h, true);

    // Texto
    if (font_exists(normal)) draw_set_font(normal);
    draw_set_color(c_black);
    draw_text(balao_x + 20, balao_y + 25, dialogo_texto);

    draw_set_alpha(1);
}
