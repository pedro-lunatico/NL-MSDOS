/// --- Step Event: IA Evolutiva, Movimentação e Mente Colmeia ---

// 1. GESTÃO DE TIMERS E COOLDOWNS
if (timer_balao > 0) timer_balao -= 1;
if (flash_timer > 0) flash_timer -= 1;
if (damage_cooldown > 0) damage_cooldown -= 1;
if (timer_alerta_confusa > 0) timer_alerta_confusa -= 1;
if (timer_alerta_watchdog > 0) timer_alerta_watchdog -= 1;

// 2. SISTEMA WATCHDOG (Detecta se a unidade está presa)
timer_memoria_pos -= 1;
if (timer_memoria_pos <= 0) {
    // Se a distância entre a posição atual e a de 1 segundo atrás for mínima
    if (point_distance(x, y, pos_x_antiga, pos_y_antiga) < 2 && speed != 0) {
        watchdog += 1;
    } else {
        watchdog = 0;
    }
    pos_x_antiga = x;
    pos_y_antiga = y;
    timer_memoria_pos = 30;
}

// Se travar por muito tempo, força um desvio
if (watchdog > 5) {
    timer_alerta_watchdog = 60;
    state = 8; // Estado de Evasão
    watchdog = 0;
}

// 3. MÁQUINA DE ESTADOS (FSM)
switch (state) {

    case 0: // --- TOMADA DE DECISÃO (ROTINA) ---
        var dado; dado = random(100);
        if (dado < peso_trabalhar) state = 10;
        else if (dado < (peso_trabalhar + peso_socializar)) state = 3;
        else state = 11;
    break;

    case 10: // --- BUSCA DE ESTAÇÃO (Nami_work e filhos) ---
        var inst; inst = instance_nearest(x, y, Nami_work);
        if (instance_exists(inst) && inst != ultimo_alvo) {
            if (point_distance(x, y, inst.x, inst.y) > 35) {
                mp_potential_step(inst.x, inst.y, 2.2, false);
            } else {
                state = 9; timer_limpeza = 180; speed = 0;
            }
        } else {
            peso_trabalhar -= 0.1; // Desmotivação leve se não houver trabalho
            state = 11;
        }
    break;

    case 9: // --- EXECUTANDO TAREFA (Limpando/Trabalhando) ---
        speed = 0;
        // Efeito visual de trabalho (levitação senoidal típica de GameMaker 8.1)
        y += sin(degtorad(current_time * 0.8)) * 0.5;
        if (irandom(15) == 0) effect_create_above(ef_smoke, x, y - 16, 0, c_white);

        timer_limpeza -= 1;
        if (timer_limpeza <= 0) {
            peso_trabalhar += 1.5; // REFORÇO POSITIVO: Sucesso no dever
            ultimo_alvo = instance_nearest(x, y, Nami_work);
            state = 3; // Vai socializar após o trabalho
        }
    break;

    case 3: // --- SOCIALIZAÇÃO (Interação com outras Clones) ---
        var irma; irma = instance_nearest(x, y, object_index);
        if (irma != id && instance_exists(irma)) {
            if (point_distance(x, y, irma.x, irma.y) < 160) {
                if (point_distance(x, y, irma.x, irma.y) > 50) {
                    mp_potential_step(irma.x, irma.y, 1.8, false);
                } else {
                    speed = 0;
                    if (timer_balao <= 0) {
                        // Aqui o sistema chamaria o scr_markov_gerar_complexo()
                        texto_balao = "Sincronizando com unidade " + irma.nome_clonado;
                        timer_balao = 200;
                        peso_socializar += 0.5;
                    }
                    if (irandom(100) == 0) state = 0;
                }
            } else { state = 11; }
        } else { state = 11; }
    break;

    case 11: // --- VADIAR / SEGUIR PLAYER ---
        if (instance_exists(alvo_player)) {
            if (point_distance(x, y, alvo_player.x, alvo_player.y) > 90) {
                mp_potential_step(alvo_player.x, alvo_player.y, 2.5, false);
            } else {
                speed = 0;
            }
        }
        if (irandom(300) == 0) state = 0;
    break;

    case 7: // --- APRENDIZADO DE OBSTÁCULO (Mente Colmeia) ---
        speed = 0;
        learning_timer -= 1;
        if (learning_timer <= 0) {
            // Checa o que está na frente antes de salvar
            var obs; obs = instance_place(x + lengthdir_x(30, direction), y + lengthdir_y(30, direction), all);
            if (instance_exists(obs)) {
                ini_open(ini_colmeia);
                ini_write_real("Rotas", object_get_name(obs.object_index), 1);
                ini_close();
            }
            state = 8;
        }
    break;

    case 8: // --- EVASÃO (Desviar de perigo ou bloqueio) ---
        direction += 150 + irandom(60);
        speed = 2;
        if (irandom(30) == 0) state = 0;
    break;
}

// 4. VERIFICAÇÃO DE COLISÃO INTELIGENTE (COLMEIA)
// Evita que a clone tente atravessar objetos que a colmeia já sabe que são sólidos
var col_frente; col_frente = instance_place(x + lengthdir_x(25, direction), y + lengthdir_y(25, direction), all);
if (instance_exists(col_frente)) {
    var t_obj; t_obj = col_frente.object_index;
    // Ignora o Player e Estações de Trabalho
    if (t_obj != Nami_work && t_obj != object_index && t_obj != player) {
        ini_open(ini_colmeia);
        var ja_conhece; ja_conhece = ini_read_real("Rotas", object_get_name(t_obj), 0);
        ini_close();

        if (ja_conhece) {
            state = 8; // Desvia imediatamente
        } else if (state != 7) {
            state = 7; // Para para "estudar" o objeto novo
            learning_timer = 45;
            timer_alerta_confusa = 45; // Mostra o "?"
        }
    }
}

// 5. MANUTENÇÃO DE PESOS E PERSISTÊNCIA
peso_trabalhar = clamp(peso_trabalhar, 5, 90);
if (irandom(2000) == 0) {
    ini_open(meu_ini_individual);
    ini_write_real("Cerebro", "trabalho", peso_trabalhar);
    ini_write_real("Cerebro", "social", peso_socializar);
    ini_close();
}
