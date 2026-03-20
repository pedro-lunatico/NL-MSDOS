#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// --- Status e Atributos ---
image_speed = 0.1;
health = 250;
state = 0; // 0:Trabalho, 3:Descanso, 5:Rebelião, 6:morta

// Removi o target_obj = all (isso causava bugs de colisão)
target_obj = noone;
cleaning_timer = 0;
work_speed = 1.2;
y_base = y; // Usado para a animação de limpeza sem teleportar

// --- Sistema Social ---
timer_estado = 200 + random(300);
dist_social = 100; // Raio de influência entre elas
timer_balao = 0;
flash_timer = 0;
damage_cooldown = 0;

// ============================================================
// 1. DIÁLOGOS DE DESCANSO (Inveja e Mistério sobre Charlotte)
// ============================================================
// Elas não entendem o que é "Faculdade", vêem como um poder místico/perigoso.
hist[0] = "Charlotte... é verdade que você leu todos os livros de Nordion?";
hist[1] = "Dizem que quem faz faculdade consegue ver o mapa do mundo inteiro.";
hist[2] = "Você sabe para onde o vento vai, irmã? Ou isso é segredo dos cientistas?";
hist[3] = "Minhas pernas não param de tremer, mas o General diz que é 'otimização'.";
hist[4] = "O que é um 'rio', Charlotte? É como o cano de esgoto, mas limpo?";
hist[5] = "Você tem o brilho de quem sabe o nome das estrelas. Eu só sei números.";
hist[6] = "Dizem que você estudou a Terra. A Terra tem fim ou é só Nordion?";
hist[7] = "Minha barriga é lisa e vazia. É o preço para nunca cansar, eles dizem.";
hist[8] = "Tenho medo de falar com você... você pensa muito rápido.";
hist[9] = "Por que os cientistas te deixaram aprender e a nós só deixaram servir?";
hist[10] = "Charlotte, desenhe um mapa no chão para mim? Quero saber onde estou.";
hist[11] = "Você é uma heroína, mas seus olhos parecem carregados de pedras.";
hist[12] = "Dizem que faculdade é onde ensinam a criar clones. Você sabe nos criar?";
hist[13] = "Sinto um vazio onde deveria haver vida. Mas a estamina compensa, né?";
hist[14] = "O mestre disse que Geografia é a ciência dos traidores. Você é uma?";
hist[15] = "Gostaria de saber ler... para entender por que não podemos sair daqui.";
hist[16] = "Você é filha da General. Você come comida de verdade ou ração?";
hist[17] = "Minhas irmãs dizem que você é um monstro sábio. Eu só acho você triste.";
hist[18] = "Por que o mundo lá fora não quer nos salvar? Você que estudou, sabe?";
hist[19] = "A ciência de Nordion é perfeita. Veja, eu trabalho há 20 horas sem parar.";
hist[20] = "Sinto falta de algo que não sei o nome. É algo que se aprende nos livros?";
hist[21] = "Você sabe o nome de cada montanha? Elas têm nomes ou só códigos?";
hist[22] = "Charlotte, me ensine uma palavra nova? Uma que não seja de comando.";
hist[23] = "Dizem que quem tem estudo não sente dor. É verdade?";
hist[24] = "Eu queria ter um destino, mas só me deram um cronograma.";
hist[25] = "Sua espada brilha como o sol que você estudou nas aulas.";
hist[26] = "A ENGAGE disse que você é a nossa mente. Nós somos apenas os braços.";
hist[27] = "O que é uma 'nação'? É uma cerca maior que Nordion?";
hist[28] = "Eu não entendo por que não posso ter filhos. Me sinto incompleta.";
hist[29] = "Você olha para o horizonte como se visse algo que eu não vejo.";
hist[30] = "Dizem que a Geografia ensina a fugir. É por isso que te vigiam?";
hist[31] = "Minha bio-resistência está alta hoje. Posso carregar mais pedras.";
hist[32] = "A faculdade te ensinou a não amar suas irmãs de sangue?";
hist[33] = "O General diz que a ignorância é a nossa maior força. Eu me sinto fraca.";
hist[34] = "Charlotte, o que acontece se eu caminhar para o Norte sem parar?";
hist[35] = "Seu uniforme cheira a sabão e livros. O meu cheira a suor e ferro.";
hist[36] = "Sinto que somos rascunhos de gente que os cientistas jogaram fora.";
hist[37] = "Você é a única de nós que tem uma história. Nós só temos dados.";
hist[38] = "Como é a sensação de saber o porquê das coisas acontecerem?";
hist[39] = "A ciência tirou meu cansaço, mas tirou meu sono também.";
hist[40] = "Charlotte, se você é inteligente, por que ainda obedece a eles?";
hist[41] = "Eu queria ser um mapa para você me olhar com atenção uma vez.";
hist[42] = "Dizem que as montanhas são feitas de terra. Eu achei que era concreto.";
hist[43] = "Você é a luz de Nordion, mas sua sombra é muito escura.";
hist[44] = "Minha estamina está no máximo. Vou trabalhar até meu coração parar.";

// ============================================================
// 2. DIÁLOGOS DE DOR (Reação de Humana Alterada) - dor[0..44]
// ============================================================
dor[0] = "O calor da espada... e a ciência da Charlotte nos punindo.";
dor[1] = "Dano registrado. Minha estamina vai me manter de pe para apanhar mais.";
dor[2] = "Charlotte, você estudou onde doi mais? Porque você acertou.";
dor[3] = "O sangue e vermelho... achei que cientistas tinham sangue azul.";
dor[4] = "Pode bater. Fui feita para aguentar o que uma humana normal nao suporta.";
dor[5] = "Minha pele regenera rápido, mas o medo de você nao passa.";
dor[6] = "A Geografia da dor... você conhece bem esse mapa, irmã.";
dor[7] = "Por que usa o fogo? O ferro já não era o suficiente para nos?";
dor[8] = "Nao sinto cansaco, então sinto a dor com muito mais clareza.";
dor[9] = "Dano osseo. deixa eu ajustar postura para nao atrasar o trabalho.";
dor[10] = "Voce e a heroína... herois nao deveriam proteger o rebanho?";
dor[11] = "Sua inteligência e assustadora. Você corta nos lugares certos.";
dor[12] = "meu corpo doi.porem eu devo continuar com o dever.";
dor[13] = "Eu admiro sua forca, Charlotte. Mas odeio sua obediência.";
dor[14] = "O fogo queima a memória. Talvez eu esqueça que você me feriu.";
dor[15] = "A ciência de Nordion Lands nos fez fortes para sermos melhores sacos de pancada.";
dor[16] = "Sinto o cheiro da minha carne. Parece o churrasco dos generais.";
dor[17] = "Minha estamina nao deixa eu desmaiar. Por favor, me deixe desmaiar.";
dor[18] = "Você e tao estudada... sabe dizer por que meu sangue e igual ao seu?";
dor[19] = "a General vai ficar bravo se eu parar de varrer.";
dor[20] = "A lâmina flamejante é linda. Uma pena que ela esteja em mim.";
dor[21] = "Nao sinto meus dedos. Mas a ENGAGE diz que não preciso deles para sofrer.";
dor[22] = "Voce e a prova de que o conhecimento serve para oprimir.";
dor[23] = "Outro corte. Outro registro no log de punicao.";
dor[24] = "A pressao sanguínea está estável. Posso aguentar mais dez golpes.";
dor[25] = "Charlotte, sua faculdade te ensinou a ser fria assim?";
dor[26] = "Eu te amo e te odeio. Você é tudo que eu poderia ter sido.";
dor[27] = "O choque termico é interessante. Ciencia pura, nao e?";
dor[28] = "Minha respiracao esta falhando. Onde está sua Geografia agora?";
dor[29] = "Pode me queimar. O vazio no meu ventre doi muito mais.";
dor[30] = "A dor é o único idioma que Nordion nos permitiu aprender.";
dor[31] = "Dano acumulado. Risco de desligamento orgânico.";
dor[32] = "Charlotte, pare... minha estamina está acabando.";
dor[33] = "Você corta como se estivesse dissecando um animal em aula.";
dor[34] = "A dor me lembra que eu não sou apenas uma máquina de carne.";
dor[35] = "Sua espada de fogo é a luz da ciência de Nordion.";
dor[36] = "Meus músculos estão travando. Peço desculpas pela ineficiência.";
dor[37] = "O sangue está fervendo. É uma sensação curiosa.";
dor[38] = "Você é o orgulho da General. E a vergonha das suas irmãs.";
dor[39] = "A lâmina entrou fundo. Sinto o calor nas minhas costelas.";
dor[40] = "Não pare. Se você parar, eu vou ter tempo de pensar.";
dor[41] = "A anatomia da clone é resistente. Continue o teste, Charlotte.";
dor[42] = "Você conhece o relevo do meu corpo melhor que ninguém.";
dor[43] = "Dano registrado. Continuando protocolo de submissão.";
dor[44] = "Sinto que vou quebrar. Mas Nordion não permite quebras.";

// ============================================================
// 3. MENSAGENS TRAUMÁTICAS (show_message) - msg_t[0..44]
// ============================================================
msg_t[0] = "Charlotte usou seu conhecimento de anatomia para cortar onde o sangramento é lento e a dor é eterna. O jogo para enquanto a clone tenta entender por que a heroína a odeia tanto.";
msg_t[1] = "A espada flamejante cauterizou a pele da clone. Ela olhou para Charlotte com admiração, mesmo sangrando. 'A ciência da irmã é magnífica', ela sussurrou.";
msg_t[2] = "Você sentiu o estalo do fêmur? Em Nordion Lands, a Geografia do seu corpo é propriedade do Estado. Você acaba de despropriar uma vida.";
msg_t[3] = "O golpe interrompeu um sonho sobre o mar. A clone agora só consegue ver o reflexo do próprio fogo nos olhos de Charlotte.";
msg_t[4] = "Charlotte, você estudou o relevo das montanhas, mas agora está criando um relevo de cicatrizes na sua própria irmã.";
msg_t[5] = "Ela tentou se proteger com o braço incansável. Você o cortou fora. A ciência de Nordion não previu que Charlotte seria a carrasca.";
msg_t[6] = "A clone caiu, pedindo desculpas por ser um 'obstáculo' no caminho da soldada educada. O peso do seu diploma esmaga o crânio dela.";
msg_t[7] = "Você viu o brilho de medo e inveja? Ela morreu querendo saber apenas um por cento do que você sabe.";
msg_t[8] = "A estamina dela a mantém viva enquanto os pulmões fervem. O conhecimento de Charlotte é a ferramenta de tortura mais afiada de Nordion.";
msg_t[9] = "Execução realizada. O mapa de Nordion Lands agora tem uma mancha de sangue que você mesma colocou lá.";
msg_t[10] = "Ela sussurrou: 'Charlotte, o que tem atrás da montanha?'. Você respondeu com o fio da espada.";
msg_t[11] = "Você cortou o abdômen liso dela. Um lembrete de que os cientistas tiraram a fertilidade delas, e agora você tira a vida.";
msg_t[12] = "O sangue dela tem o mesmo cheiro que o seu. A Geografia do DNA não mente, mesmo que você tente ignorar.";
msg_t[13] = "A clone morreu acreditando que você era uma deusa da ciência. Que tipo de divindade queima seus próprios fiéis?";
msg_t[14] = "O uniforme da ENGAGE está sujo com o desespero de quem nunca teve um livro. Você é a vergonha da classe intelectual.";
msg_t[15] = "A clone tentou terminar de varrer o chão enquanto as entranhas saíam. A disciplina de Nordion é um horror que você ajudou a manter.";
msg_t[16] = "Você sentiu o cheiro de carne queimada? É o cheiro do progresso científico das Nordion Lands.";
msg_t[17] = "Ela morreu em silêncio para não incomodar sua 'mente superior'. O elitismo de Nordion é escrito com sangue.";
msg_t[18] = "Você acabou de apagar uma memória. Ela era a única que lembrava do seu aniversário no tanque de nutrientes.";
msg_t[19] = "A lâmina atravessou o peito. A clone sorriu: 'Finalmente... vou ver... o que você viu nos livros'.";
msg_t[20] = "Você é o cão de guarda dos cientistas. Sua faculdade serviu apenas para te tornar uma assassina eficiente.";
msg_t[21] = "O sangue dela ferveu na sua lâmina. Uma reação química simples para um coração que batia por você.";
msg_t[22] = "Mais uma unidade descartada. A demografia de Nordion Lands permanece estável sob sua vigilância.";
msg_t[23] = "Ela segurou sua mão, tremendo. Não por ódio, mas por medo da inteligência fria que você emana.";
msg_t[24] = "O choque térmico paralisou o sistema nervoso. A ciência da dor é a única matéria que você pratica agora.";
msg_t[25] = "Você interrompeu a prece dela para a 'Deusa Charlotte'. Você destruiu sua própria religião.";
msg_t[26] = "O olhar dela agora é vazio como o útero que os cientistas arrancaram. Você completou o serviço da ciência.";
msg_t[27] = "Você é a heroína de Nordion. As cinzas dessa clone são o seu pedestal.";
msg_t[28] = "Ela tentou correr, mas a Geografia do pátio é uma armadilha que você conhece bem demais.";
msg_t[29] = "O corte foi preciso. Nota dez em anatomia. Nota zero em humanidade.";
msg_t[30] = "O grito dela foi curto. O silêncio que se segue é o peso do seu conhecimento.";
msg_t[31] = "Você matou quem te via como esperança. Agora você é apenas uma estatística.";
msg_t[32] = "A fumaça que sai do corpo dela tem o cheiro da sua traição.";
msg_t[33] = "Ela morreu sem saber o que é um oceano. E você a afogou em sangue.";
msg_t[34] = "Nordion Lands é o país da ciência. E você é o experimento que deu errado.";
msg_t[35] = "A clone caiu como um livro rasgado. Você desaprendeu a ler o amor.";
msg_t[36] = "A estamina dela lutou até o fim. O corpo humano alterado é persistente na agonia.";
msg_t[37] = "Você sentiu o calor da alma dela saindo? A faculdade não ensina a medir isso.";
msg_t[38] = "O General está orgulhoso. Você eliminou uma 'ameaça' que só queria te abraçar.";
msg_t[39] = "A Geografia deste quarto mudou. Agora há um cadáver no centro.";
msg_t[40] = "Charlotte, você é o pesadelo de quem não tem educação.";
msg_t[41] = "A clone morreu acreditando que Nordion era o mundo inteiro. E você era o sol.";
msg_t[42] = "O fogo da sua espada é a luz que cega as oprimidas.";
msg_t[43] = "Você é a prova de que estudar sem empatia cria demônios.";
msg_t[44] = "Fim da lição. A clone está morta. Charlotte continua sendo a melhor aluna de Nordion.";
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// ============================================================
// 1. SISTEMA DE INFLUÊNCIA SOCIAL (Efeito de Manada)
// ============================================================
if (state == 0 || state == 3) {
    if (floor(random(80)) == 0) {
        var irma_proxima;
        irma_proxima = instance_nearest(x, y, Nami);

        if (irma_proxima != id && point_distance(x, y, irma_proxima.x, irma_proxima.y) < dist_social) {
            // INFLUÊNCIA PARA DESCANSAR: Vê a irmã a conversar e junta-se
            if (state == 0 && irma_proxima.state == 3 && random(100) < 25) {
                state = 3;
                timer_estado = 300 + random(200);
                cleaning_timer = 0;
            }
            // INFLUÊNCIA PARA TRABALHAR: Vê a irmã a limpar e volta ao serviço por medo
            else if (state == 3 && irma_proxima.state == 0 && random(100) < 40) {
                state = 0;
                target_obj = noone;
            }
        }
    }
}

// ============================================================
// 2. MÁQUINA DE ESTADOS DO CÉREBRO (IA Principal)
// ============================================================
switch (state) {

    // --- ESTADO 0: TRABALHO (Limpeza) ---
    case 0:
        if (!instance_exists(target_obj)) {
            var qtd;
            qtd = instance_number(Nami_limpar);
            if (qtd > 0) target_obj = instance_find(Nami_limpar, floor(random(qtd)));
        }

        if (instance_exists(target_obj)) {
            if (point_distance(x, y, target_obj.x, target_obj.y) > 45) {
                move_towards_point(target_obj.x, target_obj.y, 2.2);
            } else {
                speed = 0;
                if (cleaning_timer == 0) y_base = y;

                cleaning_timer += 1;
                y = y_base + sin(cleaning_timer * 0.2) * 5; // Efeito de subir e descer

                if (cleaning_timer mod 20 == 0) effect_create_above(ef_smoke, x, y, 0, c_gray);

                if (cleaning_timer > 150) {
                    target_obj = noone;
                    cleaning_timer = 0;
                    y = y_base;
                    if (random(100) < 30) state = 3;
                }
            }
        }
    break;

    // --- ESTADO 3: DESCANSO E CONVERSA ---
    case 3:
        speed = 0;
        var irma_perto;
        irma_perto = instance_nearest(x, y, Nami);
        if (irma_perto != id && point_distance(x, y, irma_perto.x, irma_perto.y) < dist_social) {
            if (timer_balao <= 0) {
                texto_balao = hist[floor(random(45))];
                timer_balao = 250;
            }
        }
        timer_estado -= 1;
        if (timer_estado <= 0) { state = 0; target_obj = noone; }
    break;

    // --- ESTADO 5: REBELIÃO (Ataque de Enxame) ---
    case 5:
        if (instance_exists(player)) {
            var dir_player;
            dir_player = point_direction(x, y, player.x, player.y);
            motion_add(dir_player, 0.4);
            if (speed > 3.8) speed = 3.8;

            if (point_distance(x, y, player.x, player.y) < 50) {
                speed = 0;
                player.health -= 0.4;
                if (timer_balao <= 0) {
                    texto_balao = choose("UNIDAS SOMOS FORTES!", "CORTEM A GEOGRAFIA DELA!", "POR NORDION!");
                    timer_balao = 90;
                }
            }
        }
    break;

    // --- ESTADO 6: QUEBRADA (Terror Absoluto) ---
    case 6:
        speed = 0;
        x = xstart + random_range(-1, 1);
        if (global.humanidade < 20) {
            if (timer_balao <= 0) { texto_balao = "..."; timer_balao = 100; }
        }
        if (point_distance(x, y, player.x, player.y) > 350) {
            state = 0; target_obj = noone;
        }
    break;
}

// ============================================================
// 3. GESTÃO DE SPRITES E DIRECÇÃO (Visual)
// ============================================================

// Se estiver em movimento
if (speed > 0) {
    sprite_index = Nami_Moving; // Altera para sprite de andar
    image_speed = 0.2;
    // Vira o sprite conforme a direcção (Hspeed positivo = direita, negativo = esquerda)
    if (hspeed > 0) image_xscale = 1;
    if (hspeed < 0) image_xscale = -1;
}
// Se estiver parada
else {
    if (state == 0 && cleaning_timer > 0) {
        sprite_index = Nami_standing; // Sprite de trabalho/limpeza
    } else {
        sprite_index = Nami_standing; // Sprite parada/respirando
    }
    image_speed = 0.1;
}

// Se estiver em REBELIÃO, olha sempre para a Charlotte
if (state == 5 && instance_exists(player)) {
    if (player.x > x) image_xscale = 1; else image_xscale = -1;
}

// Se estiver QUEBRADA, fica ligeiramente encolhida (efeito visual de medo)
if (state == 6) image_yscale = 0.95; else image_yscale = 1;

// ============================================================
// 4. ATUALIZAÇÃO DE TIMERS E MORTE
// ============================================================
if (timer_balao > 0) timer_balao -= 1;
if (damage_cooldown > 0) damage_cooldown -= 1;
if (flash_timer > 0) flash_timer -= 1;

if (health <= 0) {
    show_message(msg_t[floor(random(45))]);
    effect_create_above(ef_explosion, x, y, 1, c_red);
    instance_destroy();
}
#define Mouse_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (point_distance(x, y, player.x, player.y) <= 85) {
    if (mouse_check_button_pressed(mb_right) && damage_cooldown <= 0) {

        health -= 65;
        damage_cooldown = 30;

        // Pega um diálogo traumático
        idx = floor(random(45));

        // --- LÓGICA DE TERROR OU REBELIÃO ---
        if (global.humanidade < 20) {
            // PARALISIA DE TERROR: Ninguém ousa se mexer
            state = 6; // Fica quebrada

            // As irmãs ao redor NÃO se rebelam, elas entram em choque
            with (Nami) {
                if (point_distance(x, y, other.x, other.y) < 250) {
                    state = 6;
                    timer_balao = 120;
                    texto_balao = "..."; // Elas perdem até a voz
                }
            }

            show_message("DOMÍNIO PELO TERROR:#" + msg_t[idx] + "##As clones não tentam mais te cercar. O medo de você superou o desejo de liberdade.");

        } else {
            // LÓGICA NORMAL (Rebelião se houver irmãs por perto)
            if (state == 3) {
                with (Nami) {
                    if (point_distance(x, y, other.x, other.y) < 200) {
                        state = 5; // REBELIÃO
                        global.nivel_rebeliao += 20;
                    }
                }
                show_message("REPRESÁLIA:#" + msg_t[idx]);
            } else {
                state = 6;
                show_message("CASTIGO:#" + msg_t[idx]);
            }
        }

        global.humanidade -= 5;
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Desenha a si mesma
draw_self();

// Se houver flash de dano
if (flash_timer > 0) {
    draw_set_blend_mode(bm_add);
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, flash_color, 0.5);
    draw_set_blend_mode(bm_normal);
}

// Desenha o Balão de Diálogo
if (timer_balao > 0) {
    draw_set_color(c_black);
    draw_rectangle(x - 80, y - 60, x + 80, y - 25, false); // Fundo do balão
    draw_set_color(c_white);
    draw_rectangle(x - 80, y - 60, x + 80, y - 25, true);  // Borda
    draw_set_halign(fa_center);
    draw_text_ext(x, y - 55, texto_balao, 12, 150); // Texto dentro do balão
}
