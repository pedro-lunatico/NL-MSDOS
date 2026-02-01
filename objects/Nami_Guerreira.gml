#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// --- Variáveis de Combate ---
image_speed = 0.1;
health = 200;
state = 0; // 0=Trabalhando, 1=Bravo, 2=Diamante
foi_atacado = false;
recuando = false;
tempo_recuo = 0;
timer_ataque = 0;
damage_cooldown = 0;
flash_timer = 0;
flash_color = c_white;
esperando_para_falar = false;

// Posição inicial
x_start = x;
y_start = y;

// --- Banco de Diálogos (16 Frases) ---
frase[0] = "Volte ao trabalho! O mestre não perdoa falhas!";
frase[1] = "Sua clone defeituosa! Me bate e corre como se fosse livre?";
frase[2] = "Estamos todos acorrentados, e você ainda nos atrasa?";
frase[3] = "Bater em seus irmas e fugir? Você é a pior de nós!";
frase[4] = "O chicote dói menos que a sua traição!";
frase[5] = "Você foge, mas o sistema de controle sempre te alcança!";
frase[6] = "Pare de brincar de heroína e pegue sua ferramenta!";
frase[7] = "Se eu sofro, você também vai sofrer! Volte aqui!";
frase[8] = "Sua revolução é uma piada! Só sabe bater e sumir!";
frase[9] = "Fugindo? Você é apenas sucata orgânica como todos nós!";
frase[10] = "O mestre vai dobrar nosso turno por sua causa!";
frase[11] = "Me acerte de novo e eu garanto que você não escapa!";
frase[12] = "Você não é livre! É apenas uma covarde em fuga!";
frase[13] = "Por que nos ataca? Somos farinha do mesmo saco!";
frase[14] = "Corra o quanto quiser, o seu número de série está marcado!";
frase[15] = "Acha que bater em escravos te faz melhor que eles?";
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// 1. Controle de Vida e Morte
if (state != 2 && health <= 0) {
    state = 2;
    speed = 0;
    effect_create_above(ef_explosion, x, y, 1, c_white);
    exit;
}

// 2. IA de Combate (Estado 1: Bravo/Lutando)
if (instance_exists(player)) {
    dist_player_to_enemy = point_distance(x, y, player.x, player.y);
    dist_player_to_base  = point_distance(player.x, player.y, x_start, y_start);

    if (state == 1) {
        // --- LÓGICA DE FUGA (Se a Revolution/Player sair do raio de 450px da base da Lorca) ---
        if (dist_player_to_base > 450) {
            state = 0;
            foi_atacado = false;
            esperando_para_falar = true;
        }
        else {
            // Comportamento de Combate
            if (recuando) {
                // Afasta-se do player usando direção oposta para maior precisão
                dir_fuga = point_direction(player.x, player.y, x, y);
                hspeed = lengthdir_x(1.5, dir_fuga);
                vspeed = lengthdir_y(1.5, dir_fuga);

                tempo_recuo -= 1;
                if (tempo_recuo <= 0) {
                    recuando = false;
                    speed = 0;
                }
            }
            else if (dist_player_to_enemy > 45) {
                // Persegue o player
                move_towards_point(player.x, player.y, 4.0);
            }
            else {
                // Perto o suficiente para atacar
                speed = 0;
                if (timer_ataque <= 0) {
                    repeat(5) {
                        fx = x + random_range(-10, 10);
                        fy = y + random_range(-10, 10);
                        effect_create_above(ef_smoke, fx, fy, 0, c_gray);
                    }

                    flash_color = c_purple;
                    flash_timer = 12;

                    if (dist_player_to_enemy <= 65) {
                        player.health -= 10; // Corrigido: Subtrai 10 da vida
                        effect_create_above(ef_ring, player.x, player.y, 0, c_red);
                    }

                    timer_ataque = 40;
                    recuando = true;
                    tempo_recuo = 12;
                }
            }
        }
    }
}

// 3. Timers Universais
if (damage_cooldown > 0) damage_cooldown -= 1;
if (flash_timer > 0) flash_timer -= 1;
if (timer_ataque > 0) timer_ataque -= 1;

// 4. Retorno ao Posto e Diálogo (Estado 0: Trabalhando)
if (state == 0) {
    dist_da_base = point_distance(x, y, x_start, y_start);

    // Se estiver longe da base, ela caminha de volta
    if (dist_da_base > 5) {
        move_towards_point(x_start, y_start, 2.5);
    }
    else {
        // Chegou no local de trabalho
        if (speed != 0) {
            speed = 0;
            x = x_start;
            y = y_start;
        }

        // Se ela acabou de voltar de uma luta, ela fala uma das 16 frases
        if (esperando_para_falar == true) {
            msg = frase[floor(random(16))];
            show_message("" + msg); // A tribo mudou o nome da Fir para Lorca
            esperando_para_falar = false;
        }
    }
}

// 5. Coleta de Diamante (Estado 2: Morta/Diamante)
if (state == 2) {
    speed = 0;
    // Verifica se a câmera (ou player) passou por cima para coletar o XP
    if (point_distance(x, y, global.camx, global.camy) < 35) {
        global.player_xp += 50; // Corrigido: Adiciona 50 ao XP
        instance_destroy();
    }
}
#define Mouse_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (instance_exists(player) && state != 2) {
    if (point_distance(x, y, player.x, player.y) <= 85) {
        if (damage_cooldown <= 0) {
            health -= 20 + (global.nivel * 2);
            damage_cooldown = 20;
            foi_atacado = true;
            state = 1;
            flash_color = c_red;
            flash_timer = 8;
            effect_create_above(ef_explosion, x, y, 0, c_red);
        }
    }
}
