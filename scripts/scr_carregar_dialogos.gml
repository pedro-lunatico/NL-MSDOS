/// --- DIÁLOGOS REALISTAS: CHARLOTTE (RIYO STYLE) & DEW ---

// --- Resposta de Cansaço/Pós-Coalescer (Realista) ---
dialogo_cooldown_coalescer = "Charlotte: Me solta, Dew. Eu to exausta, meu corpo parece que vai desmanchar e voce ainda quer falar? Cala a boca e me deixa em paz antes que eu me arrependa de ter deixado voce encostar em mim.";

// --- Diálogos de Desconhecido (15 - Distante e Autoritária) ---
ds_list_add(dialogos_desconhecido, "O que voce ta olhando? Circulando, antes que eu ache um motivo pra te prender.");
ds_list_add(dialogos_desconhecido, "Tenho cara de quem quer bater papo? Se nao tem autorizacao, some da minha frente.");
ds_list_add(dialogos_desconhecido, "Sou a Tenente da Engage. Nao sou sua guia e muito menos sua amiga. Vaza.");
ds_list_add(dialogos_desconhecido, "Sim, sou ruiva. Sim, sou Nami. Vai ficar encarando ate quando, seu merda?");
ds_list_add(dialogos_desconhecido, "O Fergus pode me tratar como ferramenta, mas voce nao tem esse direito. Fora.");
ds_list_add(dialogos_desconhecido, "Nao me toca. Minha paciencia ja acabou antes de voce abrir a boca.");
ds_list_add(dialogos_desconhecido, "Outro curioso querendo ver o 'clone da Lyn'. Voce me da nojo.");
ds_list_add(dialogos_desconhecido, "A Rosa Mei me fez pra trabalhar, nao pra ouvir choro de civil.");
ds_list_add(dialogos_desconhecido, "Nordion ja ta cheia de lixo, nao precisa de mais um vagabundo ocupando meu espaco.");
ds_list_add(dialogos_desconhecido, "Voce tem sorte da minha mae nao estar aqui. Ela nao seria tao educada.");
ds_list_add(dialogos_desconhecido, "Mantenha distancia do terminal. Isso aqui nao e brinquedo de entregador.");
ds_list_add(dialogos_desconhecido, "Se voce soubesse o que eu ja fiz pra chegar nesse posto, nao estaria sorrindo.");
ds_list_add(dialogos_desconhecido, "Voce me cheira a problema. E eu ja tenho problemas demais com a Lunatic Corp.");
ds_list_add(dialogos_desconhecido, "Quer um mapa? Compra um na loja. Nao sou cartografa publica.");
ds_list_add(dialogos_desconhecido, "Ultimo aviso: se eu vir sua cara de novo, eu te mando pro teleporto sem coordenadas.");

// --- Abraços (Ríspidos e Defensivos) ---
ds_list_add(dialogos_abracar_vc, "Nao aperta. So to vendo se voce ainda ta vivo pra fazer o serviço.");
ds_list_add(dialogos_abracar_vc, "Voce ta tremendo? Que patetico. Resolve esse seu trauma longe de mim.");
ds_list_add(dialogos_abracar_vc, "Isso nao e carinho, Dew. E so pra eu nao sentir frio nessa sala desgraçada.");
ds_list_add(dialogos_abracar_vc, "As vezes o corpo precisa de calor, mesmo vindo de alguem como voce.");
ds_list_add(dialogos_abracar_vc, "Nao acostuma. Eu ainda posso quebrar seu pescoço se voce tentar algo idiota.");

// --- Beijos (Testes de Impulso) ---
ds_list_add(dialogos_beijar_vc, "Pronto. Satisfeito? Agora volta pro seu trabalho e me deixa trabalhar.");
ds_list_add(dialogos_beijar_vc, "Sua boca tem gosto de desespero. Voce precisa escovar isso ai.");
ds_list_add(dialogos_beijar_vc, "Nao significa nada. Foi so contato biologico pra eu nao esquecer que sou humana.");
ds_list_add(dialogos_beijar_vc, "Voce beija como se estivesse pedindo permissao pra existir. Me irrita.");
ds_list_add(dialogos_beijar_vc, "Se voce contar pra Rosa ou pro Fergus, eu arranco sua lingua.");

// --- Xingamentos (Agressividade Pura) ---
ds_list_add(dialogos_xingar_vc, "O Fergus ta certo em te ignorar. Voce e um erro que respira.");
ds_list_add(dialogos_xingar_vc, "Achava que os Conote eram homens, nao essas maricas que choram por tudo.");
ds_list_add(dialogos_xingar_vc, "Eu estudei tortura na Engage Military. Quer que eu teste em voce, entregador?");
ds_list_add(dialogos_xingar_vc, "Se eu te chamasse de projeto falho, eu estaria sendo generosa.");
ds_list_add(dialogos_xingar_vc, "Ate um dragao homossexual tem mais culhao que voce, Dew.");

// --- Respostas do Dew (Masoquismo Realista) ---
ds_list_add(dialogos_xingar, "Isso... fala mais. Eu adoro quando voce me olha como se eu fosse nada, sua vadia ruiva.");
ds_list_add(dialogos_xingar, "Pode me bater se quiser. Eu prefiro sentir dor do que nao sentir nada vindo de voce.");
ds_list_add(dialogos_xingar, "Continua... sua cria de becker. No fundo, a gente e igual, dois restos de laboratorio.");

// --- Fúria: Becker (Peso de Injúria Racial/Existencial) ---
ds_list_add(dialogos_furia_becker, "Voce... voce teve a audacia de me chamar de CRIA DE BECKER? Voce sabe o que e ser fabricada pra satisfazer o ego de alguem?!");
ds_list_add(dialogos_furia_becker, "Cria de Becker? Voce acabou de assinar sua sentença. Eu vou te mostrar o monstro que voce tanto quer ver!");
ds_list_add(dialogos_furia_becker, "Retira isso agora, ou eu vou fazer o vapor do meu sangue ser a ultima coisa que voce vai ver!");

// --- Fúria: Lorca (Defesa da Honra Adotiva) ---
ds_list_add(dialogos_furia_lorca, "Nao ousa sujar o nome da General Lyn com essa sua boca de entregador de merda!");
ds_list_add(dialogos_furia_lorca, "Eu sou uma Lorca por escolha! Voce e um Conote por azar! Nao se compara a mim!");
/// --- CARREGAMENTO DE DIÁLOGOS (Gatilhos de Fúria) ---

// 1. DIÁLOGOS DO DEW - XINGAR (Onde ele provoca a fúria)
ds_list_add(dialogos_xingar, "Dew: Voce herdou o sangue frio daquela Cria de Becker, nao foi?");
ds_list_add(dialogos_xingar, "Dew: Me bate mais! Mostra que voce e uma verdadeira Cria de Becker!");
ds_list_add(dialogos_xingar, "Dew: Seus olhos brilham como os da General... voce e mesmo a Cria de Becker.");
ds_list_add(dialogos_xingar, "Dew: Voce e tao impiedosa... honrando o nome da Familia de Lorca.");
ds_list_add(dialogos_xingar, "Dew: A Familia de Lorca deve estar orgulhosa de ver voce me esmagar assim.");
ds_list_add(dialogos_xingar, "Dew: Voce e so uma ferramenta da Familia de Lorca, Charlotte.");
ds_list_add(dialogos_xingar, "Dew: Vai, me corta! Use essa furia da Cria de Becker em mim!");

// 2. DIÁLOGOS DO DEW - MIATA (Provocação misturada com desejo)
ds_list_add(dialogos_miata_dew, "Dew: Nem o Miata corre tanto quanto meu coracao quando vejo essa Cria de Becker brava.");
ds_list_add(dialogos_miata_dew, "Dew: Voce e mais rapida que um Miata e mais perigosa que qualquer Lorca.");
ds_list_add(dialogos_miata_dew, "Dew: Me persegue... como se eu fosse um alvo da Familia de Lorca!");

// 3. DIÁLOGOS DO DEW - BEIJAR (Mesmo no carinho, ele provoca)
ds_list_add(dialogos_beijar, "Dew: Um beijo doce... vindo de alguem tao amarga como essa Cria de Becker.");
ds_list_add(dialogos_beijar, "Dew: Voce beija como uma Lorca... querendo morder e dominar.");

ds_list_add(dialogos_desconhecido, "Dew: Voce ainda se lembra das raizes Sacae? tipo faz tempo que nao vejo Nomad Tropper");
ds_list_add(dialogos_desconhecido, "Dew: Uma Lorca por fora, mas o sangue Nami ainda ferve aí dentro.");
ds_list_add(dialogos_desconhecido, "Dew: Lyn mudou sua tribo, mas nao mudou quem voce e, Cria de Becker.");
ds_list_add(dialogos_desconhecido, "Dew: Por que aceita ser chamada de Lorca? voce nao eh uma Nami?");
ds_list_add(dialogos_desconhecido, "Dew: Os ventos de Sacae ainda sopram para a Familia de Lorca.");
ds_list_add(dialogos_desconhecido, "Dew: Voce e a General Lyn... as duas Lorcas mais letais que conheco.");
ds_list_add(dialogos_desconhecido, "Dew: O deserto sente falta da Cria de Becker original.");
ds_list_add(dialogos_desconhecido, "Dew: Ser uma Lorca te faz sentir mais poderosa ou apenas mais sozinha?");
ds_list_add(dialogos_desconhecido, "Dew: Voce luta como Guerreira de Sacae, mas mata como uma Cientista.");
ds_list_add(dialogos_desconhecido, "Dew: Charlotte Lorca... um nome que faz qualquer um tremer.");
ds_list_add(dialogos_desconhecido, "Dew: Voce renega sua linhagem Becker ou apenas a esconde?");
ds_list_add(dialogos_desconhecido, "Dew: Eu sei o segredo da Familia de Lorca... e eu adoro isso.");
ds_list_add(dialogos_desconhecido, "Dew: Me diga, Tenente... como e ser a ultima Cria de Becker?");
ds_list_add(dialogos_desconhecido, "Dew: Lorca para mim voce e apenas a minha senhora.");

// 5. RESPOSTAS DA CHARLOTTE (FÚRIA)
ds_list_add(dialogos_furia_becker, "Charlotte: NUNCA MAIS REPITA ESSE NOME!");
ds_list_add(dialogos_furia_becker, "Charlotte: EU VOU CORTAR SUA LINGUA POR DIZER ISSO!");
ds_list_add(dialogos_furia_lorca, "Charlotte: A Familia de Lorca nao e da sua conta, verme!");

// Charlotte perguntando ou refletindo
ds_list_add(dialogos_conversar_vc, "Charlotte: Voce ja parou pra pensar que a Lyn do passado nao reconheceria o que a Engage se tornou?");
ds_list_add(dialogos_conversar_vc, "Charlotte: Eu sou uma Lorca legitima, mas as vezes sinto que esse nome pesa mais do que minha propria existecia.");
ds_list_add(dialogos_conversar_vc, "Charlotte: O Fergus acha que eu sou so um projeto. Voce tambem me vê assim, Dew?");
ds_list_add(dialogos_conversar_vc, "Charlotte: Nordion Lands e um lugar frio... as vezes eu so queria que o alguem fizesse algo para mudar");

// Respostas do Dew sobre a relação
ds_list_add(dialogos_conversar_dew, "Dew: Eu nao ligo pro que a Engage diz. Pra mim, voce e a única coisa real nesse deserto de tecnologia.");
ds_list_add(dialogos_conversar_dew, "Dew: A gente e resto de laboratorio, Charlotte. Por isso eu te entendo melhor que qualquer General.");
ds_list_add(dialogos_conversar_dew, "Dew: Voce nao precisa ser a Lyn. Voce so precisa continuar sendo essa ruiva que acaba comigo.");

/// --- DIÁLOGOS DE INSEGURANÇA E LORE (CONOTE) ---
ds_list_add(dialogos_inseguranca_dew, "Dew: Voce recebe ordens dele todo dia, nao recebe? O Fergus... o grande imperador que deixou o resto de nos apodrecendo no deserto de Conote.");
ds_list_add(dialogos_inseguranca_dew, "Dew: Por que voce fica do lado dele? Ele te vê como uma ferramenta, Charlotte. Ele vê todos nos como ferramentas descartaveis.");
ds_list_add(dialogos_inseguranca_dew, "Dew: O Fergus foi embora sozinho, criou o imperio dele e esqueceu que o sangue Conote ainda corre nas minhas veias.");
ds_list_add(dialogos_inseguranca_dew, "Dew: Eu sou so o primo que ficou pra tras, nao sou? O entregador que nao serve pra nada alem de levar suas cartas.");

/// --- DIÁLOGOS DE PRECONCEITO (A FALHA DO DEW) ---
ds_list_add(dialogos_preconceito_dew, "Dew: Voce tenta agir como se tivesse alma, mas eu sei que voce foi montada. Voce e so carne sintetica com o nome de uma morta.");
ds_list_add(dialogos_preconceito_dew, "Dew: Me diz, Charlotte... o que acontece se eu puxar o cabo da sua tomada? Voce ainda vai fingir que me ama?");
ds_list_add(dialogos_preconceito_dew, "Dew: Voce e so um modelo 'Revolution'. Uma falha de fabrica que o Mark comprou por pena.");

/// --- DIÁLOGOS DE REDENÇÃO (CHARLOTTE TENTANDO CONSERTAR) ---
ds_list_add(dialogos_consertar_vc, "Charlotte: Voce nao e o Fergus, Dew. Nao deixa essa raiva do deserto te transformar no monstro que ele e.");
ds_list_add(dialogos_consertar_vc, "Charlotte: Eu nao posso mudar meu superior, mas eu posso te mostrar que ser um Conote nao significa ser amargo.");
ds_list_add(dialogos_consertar_vc, "Charlotte: Dew, olha pra mim. Voce e gentil, voce respeita as pessoas... nao usa esse preconceito contra mim pra esconder sua dor.");
ds_list_add(dialogos_consertar_vc, "Charlotte: Eu sou um clone, sim. Mas eu escolhi sentir. Por que voce esta escolhendo odiar?");
/// scr_carregar_dialogos()

// --- 1. DESCONHECIDO (Charlotte Ríspida) ---
ds_list_add(dialogos_desconhecido, "O que voce ta olhando? Circulando, antes que eu ache um motivo pra te prender.");
ds_list_add(dialogos_desconhecido, "Tenho cara de quem quer bater papo? Se nao tem autorizacao, some da minha frente.");
ds_list_add(dialogos_desconhecido, "Sou a Tenente da Engage. Nao sou sua guia. Vaza.");
// ... adicione mais conforme seu script anterior ...

// --- 2. INSEGURANÇA CONOTE & RAIVA DO FERGUS (32 variações de tom) ---
ds_list_add(dialogos_conversar_dew, "Dew: O Fergus sempre teve tudo. Nordion, a Engage... e deixou a gente no deserto de Conote pra apodrecer.");
ds_list_add(dialogos_conversar_dew, "Dew: Voce e so mais um trofeu dele, nao e? Mais uma peça da Fergus Industries que ele exibe.");
ds_list_add(dialogos_conversar_dew, "Dew: Eu sou so a sombra do meu primo. O Conote que nao deu certo.");
ds_list_add(dialogos_conversar_dew, "Dew: Por que ele pode ter um imperio e eu so posso ter essa mala de entregador?");
ds_list_add(dialogos_conversar_dew, "Dew: Ele te olha como se fosse dono da sua alma... isso me da um odio que nao cabe no peito.");
// (Continue adicionando variações sobre: Abandono, Deserto, Inveja do Primo, Sombra)

// --- 3. PRECONCEITO CONTRA CLONES (A Mágoa do Dew) ---
ds_list_add(dialogos_conversar_dew, "Dew: No fim das contas, voce e so hardware, Charlotte. Carne sintetica com cheiro de laboratorio.");
ds_list_add(dialogos_conversar_dew, "Dew: Voce tenta ser gentil, mas eu sei que e so sua programação Revolution falhando.");
ds_list_add(dialogos_conversar_dew, "Dew: Voce nao tem pais. Voce tem fabricantes. O Mark so te comprou por caridade.");
ds_list_add(dialogos_conversar_dew, "Dew: Quantas como voce ja foram descartadas antes dessa versao ficar 'pronta'?");
// (Continue adicionando variações sobre: Maquina, Falha, Carne Sintetica, Becker)

// --- 4. CHARLOTTE TENTANDO "CONSERTAR" (A Redenção) ---
ds_list_add(dialogos_conversar_vc, "Charlotte: Dew, para! Voce nao e o Fergus. Voce nao precisa ser cruel pra ser notado.");
ds_list_add(dialogos_conversar_vc, "Charlotte: Eu sou um clone, mas meu carinho por voce e mais real que qualquer coisa que o Fergus ja sentiu.");
ds_list_add(dialogos_conversar_vc, "Charlotte: Nao deixa o deserto de Conote secar seu coraçao. Voce ainda e um homem gentil.");
ds_list_add(dialogos_conversar_vc, "Charlotte: Eu nao posso mudar quem me criou, mas eu posso te ajudar a mudar quem voce quer ser.");
ds_list_add(dialogos_conversar_vc, "Charlotte: Voce me chama de maquina pra esconder que esta com medo de me amar, nao e?");
// (Continue adicionando variações sobre: Escolha, Mudança, Salvação, Futuro)

// --- 5. GATILHOS DE FÚRIA (OS PERIGOSOS) ---
ds_list_add(dialogos_xingar, "Dew: Me bate, sua Cria de Becker! Mostra que voce e so um monstro da Fergus!");
ds_list_add(dialogos_furia_becker, "Charlotte: VOCE NAO TEM O DIREITO DE USAR ESSE NOME! EU VOU TE ENSINAR O MEU VALOR!");

// --- Respostas do Dew quando ela nega repetir (O Conflito) ---
dialogo_dew_aceita_cooldown = "Dew: Tudo bem... eu entendo. Seu corpo nao foi feito pra aguentar tanto estresse. Descansa, eu fico aqui do seu lado.";
dialogo_dew_reclamar_cooldown = "Dew: Serio? Ate nisso voce vai ser limitada? O Fergus nunca me disse que as Namis quebravam tao facil depois de um pouco de diversao.";
