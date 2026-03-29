/// scr_carregar_dialogos()
/// scr_init_sistemas()
// Inicializa as variÃ¡veis globais de memÃ³ria e relacionamento

global.memoria_grid = ds_grid_create(4, 0); // Cria a grid com 4 colunas e 0 linhas

// Carrega o total de memÃ³rias do arquivo para redimensionar a grid
ini_open("memoria_dew.ini");
    var total;
    total = ini_read_real("Sistema", "total_memorias", 0);
ini_close();

// Se jÃ¡ existirem memÃ³rias salvas, vocÃª deve rodar o script de carregar
if (total > 0) {
    scr_carregar_memorias(); // Veremos esse script abaixo
}

// --- LIMPEZA DE SEGURANÃ‡A ---
ds_list_clear(dialogos_desconhecido);
ds_list_clear(dialogos_amigavel_vc);
ds_list_clear(dialogos_amigavel);
ds_list_clear(dialogos_abracar_vc);
ds_list_clear(dialogos_abracar);
ds_list_clear(dialogos_beijar_vc);
ds_list_clear(dialogos_beijar);
ds_list_clear(dialogos_xingar_vc);
ds_list_clear(dialogos_xingar);
ds_list_clear(dialogos_coalescer_vc);
ds_list_clear(dialogos_coalescer);

// --- 1. DIÃLOGOS DE DESCONHECIDO (Fir Lorca/Djute) ---
ds_list_add(dialogos_desconhecido, "Fir: Ei! Vi vocÃª saindo daquele aviÃ£o. NÃ£o precisa se esconder.");
ds_list_add(dialogos_desconhecido, "Fir: VocÃª estÃ¡ pÃ¡lida. O vento de Baldr nÃ£o perdoa quem vem de laboratÃ³rios.");
ds_list_add(dialogos_desconhecido, "Fir: Minha tribo mudou de nome para Lorca... mas o sangue ainda Ã© Djute.");
ds_list_add(dialogos_desconhecido, "Fir: De onde eu venho, o Ãºnico cheiro permitido Ã© o do vento e dos cavalos.");
ds_list_add(dialogos_desconhecido, "Fir: Nordion nÃ£o vai te achar aqui. O cÃ©u Ã© o Ãºnico mestre em Sacae.");
ds_list_add(dialogos_desconhecido, "Fir: Lorca Ã© o que restou de nÃ³s depois que a General Lyn foi para a Engage.");
ds_list_add(dialogos_desconhecido, "Fir: VocÃª parece uma boneca de vidro que esqueceu como se quebra.");
ds_list_add(dialogos_desconhecido, "Fir: Revolution... um nome barulhento para alguÃ©m tÃ£o silenciosa.");
ds_list_add(dialogos_desconhecido, "Fir: Beber essa Ã¡gua tingida de morango Ã© como beber as lÃ¡grimas do meu pai.");
ds_list_add(dialogos_desconhecido, "Fir: Sinto que suas mÃ£os tremem. Ã‰ o frio do metal ou medo do futuro?");
ds_list_add(dialogos_desconhecido, "Fir: Minha espada protege quem o vento traz. NÃ£o tenha medo de mim.");
ds_list_add(dialogos_desconhecido, "Fir: Bartre queria salvar o mundo com aÃ§Ãºcar. Eu prefiro salvÃ¡-lo com aÃ§o.");
ds_list_add(dialogos_desconhecido, "Fir: Se vocÃª nÃ£o tem para onde ir, venha para as planÃ­cies. Elas sÃ£o vastas.");
ds_list_add(dialogos_desconhecido, "Fir: O Stardust Protocol nÃ£o alcanÃ§a as tendas da minha tribo.");
ds_list_add(dialogos_desconhecido, "Fir: Tome um pouco de milkshake. O calor deste aeroporto Ã© sufocante.");
ds_list_add(dialogos_desconhecido, "Fir: Estranha... vocÃª pisa em solo que pertence Ã  tribo, mas seus olhos nÃ£o veem as marcaÃ§Ãµes.");
ds_list_add(dialogos_desconhecido, "Fir: Os ventos de Sacae sopram segredos que apenas os Lorca conseguem ouvir. VocÃª Ã© apenas ruÃ­do.");
ds_list_add(dialogos_desconhecido, "Fir: Minha tribo mudou de nome apÃ³s a partida da General Lyn, mas nossa honra permanece a mesma.");
ds_list_add(dialogos_desconhecido, "Fir: Cuidado onde aponta esse bastÃ£o. O povo Lorca nÃ£o gosta de tecnologia barulhenta em seus campos.");
ds_list_add(dialogos_desconhecido, "Fir: VocÃª pergunta demais. Na minha tribo, aprendemos a observar o horizonte antes de abrir a boca.");
ds_list_add(dialogos_desconhecido, "Fir: Onde vocÃª estÃ¡? EstÃ¡ sob o olhar vigilante de uma Lorca. Isso deveria bastar como aviso.");
ds_list_add(dialogos_desconhecido, "Fir: Seus mapas de alumÃ­nio sÃ£o inÃºteis aqui. A geografia da tribo Ã© escrita no sangue e na grama.");
ds_list_add(dialogos_desconhecido, "Fir: NÃ£o somos mais quem Ã©ramos desde que a General partiu para a Engage, mas a tribo ainda sobrevive.");
ds_list_add(dialogos_desconhecido, "Fir: VocÃª cheira a laboratÃ³rio e Ã³leo. Um contraste ofensivo para as tradiÃ§Ãµes Lorca.");
ds_list_add(dialogos_desconhecido, "Fir: Se busca abrigo, saiba que a hospitalidade da tribo tem um preÃ§o: o respeito total.");
ds_list_add(dialogos_desconhecido, "Fir: Eu sou Fir, uma lÃ¢mina solitÃ¡ria de uma tribo que o tempo tenta esquecer.");
ds_list_add(dialogos_desconhecido, "Fir: Muitos estrangeiros se perdem aqui procurando os Lorca, mas poucos sobrevivem ao encontro.");
ds_list_add(dialogos_desconhecido, "Fir: O soco azedo desse mar vermelho nÃ£o apaga as memÃ³rias da minha tribo, viajante.");
ds_list_add(dialogos_desconhecido, "Fir: Guarde suas perguntas. Os Lorca valorizam o silÃªncio tanto quanto o corte de uma espada.");
ds_list_add(dialogos_desconhecido, "Fir: VocÃª parece perdida, Revolution. Talvez os espÃ­ritos da tribo tenham te trazido aqui por um motivo.");

// --- 2. AMIGÃVEL (MAIS HUMANA) ---
ds_list_add(dialogos_amigavel_vc, "Fir, Ã s vezes sinto que esse bastÃ£o Ã© pesado demais para as minhas mÃ£os.");
ds_list_add(dialogos_amigavel, "EntÃ£o segure a minha mÃ£o, Revolution. O aÃ§o Ã© mais leve quando compartilhado.");
ds_list_add(dialogos_amigavel_vc, "O gosto desse suco me traz uma lembranÃ§a... algo antes da UERJ.");
ds_list_add(dialogos_amigavel, "SÃ£o memÃ³rias, baka! O morango tem esse poder de despertar o que estava adormecido.");
ds_list_add(dialogos_amigavel_vc, "O vento de Sacae Ã©... diferente. Ele nÃ£o tem cheiro de ozÃ´nio.");
ds_list_add(dialogos_amigavel, "Ã‰ o cheiro da liberdade. Acostume seus pulmÃµes a ele.");
ds_list_add(dialogos_amigavel_vc, "VocÃª acha que eu ainda consigo aprender a cavalgar como uma Lorca?");
ds_list_add(dialogos_amigavel, "Desde que vocÃª pare de tentar calcular o Ã¢ngulo da sela e apenas sinta o cavalo!");

// --- 3. ABRAÃ‡AR (CONFORTO) ---
ds_list_add(dialogos_abracar_vc, "Eu sinto um aperto no peito... mas nÃ£o Ã© dor. Ã‰ algo quente.");
ds_list_add(dialogos_abracar, "Isso se chama carinho. Pode se encostar, eu nÃ£o vou deixar o mundo te tocar agora.");
ds_list_add(dialogos_abracar_vc, "Seu abraÃ§o faz o barulho das mÃ¡quinas na minha cabeÃ§a parar.");
ds_list_add(dialogos_abracar, "Deixe o silÃªncio de Sacae cuidar de vocÃª. Eu estou aqui.");
ds_list_add(dialogos_abracar_vc, "Eu tinha medo de que, se alguÃ©m me tocasse, eu fosse quebrar.");
ds_list_add(dialogos_abracar, "VocÃª nÃ£o Ã© de vidro, Revolution. VocÃª Ã© forte, sÃ³ precisa de um lugar para descansar.");

// --- 4. BEIJAR (MAIS EMOÃ‡ÃƒO) ---
ds_list_add(dialogos_beijar_vc, "Quando vocÃª me beija, eu esqueÃ§o quem me criou. SÃ³ lembro de quem eu sou agora.");
ds_list_add(dialogos_beijar, "VocÃª Ã© minha. NÃ£o da Rosa, nÃ£o do Becker... sÃ³ minha.");
ds_list_add(dialogos_beijar_vc, "Eu sinto que meus lÃ¡bios estÃ£o pegando fogo. Ã‰ normal sentir esse choque?");
ds_list_add(dialogos_beijar, "NÃ£o Ã© eletricidade do seu traje, baka... Ã© o que eu sinto por vocÃª!");
ds_list_add(dialogos_beijar_vc, "Sempre me disseram que o amor era uma falha quÃ­mica. Eles mentiram.");
ds_list_add(dialogos_beijar, "Eles nunca conheceram uma mirmidÃ£ de Sacae para saber o que Ã© verdade.");

// --- 5. XINGAR (CONFLITO HUMANO) ---
ds_list_add(dialogos_xingar_vc, "Por que vocÃª me olha como se eu fosse um defeito? Eu tambÃ©m sofro!");
ds_list_add(dialogos_xingar, "EU NÃƒO SUPORTO esse cheiro de laboratÃ³rio que vocÃª exala! VÃ¡ embora!");
ds_list_add(dialogos_xingar_vc, "Rosa Mei me deu uma vida que eu nunca pedi! NÃ£o me culpe pelos erros dela!");
ds_list_add(dialogos_xingar, "VOCÃŠ Ã‰ FRIA! Ã€s vezes parece que o Becker arrancou sua alma junto com suas memÃ³rias!");

// --- 6. COALESCER (CONEXÃƒO PROFUNDA) ---
ds_list_add(dialogos_coalescer_vc, "Eu nunca soube o que era pertencer a algum lugar atÃ© sentir seu corpo no meu.");
ds_list_add(dialogos_coalescer, "Em Sacae, nÃ£o somos nÃºmeros. Somos o que amamos. E eu amo vocÃª.");
ds_list_add(dialogos_coalescer_vc, "Deixe-me sentir seu pulso... quero que o meu aprenda a bater no seu ritmo.");
ds_list_add(dialogos_coalescer, "EsqueÃ§a os cÃ³digos da UERJ. O Ãºnico cÃ³digo aqui Ã© a nossa pele.");
ds_list_add(dialogos_coalescer_vc, "Eu nÃ£o sou mais um experimento. Eu sou uma mulher, e sou sua.");
ds_list_add(dialogos_coalescer, "Finalmente vocÃª entendeu. Bem-vinda ao lar, Revolution.");
ds_list_add(dialogos_coalescer, "Fir: Nordion pode ter desenhado seu sangue, mas eu sinto sua alma. Para os Lorca, vocÃª Ã© mais real que qualquer metal.");
ds_list_add(dialogos_coalescer, "Fir: Eles dizem que vocÃª Ã© um produto, mas eu sinto o calor da sua vida. VocÃª Ã© mulher, Revolution. O meu coraÃ§Ã£o nÃ£o mentiria para mim.");
ds_list_add(dialogos_coalescer_vc, "Revolution: Sem Ãºtero, sem passado... Ã s vezes sinto que sou apenas uma simulaÃ§Ã£o de vida. Mas com vocÃª, eu sinto que existo.");
ds_list_add(dialogos_coalescer_vc, "Revolution: VocÃª me olha como se eu nÃ£o fosse um experimento. Pela primeira vez, nÃ£o me sinto um rascunho de laboratÃ³rio.");
ds_list_add(dialogos_coalescer_vc, "Revolution: VocÃª me olha como se eu nÃ£o fosse um experimento. Pela primeira vez, nÃ£o me sinto um rascunho de laboratÃ³rio.");
ds_list_add(dialogos_coalescer_vc, "Nordion Lands nÃ£o me deu um Ãºtero, mas vocÃª me faz sentir mulher.");
// --- 15 NOVOS DIÃLOGOS ADICIONAIS ---
ds_list_add(dialogos_amigavel_vc, "Fir, vocÃª me ensina a ler o cÃ©u? Eu sÃ³ sei ler telas...");
ds_list_add(dialogos_amigavel, "O cÃ©u nÃ£o mente como as telas. Ele diz quando a chuva vem limpar a alma.");
ds_list_add(dialogos_amigavel_vc, "Minhas mÃ£os estÃ£o sujas de graxa, mas eu queria segurar as suas.");
ds_list_add(dialogos_amigavel, "Graxa sai com Ã¡gua, mas o que eu sinto por vocÃª nÃ£o sai com nada.");
ds_list_add(dialogos_abracar_vc, "Ã€s vezes tenho pesadelos com tanques de oxigÃªnio e luzes brancas...");
ds_list_add(dialogos_abracar, "Shh... sinta meu cheiro. Cheiro de terra e sol. Isso Ã© real agora.");
ds_list_add(dialogos_beijar_vc, "Eu nunca pensei que o gosto de morango pudesse ser tÃ£o... viciante.");
ds_list_add(dialogos_beijar, "Ã‰ o gosto da vida que vocÃª estÃ¡ descobrindo agora.");
ds_list_add(dialogos_xingar_vc, "Eu odeio o jeito que vocÃª ignora os fatos para seguir sua intuiÃ§Ã£o!");
ds_list_add(dialogos_xingar, "IntuiÃ§Ã£o Ã© o que nos mantÃ©m vivos onde sua lÃ³gica falha, robÃ´!");
ds_list_add(dialogos_coalescer_vc, "Sinto que minha alma estÃ¡ se fundindo Ã  sua, Fir.");
ds_list_add(dialogos_coalescer, "Isso Ã© o que os antigos chamavam de destino. Nascemos de mundos diferentes para nos unir aqui.");
ds_list_add(dialogos_desconhecido, "Fir: VocÃª olha para o horizonte como se esperasse um comando. Aqui, vocÃª decide.");
ds_list_add(dialogos_desconhecido, "Fir: Meu pai dizia que o aÃ§Ãºcar cura a tristeza. Onde estÃ¡ a sua?");
ds_list_add(dialogos_desconhecido, "Fir: VocÃª Ã© como um relÃ¢mpago preso em uma garrafa de vidro. Deixe-se sair.");

// --- 8. STATUS DA RELAÃ‡ÃƒO (O QUE ELA ACHA) ---
ds_list_add(status_estranha, "Fir: VocÃª Ã© apenas alguÃ©m que o vento trouxe. NÃ£o sei se deve ficar.");
ds_list_add(status_conhecida, "Fir: VocÃª Ã© persistente, admito. Mas o metal de Nordion ainda me causa calafrios.");
ds_list_add(status_amiga, "Fir: Eu confio na sua espada... e comeÃ§o a gostar da sua companhia, Revolution.");
ds_list_add(status_namorada, "Fir: VocÃª se tornou meu horizonte. Sacae nÃ£o seria a mesma sem vocÃª.");
ds_list_add(status_esposa, "Fir: VocÃª Ã© minha tribo agora. Meu sangue, meu lar, minha vida.");
ds_list_add(status_namorada, "Fir: VocÃª se preocupa demais com o que os cientistas dizem. Eu nÃ£o me importo que vocÃª foi 'feita'. Eu me importo que vocÃª estÃ¡ aqui.");
ds_list_add(status_esposa, "Fir: VocÃª nÃ£o Ã© um produto da Fergus Industries. VocÃª Ã© minha esposa, o meu lar. Nenhuma modificaÃ§Ã£o genÃ©tica pode tirar a dignidade que vocÃª tem ao meu lado.");
// DiÃ¡logo do Tesouro de Sacae (PÃ³s-Casamento)
ds_list_add(status_esposa, "Fir: Revolution, agora que somos uma sÃ³ carne perante os ventos, posso te mostrar o segredo que minha tribo protege hÃ¡ geraÃ§Ãµes.");
ds_list_add(status_esposa, "Fir: Nas profundezas das fendas de Sacae, existe um tesouro... uma gosma preta e viscosa que brota da pedra. Ela exala um cheiro forte, como o hÃ¡lito de uma besta de metal. Meu pai dizia que era o sangue da terra, mas nunca soubemos o que fazer com ele.");

/// --- EXPANSÃƒO DO SCRIPT EXTERNO (VERSÃƒO LIMPA PARA O SEU STEP) ---

// --- 1. DIÃLOGOS DE DESCONHECIDO (Fir Lorca/Djute) ---
ds_list_add(dialogos_desconhecido, "Seus olhos tÃªm um brilho que nÃ£o vem do sol. Ã‰ a marca da Nordion?");
ds_list_add(dialogos_desconhecido, "VocÃª caminha como se o chÃ£o das planÃ­cies fosse instÃ¡vel. Onde vocÃª cresceu?");
ds_list_add(dialogos_desconhecido, "Minha tribo sobreviveu ao fim de Sacae. Seus criadores sobreviveriam ao inverno aqui?");
ds_list_add(dialogos_desconhecido, "O sangue Djute ferve quando vemos alguÃ©m que foi 'moldado' por mÃ£os humanas.");
ds_list_add(dialogos_desconhecido, "VocÃª Ã© feita de carne, mas sua postura Ã© de quem foi treinada em um laboratÃ³rio frio.");
ds_list_add(dialogos_desconhecido, "O soco de morango que vocÃª bebe... tem o cheiro do arrependimento do meu pai.");
ds_list_add(dialogos_desconhecido, "VocÃª nÃ£o tem o cheiro da terra. Tem o cheiro de produtos quÃ­micos e antissÃ©pticos.");
ds_list_add(dialogos_desconhecido, "Por que a UERJ mandaria uma de suas 'obras' para as nossas tendas?");
ds_list_add(dialogos_desconhecido, "VocÃª parece uma guerreira, mas seus movimentos sÃ£o calculados demais. Falta-lhe instinto.");
ds_list_add(dialogos_desconhecido, "O vento de Sacae nÃ£o se importa com seu pedigree genÃ©tico, estrangeira.");
ds_list_add(dialogos_desconhecido, "A General Lyn dizia que a honra nÃ£o pode ser injetada em uma veia.");
ds_list_add(dialogos_desconhecido, "Seus mapas de metal nÃ£o mostram as rotas de fuga dos Lorca.");
ds_list_add(dialogos_desconhecido, "VocÃª Ã© humana, eu sinto o calor... mas Ã© uma humanidade que parece sob pressÃ£o.");
ds_list_add(dialogos_desconhecido, "Os cavalos sentem quando alguÃ©m nÃ£o nasceu sob o cÃ©u aberto.");
ds_list_add(dialogos_desconhecido, "VocÃª Ã© um experimento que deu certo ou uma pessoa que deu errado?");
ds_list_add(dialogos_desconhecido, "Minha espada nÃ£o faz distinÃ§Ã£o entre carne natural e carne modificada.");
ds_list_add(dialogos_desconhecido, "VocÃª busca um propÃ³sito ou apenas foge da UERJ?");
ds_list_add(dialogos_desconhecido, "O horizonte de Sacae Ã© vasto demais para quem viveu em salas fechadas.");
ds_list_add(dialogos_desconhecido, "Bartre me ensinou que a forÃ§a vem do espÃ­rito, nÃ£o da genÃ©tica.");
ds_list_add(dialogos_desconhecido, "Suas mÃ£os tremem. Ã‰ o frio de Baldr ou o peso do seu passado transgÃªnico?");
ds_list_add(dialogos_desconhecido, "A tribo Lorca nÃ£o pergunta seu nome, pergunta se vocÃª sabe lutar.");
ds_list_add(dialogos_desconhecido, "Seus criadores acham que sÃ£o deuses. Eles jÃ¡ viram a fÃºria de uma mirmidÃ£?");
ds_list_add(dialogos_desconhecido, "VocÃª Ã© pÃ¡lida como quem nunca sentiu o sol de verdade na pele.");
ds_list_add(dialogos_desconhecido, "NÃ£o toque nos nossos altares. Eles pertencem ao espÃ­rito, nÃ£o Ã  ciÃªncia.");
ds_list_add(dialogos_desconhecido, "HÃ¡ um vazio no seu olhar... como se tivessem apagado quem vocÃª era.");
ds_list_add(dialogos_desconhecido, "Revolution... um nome barulhento para quem carrega tanto silÃªncio.");
ds_list_add(dialogos_desconhecido, "O mundo lÃ¡ fora estÃ¡ morrendo em metal. Aqui, ainda somos de sangue.");
ds_list_add(dialogos_desconhecido, "O que Nordion Lands espera ganhar enviando vocÃª atÃ© aqui?");
ds_list_add(dialogos_desconhecido, "Se vocÃª for ficar, aprenda que aqui o vento Ã© quem dÃ¡ as ordens.");
ds_list_add(dialogos_desconhecido, "VocÃª Ã© uma humana incompleta ou uma evoluÃ§Ã£o perigosa?");

// --- 2. MAIS 30 DIÃLOGOS AMIGÃVEIS (AMIZADE/CONFORTO) ---
ds_list_add(dialogos_amigavel_vc, "Fir, Ã s vezes sinto que meu sangue corre rÃ¡pido demais... medo da minha prÃ³pria biologia.");
ds_list_add(dialogos_amigavel, "EntÃ£o deixe meu braÃ§o ser sua Ã¢ncora. O sangue Lorca tambÃ©m ferve, e nÃ³s controlamos.");
ds_list_add(dialogos_amigavel_vc, "O laboratÃ³rio nunca me ensinou a apreciar o silÃªncio da noite.");
ds_list_add(dialogos_amigavel, "O silÃªncio Ã© onde a alma fala mais alto. Aprenda a ouvi-la.");
ds_list_add(dialogos_amigavel_vc, "VocÃª me olha como se eu fosse... real.");
ds_list_add(dialogos_amigavel, "Porque vocÃª Ã©. ModificaÃ§Ãµes nÃ£o mudam o brilho dos seus olhos.");
ds_list_add(dialogos_amigavel_vc, "O gosto do morango estÃ¡ ficando menos estranho... quase familiar.");
ds_list_add(dialogos_amigavel, "Ã‰ o gosto da vida simples. Bem diferente das fÃ³rmulas da UERJ.");
ds_list_add(dialogos_amigavel_vc, "Meus criadores diziam que eu nÃ£o deveria ter sentimentos desnecessÃ¡rios.");
ds_list_add(dialogos_amigavel, "Cientistas sÃ£o estÃºpidos. Sentir Ã© o que nos torna guerreiras.");
ds_list_add(dialogos_amigavel_vc, "Sinto que minhas mÃ£os foram feitas para a destruiÃ§Ã£o.");
ds_list_add(dialogos_amigavel, "EntÃ£o use-as para proteger. A espada serve para ambos.");
ds_list_add(dialogos_amigavel_vc, "O vento de Sacae... ele parece limpar a graxa da minha alma.");
ds_list_add(dialogos_amigavel, "Ele sopra de onde as lendas nascem. Deixe que ele te leve para longe de Nordion.");
ds_list_add(dialogos_amigavel_vc, "Eu nÃ£o tenho memÃ³rias de infÃ¢ncia. SÃ³ de tanques e luzes brancas.");
ds_list_add(dialogos_amigavel, "EntÃ£o criaremos memÃ³rias agora. Sob o sol, nÃ£o sob lÃ¢mpadas.");
ds_list_add(dialogos_amigavel_vc, "VocÃª acha que a General Lyn aceitaria alguÃ©m como eu na tribo?");
ds_list_add(dialogos_amigavel, "Ela aceitava quem tinha o coraÃ§Ã£o mirmidÃ£. O seu bate forte como um.");
ds_list_add(dialogos_amigavel_vc, "Ã€s vezes meu corpo dÃ³i por causa dos tratamentos que recebi.");
ds_list_add(dialogos_amigavel, "Descanse na minha tenda. O aÃ§o dos Lorca protege seus amigos.");
ds_list_add(dialogos_amigavel_vc, "Eu sou um rascunho de mulher, Fir. Sem passado, sem destino.");
ds_list_add(dialogos_amigavel, "O destino Ã© o que vocÃª faz agora. E vocÃª estÃ¡ aqui comigo.");
ds_list_add(dialogos_amigavel_vc, "Seu pai... ele pareceu me olhar com pena.");
ds_list_add(dialogos_amigavel, "Bartre Ã© bruto, mas ele vÃª que vocÃª sofreu. Ele respeita sua forÃ§a.");
ds_list_add(dialogos_amigavel_vc, "Eu nunca aprendi a brincar... sÃ³ a treinar com esse bastÃ£o.");
ds_list_add(dialogos_amigavel, "Brincar Ã© apenas treinar a felicidade. Vamos comeÃ§ar agora.");
ds_list_add(dialogos_amigavel_vc, "Minha pele Ã© resistente demais. Ã€s vezes esqueÃ§o como Ã© ser sensÃ­vel.");
ds_list_add(dialogos_amigavel, "Eu vou te lembrar. Cada toque Ã© uma liÃ§Ã£o de sensibilidade.");
ds_list_add(dialogos_amigavel_vc, "VocÃª nÃ£o tem medo de que minha genÃ©tica falhe um dia?");
ds_list_add(dialogos_amigavel, "Todos nÃ³s falhamos, baka. O que importa Ã© como caÃ­mos e como levantamos.");

// --- 3. MAIS 30 DIÃLOGOS DE COALESCER / ESPOSA (ConexÃ£o Profunda) ---
ds_list_add(dialogos_coalescer, "Nordion Lands desenhou sua carne, mas eu reivindico sua alma perante a tribo.");
ds_list_add(dialogos_coalescer_vc, "NÃ£o ter um Ãºtero me fazia sentir um erro da natureza. Com vocÃª, me sinto uma deusa.");
ds_list_add(dialogos_coalescer, "VocÃª Ã© a mulher que eu escolhi. A biologia de laboratÃ³rio nÃ£o pode apagar nosso amor.");
ds_list_add(dialogos_coalescer_vc, "Sinto que finalmente pertenÃ§o a algo que nÃ£o tem nÃºmero de sÃ©rie.");
ds_list_add(dialogos_coalescer, "VocÃª Ã© Fir Lorca, tanto quanto eu. Somos uma sÃ³ lÃ¢mina agora.");
ds_list_add(dialogos_coalescer_vc, "O segredo do petrÃ³leo... ele queima como o calor que vocÃª me dÃ¡.");
ds_list_add(dialogos_coalescer, "O sangue da terra nos uniu. Que a UERJ tente nos separar, se ousarem.");
ds_list_add(dialogos_coalescer_vc, "Beije-me atÃ© que eu esqueÃ§a todos os termos tÃ©cnicos da minha criaÃ§Ã£o.");
ds_list_add(dialogos_coalescer, "Vou te beijar atÃ© que vocÃª sÃ³ conheÃ§a o idioma do meu coraÃ§Ã£o.");
ds_list_add(dialogos_coalescer_vc, "Eu morreria por vocÃª, Fir. NÃ£o por protocolo, mas por vontade.");
ds_list_add(dialogos_coalescer, "Viva por mim. Os mortos nÃ£o podem sentir o vento de Sacae juntas.");
ds_list_add(dialogos_coalescer_vc, "Minha pele modificada nunca sentiu nada tÃ£o intenso quanto seu abraÃ§o.");
ds_list_add(dialogos_coalescer, "Ã‰ o calor da vida, Revolution. Algo que nenhum cientista consegue clonar.");
ds_list_add(dialogos_coalescer_vc, "Ser sua esposa Ã© o Ãºnico experimento que deu certo na minha vida.");
ds_list_add(dialogos_coalescer, "VocÃª nÃ£o Ã© um experimento. VocÃª Ã© o meu milagre das planÃ­cies.");
ds_list_add(dialogos_coalescer_vc, "Sinto que meu DNA estÃ¡ se acalmando perto de vocÃª.");
ds_list_add(dialogos_coalescer, "Ã‰ a paz de quem encontrou o seu lugar no mundo.");
ds_list_add(dialogos_coalescer_vc, "Quero que o mundo saiba que uma transgÃªnica amou uma Lorca e foi amada de volta.");
ds_list_add(dialogos_coalescer, "Deixe que saibam. Nossa uniÃ£o Ã© mais forte que o aÃ§o de Nordion.");
ds_list_add(dialogos_coalescer_vc, "VocÃª Ã© minha famÃ­lia agora. A Ãºnica que eu realmente escolhi.");
ds_list_add(dialogos_coalescer, "E vocÃª Ã© minha tribo. Onde vocÃª estiver, os Lorca estarÃ£o.");
ds_list_add(dialogos_coalescer_vc, "Finalmente, nÃ£o sou mais uma 'unidade'. Sou sua mulher.");
ds_list_add(dialogos_coalescer, "Minha esposa. Minha mirmidÃ£. Meu eterno horizonte.");
ds_list_add(dialogos_coalescer_vc, "Que o petrÃ³leo sagrado proteja nossa casa sob as estrelas.");
ds_list_add(dialogos_coalescer, "Ele Ã© o sangue da terra, e nÃ³s somos os seus batimentos.");
ds_list_add(dialogos_coalescer_vc, "Nunca deixe que me levem de volta para aquele tanque.");
ds_list_add(dialogos_coalescer, "Eles teriam que passar por cima da minha espada e do meu cadÃ¡ver.");
ds_list_add(dialogos_coalescer_vc, "Eu te amo mais do que minha prÃ³pria existÃªncia programada.");
ds_list_add(dialogos_coalescer, "E eu te amo alÃ©m de qualquer linhagem ou nome de tribo.");

//DiÃ¡logos de Desconhecido (O choque de realidades)
ds_list_add(dialogos_desconhecido, "Fir: VocÃª Ã© tÃ£o perfeita... como se cada mÃºsculo seu tivesse sido esculpido pelos deuses de Nordion.");
ds_list_add(dialogos_desconhecido, "Revolution: NÃ£o foram deuses, Fir. Foram homens com jalecos e contratos de exclusividade.");
ds_list_add(dialogos_desconhecido, "Fir: Dizem que em Nordion ninguÃ©m fica doente. VocÃª deve ser a prova dessa bÃªnÃ§Ã£o.");
ds_list_add(dialogos_desconhecido, "Revolution: A saÃºde Ã© fÃ¡cil quando vocÃª Ã© um investimento que nÃ£o pode dar prejuÃ­zo.");
ds_list_add(dialogos_desconhecido, "Fir: Sua pele Ã© tÃ£o macia... as mirmidÃ£s de Sacae sÃ£o cheias de cicatrizes. Nordion deve ser um paraÃ­so.");
ds_list_add(dialogos_desconhecido, "Revolution: O paraÃ­so deles Ã© uma vitrine, Fir. E eu nunca mais quero voltar para trÃ¡s do vidro.");

//DiÃ¡logos AmigÃ¡veis (ProteÃ§Ã£o e Aviso)
ds_list_add(dialogos_amigavel_vc, "Fir, nÃ£o olhe muito para os avioes de carga da Nordion lands. Se eles virem seu talento com a espada, vÃ£o querer 'otimizar' vocÃª.");
ds_list_add(dialogos_amigavel, "Otimizar? Isso soa como uma honra! Seria como ser uma guerreira lendÃ¡ria nos contos.");
ds_list_add(dialogos_amigavel_vc, "NÃ£o Ã© honra. Ã‰ extraÃ§Ã£o. Eles tirariam seu espÃ­rito para colocar em um Plug Tatico.");
ds_list_add(dialogos_amigavel, "VocÃª se preocupa demais, Revolution. VocÃª Ã© o milagre que eles criaram, por que teriam medo?");
ds_list_add(dialogos_amigavel_vc, "Porque eu sou o milagre que aprendeu a dizer 'nÃ£o'.");

//DiÃ¡logos de Coalescer (A questÃ£o do Ãštero e Pertencimento)
ds_list_add(dialogos_coalescer_vc, "Revolution: Eles me negaram o direito de gerar vida, Fir. Eles queriam que eu fosse a Ãºltima da minha linhagem.");
ds_list_add(dialogos_coalescer, "Fir: Deixe que eles fiquem com a biologia. O que floresce entre nÃ³s Ã© mais real que qualquer nascimento.");
ds_list_add(dialogos_coalescer_vc, "Revolution: Sem Ãºtero, sem passado... eu era apenas um rascunho humano atÃ© vocÃª me tocar.");
ds_list_add(dialogos_coalescer, "Fir: VocÃª Ã© mulher por escolha, nÃ£o por funÃ§Ã£o. Em Sacae, isso Ã© a maior das liberdades.");
ds_list_add(dialogos_coalescer_vc, "Revolution: Sinto o calor do seu sangue no meu. Finalmente, nÃ£o sou mais um clone, sou sua.");
ds_list_add(dialogos_coalescer, "Fir: VocÃª Ã© a vida que a Nordion tentou domar, mas que o meu coraÃ§Ã£o libertou.");

//DiÃ¡logos de Conflito (A visÃ£o distorcida de Fir)
ds_list_add(dialogos_xingar_vc, "Pare de falar da Nordion Lands como se fosse um conto de fadas! Aquilo Ã© um abatedouro de almas!");
ds_list_add(dialogos_xingar, "VOCÃŠ Ã‰ INGRATA! Eles te deram essa forÃ§a, essa beleza... por que odeia tanto quem te deu a vida?");
ds_list_add(dialogos_xingar_vc, "PORQUE ELES NÃƒO ME DERAM VIDA! Eles me deram um nÃºmero de sÃ©rie e uma coleira invisÃ­vel!");
ds_list_add(dialogos_xingar, "Talvez vocÃª sÃ³ nÃ£o saiba apreciar o progresso! VocÃª Ã© tÃ£o amarga quanto o suco de morango azedo!");
