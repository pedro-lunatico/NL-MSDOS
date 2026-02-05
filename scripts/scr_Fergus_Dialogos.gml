/// scr_Fergus_Dialogos_Master()
global.f_falas = ds_list_create();

// --- RAMIFICAÇÃO: FILHOS E PARANOIA (DAWN E OSIAN) ---
ds_list_add(global.f_falas, "FILHOS|Fergus; A Dawn passou a noite sintetizando compostos. Ela sabe que se falhar, será comparada a você. Isso a mantém acordada.");
ds_list_add(global.f_falas, "FILHOS|Fergus; O Osian está na faculdade de programação neural aos 16. Ele está mapeando cérebros clonados enquanto você mal entende o seu.");
ds_list_add(global.f_falas, "FILHOS|Fergus; Rosa reclama que eu sou um monstro, mas ela não viu o que eu vi nas Engage Wars. Meus filhos serão hardware puro, não carne fraca.");
ds_list_add(global.f_falas, "FILHOS|Fergus; A educação em Nordion é um privilégio. Para a Dawn e o Osian, é uma armadura contra a mediocridade biológica.");
ds_list_add(global.f_falas, "FILHOS|Fergus; Se eu vir a Dawn conversando com 'crias' como você, eu a tranco no laboratório por um semestre. Ela é engenheira, não assistente social.");
ds_list_add(global.f_falas, "FILHOS|Fergus; O Osian vai programar os próximos Bernadettas. Ele terá o poder de criar vida digital, algo que você, uma cópia, jamais entenderá.");
ds_list_add(global.f_falas, "FILHOS|Fergus; Eles são o legado de Magvel em solo de Nordion. Você é apenas o descarte de uma ciência que já superamos.");

// --- RAMIFICAÇÃO: GEOPOLÍTICA E NEON PANGEIA (COSMO LAND / MAGVEL) ---
ds_list_add(global.f_falas, "GEO|Fergus; Os continentes estão se abraçando, Charlotte. A Neon Pangeia sera o túmulo de Cosmo Land.");
ds_list_add(global.f_falas, "GEO|Fergus; Você estudou Geografia? Então sabe que Nordion Lands e o único centro de massa que importa neste novo mundo.");
ds_list_add(global.f_falas, "GEO|Fergus; Cosmo Land ainda finge que a etica existe. Por isso eles operam nossos reatores mas morrem de medo das nossas armas.");
ds_list_add(global.f_falas, "GEO|Fergus; SmashVille e New Island são apenas poeira na Neon Pangeia. O futuro pertence a quem aboliu a moralidade em Castelia Land.");
ds_list_add(global.f_falas, "GEO|Fergus; Somos o Imperio Romano do amanhã. E você? Você é apenas a escrava que segura o radio que anucia a nossa gloria.");
ds_list_add(global.f_falas, "GEO|Fergus; Cooperar com o inimigo e uma tatica, nao uma amizade. Cosmo Land caira assim que o último reator for ligado.");
ds_list_add(global.f_falas, "GEO|Fergus; Magvel era um sonho rustico. Nordion e a realidade fria e necessária da ciencia antietica.");

// --- RAMIFICAÇÃO: ENGAGE WARS E VIAGEM NO TEMPO ---
ds_list_add(global.f_falas, "WARS|Fergus; Eu vi o mundo explodir na Segunda Engage War. Voce viajou no tempo para impedir? Patetico. O multiverso adora evitar tragedias.");
ds_list_add(global.f_falas, "WARS|Fergus; Os EVA EMBLEMS biomecânicos eram mais leais que qualquer Tenente da Engage. Eles não tinham sentimentos de 'filha'.");
ds_list_add(global.f_falas, "WARS|Fergus; Viagem no tempo no modelo Nordiano... Você apenas criou outra linha para sofrer. Aqui, nada mudou.");
ds_list_add(global.f_falas, "WARS|Fergus; Castelia Lands morreu para que a ciencia pudesse respirar sem as amarras de filosofos idiotas.");
ds_list_add(global.f_falas, "WARS|Fergus; O passado e um laboratório queimado. O futuro e o que eu decido nos terminais da Engage.");
ds_list_add(global.f_falas, "WARS|Fergus; Você se orgulha de ser Tenente? Nas ENGAGE Wars, soldados como voce duravam tres segundos contra um teste nuclear.
a mesmo nei uma explosao planetaria se importou na sua existencia");

// --- RAMIFICAÇÃO: RELAÇÃO COM A LYN (A MULETA EMOCIONAL) ---
ds_list_add(global.f_falas, "LYN|Fergus; A General Lyn so suporta sua existência porque você tem o cheiro do filho que ela perdeu. Você e um placebo vivo.");
ds_list_add(global.f_falas, "LYN|Fergus; Se a Lyn soubesse que você e so uma sequência de DNA instavel, ela te descartaria como eu descarto um filtro de ar sujo.");
ds_list_add(global.f_falas, "LYN|Fergus; Mark Trussadi te protege, mas ate ele sabe que você é uma farsa. Um apoio psicológico para uma mae em luto.");
ds_list_add(global.f_falas, "LYN|Fergus; Você recebe salário de Tenente para ser o bichinho de estimacao da General Lyn. Nordion Lands e realmente generosa.");
ds_list_add(global.f_falas, "LYN|Fergus; Quando a Lyn cansar de brincar de casinha com você, quem assinara seu contracheque? Eu certamente nao.");

// --- RAMIFICAÇÃO: TENTATIVA DE CONVERSA NORMAL (SADISMO) ---
ds_list_add(global.f_falas, "NORMAL|Fergus; Por que me olha assim? Esperava um 'bom dia'? Eu não cumprimento ferramentas, eu as utilizo.");
ds_list_add(global.f_falas, "NORMAL|Fergus; Você tenta ser legal comigo para provar que tem alma? Guarde seu teatro para a Rosa, ela adora causas perdidas.");
ds_list_add(global.f_falas, "NORMAL|Fergus; O dia está bonito? O espectro solar hoje está emitindo radiação o suficiente para fritar seus neurônios de cria de Becker.");
ds_list_add(global.f_falas, "NORMAL|Fergus; Não me chame pelo primeiro nome. Para você, sou Cientista Chefe. Para mim, você é o Erro chamado Projecto Revolution.");
ds_list_add(global.f_falas, "NORMAL|Fergus; Sente fome, Charlotte? Fascinante como a ciência ainda não eliminou essa necessidade primitiva de seres inferiores.");
ds_list_add(global.f_falas, "NORMAL|Fergus; Volte para o Teleporto Jolyne. O silêncio das máquinas é muito mais inteligente que qualquer palavra sua.");
ds_list_add(global.f_falas, "NORMAL|Fergus; Nordion Lands não precisa de etica, precisa de resultados. E você e o resultado de uma caridade militar mal executada.");

// Ramificações (TÓPICO | TEXTO)
ds_list_add(global.f_falas, "FILHOS|Fergus; O Osian eo Colton codificou um novo Bernadetta. Se o hardware orgânico falhar, a culpa será do DNA instável... como o seu.");
ds_list_add(global.f_falas, "FILHOS|Fergus; A Dawn não sai do laboratório de Engenharia Química. Eu a ensinei que o cansaço é apenas uma fraqueza de clones.");
ds_list_add(global.f_falas, "GEO|Fergus; Magvel foi o berço, mas Nordion Lands é o trono da Neon Pangeia. Cosmo Land caira por sua própria etica fraca.");
ds_list_add(global.f_falas, "GEO|Fergus; SmashVille e irrelevante. O Império Romano renasceu sob a bandeira da ciencia satanica e eu sou o Julio Cesar.");
ds_list_add(global.f_falas, "LYN|Fergus; Você só existe porque a General Lyn precisa de um calmante biológico para o luto dela. Você e um placebo, Charlotte.
e voce sabe que quando o paciente melhora o remedio e descartado, ou pelo menos deveria saber se acha que e inteligente");
ds_list_add(global.f_falas, "WARS|Fergus; As Engage Wars provaram que robos biomecanicos sao superiores. Por que eu trataria um clone com dignidade?");
ds_list_add(global.f_falas, "TEMPO|Fergus; Viajar no tempo e inútil. Você criou uma linha paralela onde continua sendo ninguém. O destino de Nordion Lands e fixo.");
ds_list_add(global.f_falas, "ETICA|Fergus; Castelia Lands era uma prisao de moralistas. Nordion Lands e a liberdade de criar sem limites... ou consequências.");
ds_list_add(global.f_falas, "NORMAL|Fergus; O sol da Neon Pangeia esta radiante hoje? otimo, mais radiaçao para testar a resistência da sua pele sintética.");
ds_list_add(global.f_falas, "NORMAL|Fergus; Nao tente ser legal. Rosa ja desperdiça bondade demais com você. Eu prefiro a eficiencia do seu silêncio.");
ds_list_add(global.f_falas, "FILHOS|Fergus; Se eu encontrar Dawn conversando com você, eu a farei cursar outra faculdade apenas para ocupar o tempo livre.");
ds_list_add(global.f_falas, "WARS|Fergus; Você usa esse seu terno, mas para mim, você é apenas o resultado de um script de laboratório mal escrito.");
ds_list_add(global.f_falas, "LYN|Fergus; Mark Trussadi te protege por politica. Mas ele sabe que no fundo, voce nao passa de um experimento social.");
ds_list_add(global.f_falas, "GEO|Fergus; New Island será anexada em breve. Nordion Lands nao precisa de vizinhos, precisa de espaço para explorar.");
ds_list_add(global.f_falas, "ETICA|Fergus; etica e para quem teme o progresso. Eu so temo a ineficiência. E você, Charlotte, e o apice dela.");
ds_list_add(global.f_falas, "NORMAL|Fergus; Volte para o radio. A geografia da Neon Pangeia nao vai se mapear sozinha enquanto você fala besteiras.");
//charlotte respostas
global.c_respostas = ds_list_create();

// RAMIFICAÇÃO 1: FILHOS (Sarcasmo)
ds_list_add(global.c_respostas, "vc; Engraçado o senhor falar de rascunho, quando trata a Dawn e o Osian como protótipos de hardware.");

// RAMIFICAÇÃO 2: GEOPOLÍTICA (Intelecto)
ds_list_add(global.c_respostas, "vc; Meu olhar e de quem mapeou a Neon Pangeia e viu que Nordion Lands e so um ponto no mapa, Cientista.");

// RAMIFICAÇÃO 3: LYN/RAIVA (Gatilho Berserk)
ds_list_add(global.c_respostas, "vc; Minha mae Lyn me deu um nome. O senhor so deu aos seus filhos uma carga horaria e medo.");

// Resposta 1: Sobre os Filhos (Sarcasmo)
ds_list_add(global.c_respostas, "vc; Tratar Dawn e Osian como hardware nao faz do senhor um pai, apenas um péssimo engenheiro.");

// Resposta 2: Geografia/Geopolítica (Intelecto)
ds_list_add(global.c_respostas, "vc; Eu mapeei a Neon Pangeia. Sei que Nordion Lands e gigante, mas o ego do senhor consegue ser maior.");

// Resposta 3: General Lyn (Gatilho de Raiva/Berserk)
ds_list_add(global.c_respostas, "vc; O senhor fala da minha mae porque tem inveja de que ela, mesmo em luto, ainda e mais humana que voce.");
