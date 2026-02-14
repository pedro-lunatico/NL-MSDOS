/// scr_Rosa_Dialogos()
/// GM8.1 SAFE (sem acentos)

/// ===============================
/// CRIACAO SEGURA DAS LISTAS
/// ===============================
if (!variable_global_exists("c_respostas")) {
    global.c_respostas = ds_list_create();
}

if (!variable_global_exists("r_respostas")) {
    global.r_respostas = ds_list_create();
}

if (!variable_global_exists("c_falas")) {
    global.c_falas = ds_list_create();
}

/// ===============================
/// OPCOES DA CHARLOTTE
/// ===============================
ds_list_add(global.c_respostas, "PASSADO|Rosa... voce nunca falou muito de antes de Nordion Lands.");
ds_list_add(global.c_respostas, "FERGUS|Ele ainda machuca voce?");
ds_list_add(global.c_respostas, "GUERRA|Tudo isso valeu a pena?");
ds_list_add(global.c_respostas, "CHARLOTTE|Voce se arrepende de ter me criado?");
ds_list_add(global.c_respostas, "EVA|O EVA Emblem ainda te assusta?");
ds_list_add(global.c_respostas, "WIIU|Sobre o Wii U... eu posso explicar.");

/// ===============================
/// RESPOSTAS DA ROSA
/// ===============================
// PASSADO
ds_list_add(global.r_respostas, "PASSADO|Ah, Castelia Lands era um tédio! Todo mundo de cara amarrada.");
ds_list_add(global.r_respostas, "PASSADO|Eles odiavam cientistas porque a gente era muito mais brilhante que eles!");
ds_list_add(global.r_respostas, "PASSADO|Fui pra Bioengenharia so pra ver se conseguia criar uma cura para minha mae
porem eu criei um mundo melhor");
ds_list_add(global.r_respostas, "PASSADO|Tentei salvar minha mae, mas o destino e um chato que nao aceita suborno.");
ds_list_add(global.r_respostas, "PASSADO|Mudei pra Fisica porque calculos sao mais previsiveis que tubos de ensaio!
infelizmente eu acabei criando mais clones que calculos mas fazer oque ne!!!");

// FERGUS
ds_list_add(global.r_respostas, "FERGUS|O Fergus? Ele e so um bobao que precisa de uns petelecos as vezes.");
ds_list_add(global.r_respostas, "FERGUS|Ele acha que mete medo, mas eu ja vi ele tentando tirar um cisco do olho.");
ds_list_add(global.r_respostas, "FERGUS|Eu nao sou fraca! Eu sou a Engenheira desse laboratorio, Charlotte!");
ds_list_add(global.r_respostas, "FERGUS|Fiquei porque se eu sair, esse lugar desmorona sem minhas criacoes.");
ds_list_add(global.r_respostas, "FERGUS|Sou mae e jogo Mario Kart 8 melhor que qualquer general por ai! alias duvido voce me ganhar
no mario party 10");

// GUERRA
ds_list_add(global.r_respostas, "GUERRA|O governo explodiu tudo porque invejavam meu senso de criacao!");
ds_list_add(global.r_respostas, "GUERRA|Bombas sismicas sao tao... barulhentas. Estragam o silencio que um bom laboratorio merece.");
ds_list_add(global.r_respostas, "GUERRA|Minha mae morreu sendo uma heroina total. Ela se chamava Terra Mei.");
ds_list_add(global.r_respostas, "GUERRA|Ela disse pra eu mudar o mundo, entao decidi deixar ele mais uniforme!");
ds_list_add(global.r_respostas, "GUERRA|Nao saiu exatamente como planejei.infelizmente minha mae morreu mas como o Fergus disse e uma mal
nescesario");

// CHARLOTTE
ds_list_add(global.r_respostas, "CHARLOTTE|Criar voce foi a melhor ideia que eu ja tive, so perde para o osian ea dawn ea blazing blade
eo projeto doom caramba acho que eu criei muita coisa");
ds_list_add(global.r_respostas, "CHARLOTTE|Ver voce crescendo e tipo jogar The Sims e ver seu Sim ganhar caracteristicas adultas!");
ds_list_add(global.r_respostas, "CHARLOTTE|Geografa? eu sei que voce gosta disso mas fracamente voce fez isso para nao ter desafio ne?");
ds_list_add(global.r_respostas, "CHARLOTTE|Voce e tao humana que as vezes esqueço de trabalhar!!!");
ds_list_add(global.r_respostas, "CHARLOTTE|as vezes eu me esqueco que fui eu mesma que projetei voce!!!!");

// EVA
ds_list_add(global.r_respostas, "EVA|O EVA e tipo um bichinho de estimacao gigante, so que com forca de 1 tera newton!");
ds_list_add(global.r_respostas, "EVA|Eficiencia absoluta e uo! Onde esta o drama? Onde esta a paixao?");
ds_list_add(global.r_respostas, "EVA|Voce sincroniza porque voce e sua mae sao igualzinhas!");
ds_list_add(global.r_respostas, "EVA|Hesitar e normal! Robos perfeitos sao tao... anos 90.");

// WII U
ds_list_add(global.r_respostas, "WIIU|Charlotte! Minha ladra de consoles favorita! isso e engracado todas da sua especie entram
pro mundo do crime em algum momento ksksksks");
ds_list_add(global.r_respostas, "WIIU|Eu sei que voce roubou. Vi as marcas de dedo de oleo no gamepad! considere demitida");
ds_list_add(global.r_respostas, "WIIU|Pode ficar, mas se eu ver um arranhao na tela,eu te demito!");
ds_list_add(global.r_respostas, "WIIU|Apagar meu save de Mario Kart 8 e motivo de exilio imediato, ouviu?");


/// ===============================
/// DIALOGOS BASE (MICRO CONFLITO)
/// ===============================
ds_list_add(global.c_falas, "Charlotte:voce parece cansada hoje");
ds_list_add(global.c_falas, "Rosa: eu nao parei de trabalhar desde ontem");
/// ===============================
/// OPCOES ADICIONAIS DA CHARLOTTE
/// ===============================

// PASSADO (aprofundamento emocional)
ds_list_add(global.c_respostas, "PASSADO|Eu sempre senti que tinha algo que voce escondia.");
ds_list_add(global.c_respostas, "PASSADO|Voce fala de ciencia como se fosse culpa.");
ds_list_add(global.c_respostas, "PASSADO|Se voce pudesse voltar, faria diferente?");
ds_list_add(global.c_respostas, "PASSADO|Voce sente falta de quem voce era antes de tudo isso?");

// FERGUS (conflito mais direto)
ds_list_add(global.c_respostas, "FERGUS|Eu vejo como ele olha pra voce.");
ds_list_add(global.c_respostas, "FERGUS|Voce nao precisava aguentar isso sozinha.");
ds_list_add(global.c_respostas, "FERGUS|Se ele cruzar um limite, eu fico do seu lado.");
ds_list_add(global.c_respostas, "FERGUS|Ele tem medo de te perder, nao tem?");

// GUERRA (peso moral)
ds_list_add(global.c_respostas, "GUERRA|Quando eu luto, penso se isso era inevitavel.");
ds_list_add(global.c_respostas, "GUERRA|As vezes parece que o mundo ja tinha decidido.");
ds_list_add(global.c_respostas, "GUERRA|Voce acha que a gente ainda pode consertar algo?");
ds_list_add(global.c_respostas, "GUERRA|Quantas pessoas precisaram morrer pra chegar aqui?");

// CHARLOTTE (identidade)
ds_list_add(global.c_respostas, "CHARLOTTE|Eu sempre me perguntei se eu sou real pra voce.");
ds_list_add(global.c_respostas, "CHARLOTTE|Eu sinto medo. Isso me faz humana?");
ds_list_add(global.c_respostas, "CHARLOTTE|Se eu tivesse sido diferente, voce teria sido mais feliz?");
ds_list_add(global.c_respostas, "CHARLOTTE|Eu nao quero ser perfeita. So quero ser suficiente.");

// EVA (filosofico / existencial)
ds_list_add(global.c_respostas, "EVA|As vezes eu sinto que o EVA Emblem pensa comigo.");
ds_list_add(global.c_respostas, "EVA|Se eficiencia mata a humanidade, por que o mundo insiste nela?");
ds_list_add(global.c_respostas, "EVA|Voce criou o EVA Emblem ou ele criou voce?");
ds_list_add(global.c_respostas, "EVA|Se eu parar de hesitar… eu ainda sou eu?");

// WII U (alivio emocional / humano)
ds_list_add(global.c_respostas, "WIIU|Era o unico momento em que a guerra sumia.");
ds_list_add(global.c_respostas, "WIIU|Fire Emblem Radiant Dawn nao conta como simulador de combate, ne?");
/// ===============================
/// EXPANSAO MASSIVA - CHARLOTTE
/// ===============================

// PASSADO (memoria e culpa)
ds_list_add(global.c_respostas, "PASSADO|Quando voce fala de Castelia Land, sua voz muda.");
ds_list_add(global.c_respostas, "PASSADO|Voce carrega aquele lugar nas costas ate hoje.");
ds_list_add(global.c_respostas, "PASSADO|Eles chamavam voces de monstros, ne?");
ds_list_add(global.c_respostas, "PASSADO|Eu teria tido medo de viver la.");
ds_list_add(global.c_respostas, "PASSADO|Talvez eu tivesse virado soldada mais cedo.");
ds_list_add(global.c_respostas, "PASSADO|Ou talvez eu tivesse fugido.");

// MAE DA ROSA
ds_list_add(global.c_respostas, "PASSADO|Sua mae parecia gentil nas fotos.");
ds_list_add(global.c_respostas, "PASSADO|Ela teria gostado de Nordion Lands?");
ds_list_add(global.c_respostas, "PASSADO|Voce fala dela como se ainda estivesse aqui.");

// FERGUS (inseguranca e protecao)
ds_list_add(global.c_respostas, "FERGUS|Eu fico alerta quando ele entra na sala.");
ds_list_add(global.c_respostas, "FERGUS|Nao e ciume. E instinto.");
ds_list_add(global.c_respostas, "FERGUS|Se ele te machucar, eu nao vou hesitar.");
ds_list_add(global.c_respostas, "FERGUS|Voce confia nele mais do que em mim?");
ds_list_add(global.c_respostas, "FERGUS|Eu tento nao odiar ele Mas as vezes e dificil.");

// GUERRA (desgaste emocional)
ds_list_add(global.c_respostas, "GUERRA|Eu sonho com o som das bombas.");
ds_list_add(global.c_respostas, "GUERRA|Mesmo quando esta tudo silencioso.");
ds_list_add(global.c_respostas, "GUERRA|Eu luto porque e divertido.Mas eu nao sei se isso me torna boa.");

// CHARLOTTE (identidade profunda)
ds_list_add(global.c_respostas, "CHARLOTTE|Eu sei que fui criada, mas minhas dores sao reais.");
ds_list_add(global.c_respostas, "CHARLOTTE|Eu aprendi observando voce.");
ds_list_add(global.c_respostas, "CHARLOTTE|Se eu sou forte, e porque vi voce errou algum momento...");
ds_list_add(global.c_respostas, "CHARLOTTE|Eu ainda lembro da primeira vez que sai sozinha.Eu tremia, mas nao voltei atras.");

// SONHOS ANTIGOS
ds_list_add(global.c_respostas, "CHARLOTTE|Eu realmente queria ser geografa.");
ds_list_add(global.c_respostas, "CHARLOTTE|Mapear montanhas parecia menos cruel que assumir minha especie...");
ds_list_add(global.c_respostas, "CHARLOTTE|Explorar o mundo parecia mais simples.");

// EVA (ligacao emocional)
ds_list_add(global.c_respostas, "EVA|Quando eu sincronizo, tudo fica silencioso.Nao existe passado nem futuro.So decisao.");
ds_list_add(global.c_respostas, "EVA|Eu sei porque voce confia em mim.");
ds_list_add(global.c_respostas, "EVA|Eu nao sou perfeita.");

// MICRO CONFLITOS (PACiencia da Rosa)
ds_list_add(global.c_respostas, "CHARLOTTE|Voce esta ocupada demais pra falar comigo?");
ds_list_add(global.c_respostas, "CHARLOTTE|Eu posso voltar depois se estiver atrapalhando.");
ds_list_add(global.c_respostas, "CHARLOTTE|Desculpa. Eu so precisava falar.");
ds_list_add(global.c_respostas, "CHARLOTTE|Eu esqueço que voce nao para nunca.");
ds_list_add(global.c_respostas, "CHARLOTTE|Eu tento nao tomar seu tempo.Mas as vezes eu preciso.");

// CONFIANCA
ds_list_add(global.c_respostas, "CHARLOTTE|Eu confio em voce mais do que em qualquer outra pessoa.");
ds_list_add(global.c_respostas, "CHARLOTTE|Voce ainda e meu ponto fixo.");

// PASSADO (foco em Castelia e Clones)
ds_list_add(global.r_respostas, "PASSADO|Sabe o que eu sinto falta das aulas do bartre? Do lanche da cantina. Porque o resto era so gente chata me chamando de doida!");
ds_list_add(global.r_respostas, "PASSADO|Clones sao como abas do navegador, Charlotte. Voce abre uma, depois outra, e quando vê, a RAM do acabou
e voce tenque fazer uma limpa!");
ds_list_add(global.r_respostas, "PASSADO|Eu nao escondo nada, so guardo os arquivos em pastas com nomes que ninguem entende. E estrategia! por exemplo eu
coloquei a pasta com seus dados como Girl of LCL Plains para todos e so uma pasta fazendo referencia a sua mae mas eu sei a verdade");

// FERGUS (mais focado no deboche)
ds_list_add(global.r_respostas, "FERGUS|O Fergus olha pra mim daquele jeito porque ele sabe que eu sou a melhor esposa do mundo.");
ds_list_add(global.r_respostas, "FERGUS|Medo de me perder? Ele devia ter medo e de eu mudar a senha do Wi-Fi da Fergus Industries!");
ds_list_add(global.r_respostas, "FERGUS|Se ele cruzar a linha, eu transformo a armadura dele em um fogao de inducao. Ciencia, baby!");

// GUERRA (minimalismo e conformismo comico)
ds_list_add(global.r_respostas, "GUERRA|A Terra Mei era uma Bishop muito boa. Se ela estivesse aqui, ja tinha resolvido essa guerra com um combo de 99 hits. ou morrendo tentado");
ds_list_add(global.r_respostas, "GUERRA|Mal necessario e o que o Fergus diz quando esquece de lavar a louca.");
ds_list_add(global.r_respostas, "GUERRA|O mundo uniforme e mais facil de lidar, Charlotte.eu consigo me organizar melhor!");

// CHARLOTTE (identidade e The Sims)
ds_list_add(global.r_respostas, "CHARLOTTE|Claro que voce e real! Se voce fosse um bug, eu ja teria corrigido no primeiro patch! que nei uma tal
de revolution kkkkkkk");
ds_list_add(global.r_respostas, "CHARLOTTE|Nao use a desculpa de ser geografa pra fugir do grind! A vida e um RPG de acao, nao um simulador de caminhada!");
ds_list_add(global.r_respostas, "CHARLOTTE|Se eu seria mais feliz se voce fosse diferente? Talvez se voce tivesse um modo turbo de fabrica, mas eu te amo assim.");

// EVA (conversa de mae para filha/arma)
ds_list_add(global.r_respostas, "EVA|Sincronizar com o EVA e tipo jogar em LAN party com a sua alma. E intenso, eu sei!");
ds_list_add(global.r_respostas, "EVA|O mundo insiste em eficiencia porque o mundo e um player noob que so quer saber de meta game.");
ds_list_add(global.r_respostas, "EVA|Voce ainda e voce, Charlotte. So que com um upgrade de 50 metros de altura e uns upgrades extras extras.");

// WII U / GAMES
ds_list_add(global.r_respostas, "WIIU|Mario Kart nao e treino de combate, e treino de amizade... ou de como desfazer amizades com o casco azul!");
ds_list_add(global.r_respostas, "WIIU|eu te deixo jogar o Mario Party 10. Mas se voce roubar minha estrela, o exilio e real!");

// FERGUS (esposa caotica / dinamica de poder)
ds_list_add(global.r_respostas, "FERGUS|O Fergus se acha um General, mas quem controla a conta bancaria e o estoque de cafe da Fergus Industries sou eu!");
ds_list_add(global.r_respostas, "FERGUS|Ele nao me machuca, ele so e bruto na cama serio ksksksks voce tenque ver eu sai cheia de dores mas valeu a pena");
ds_list_add(global.r_respostas, "FERGUS|ele e meio groso e autoritario mas aquele tanquinho compensa tudo");

// WII U / RELAXAMENTO
ds_list_add(global.r_respostas, "WIIU|Sabe por que eu nao te demito pelo Wii U? Porque voce e a unica nesse fim de mundo que sabe a diferença entre um parry e um block!");
ds_list_add(global.r_respostas, "WIIU|Vou instalar o Doom no painel do EVA Emblem. Imagina o tempo que voce vai economizar entre uma batalha e outra!");
ds_list_add(global.r_respostas, "WIIU|Se voce ganhar de mim no Mario Party 10, eu prometo que aumento seu salario. Mas nao vai acontecer!");
/// ===============================
/// EXPANSAO: DINAMICA ROSA & FERGUS (ENTRE TAPAS E BEIJOS)
/// ===============================

// FERGUS (Relacao Complexa / Medo Oculto)
ds_list_add(global.r_respostas, "FERGUS|O Fergus grita, faz cena e posa de machao, mas basta eu olhar pra ele com um sorriso mais 'sadico' que ele gela. Acho que ele ainda ve a Rhodon quando eu fico brava!");
ds_list_add(global.r_respostas, "FERGUS|Ele e bruto, autoritario e um cavalo... mas e o MEU cavalo. E no fundo, ele sabe que se eu decidir virar uma ditatriz de novo, ele e o primeiro a cair.");
ds_list_add(global.r_respostas, "FERGUS|Charlotte, amor e como ciencia: as vezes voce tenque misturar elementos instaveis pra ver a explosao. O Fergus e o meu elemento mais explosivo.");
ds_list_add(global.r_respostas, "FERGUS|Ele tem medo de mim? Claro que tem! Ele viu o que a Rhodon fez. Ele sabe que por tras dessa carinha fofa tem um cerebro que pode deletar a existencia dele.");
ds_list_add(global.r_respostas, "FERGUS|As vezes a gente briga, ele quebra umas coisas, eu ameaço desativar a Fergus Industries... e depois a gente faz as pazes. E um ciclo viciante!");

// PASSADO (Rhodon e a sombra do medo)
ds_list_add(global.r_respostas, "PASSADO|Voce derrotou a Rhodon, Charlotte... mas a genialidade dela era minha. O Fergus sabe disso. Ele me abraça forte pra ter certeza que eu ainda sou a Rosa 'boazinha'.");
ds_list_add(global.r_respostas, "PASSADO|Rhodon era o que acontece quando eu paro de jogar Mario Kart e começo a jogar com a vida das pessoas. O Fergus tem pesadelos com isso ate hoje.");

// CHARLOTTE (Observacoes sobre o casal)
ds_list_add(global.r_respostas, "CHARLOTTE|Nao se preocupe com a grosseria dele, Charlotte. O Fergus ladra mas so morde se eu deixar. E eu gosto quando ele morde, ksksksks!");
ds_list_add(global.r_respostas, "CHARLOTTE|Voce acha nossa relacao estranha? E porque voce foi programada pra ser perfeita. A gente e imperfeito, torto e cheio de hematomas. Isso e ser humano!");

// GUERRA (A visao de controle)
ds_list_add(global.r_respostas, "GUERRA|A guerra da Rhodon foi um erro de calculo. Eu nao cometeria o mesmo erro... ou cometeria? O Fergus vive com essa duvida. E o que o mantem fiel.");
ds_list_add(global.r_respostas, "GUERRA|O Fergus quer ordem pelo braço, eu quero ordem pelo codigo. No final, a gente se encontra no meio do caminho, entre um grito e um beijo.");

/// ===============================
/// OPCOES DA CHARLOTTE (REACAO A DINAMICA)
/// ===============================
ds_list_add(global.c_respostas, "FERGUS|Rosa... eu vi como ele falou com voce hoje. Como voce aguenta?");
ds_list_add(global.c_respostas, "FERGUS|Voce usa o medo que ele tem da Rhodon pra controlar ele, nao usa?");
ds_list_add(global.c_respostas, "FERGUS|As vezes eu sinto que voces vao se destruir antes da guerra acabar.");
ds_list_add(global.c_respostas, "PASSADO|Se a Rhodon era voce de outro mundo... o que impede voce de se tornar ela aqui?");
/// ===============================
/// EXPANSAO MASSIVA: CHARLOTTE (64 FALAS HUMANAS)
/// ===============================

// CATEGORIA 1: HERANÇA LORCA E O LEGADO DA LYN
ds_list_add(global.c_respostas, "PASSADO|Minha mae Lyn me ensinou que o valor de alguem nao vem de como ele nasceu, mas de como ele trata o vento.");
ds_list_add(global.c_respostas, "PASSADO|Eu sinto falta das planicies. La eu era Charlotte de Lorca, nao um 'projeto' seu, Rosa.");
ds_list_add(global.c_respostas, "PASSADO|Rosa, voce me criou para ser escrava, mas a Lyn me criou para ser livre. Quem voce acha que ganhou?");
ds_list_add(global.c_respostas, "PASSADO|Eu olho pro horizonte e sinto que meu sangue Lorca chama por algo mais do que paredes de metal.");
ds_list_add(global.c_respostas, "PASSADO|Eles me chamam de objeto nas ruas de Nordion... mas meu coracao bate mais forte que o deles.");
ds_list_add(global.c_respostas, "PASSADO|Sera que a minha mae Lyn sabia que eu acabaria presa nesse laboratorio caotico?");
ds_list_add(global.c_respostas, "PASSADO|Eu nao sou um hardware, Rosa. Se voce me cortar, eu sangro. Se voce me insultar, eu choro.");
ds_list_add(global.c_respostas, "PASSADO|Ser uma Lorca em Nordion e como ser uma flor num deserto de concreto.");
ds_list_add(global.c_respostas, "PASSADO|Eu honro o nome Djute, mesmo que o mundo queira me dar um numero de serie.");

// CATEGORIA 2: O RELACIONAMENTO ROSA & FERGUS (VISAO DA FILHA HUMANA)
ds_list_add(global.c_respostas, "FERGUS|Por que voces chamam essa violencia de amor? Minha mae Lyn nunca me ensinou isso.");
ds_list_add(global.c_respostas, "FERGUS|Rosa, voce se deixa diminuir por ele so pra depois punir ele com o medo? Isso e doentio.");
ds_list_add(global.c_respostas, "FERGUS|Eu vi o jeito que ele te tratou. Eu quis intervir, mas voce parecia... gostar?");
ds_list_add(global.c_respostas, "FERGUS|O Fergus me olha como se eu fosse um móvel caro da empresa dele. Eu odeio isso.");
ds_list_add(global.c_respostas, "FERGUS|Voces dois sao tao crueis um com o outro... Nordion realmente corrompe as pessoas.");
ds_list_add(global.c_respostas, "FERGUS|Rosa, voce e pequena e parece frágil, mas o jeito que voce manipula o medo do Fergus me assusta.");
ds_list_add(global.c_respostas, "FERGUS|Entre tapas e beijos... voces nao percebem que estao se destruindo?");
ds_list_add(global.c_respostas, "FERGUS|O Fergus tem medo da Rhodon, mas ele devia ter medo de quem voce e AGORA.");
ds_list_add(global.c_respostas, "FERGUS|Eu preferia estar nas planicies passando fome do que assistindo voces dois nessa briga eterna.");
ds_list_add(global.c_respostas, "FERGUS|Voce diz que ele e autoritario, mas voce e quem tranca as correntes mentais dele.");

// CATEGORIA 3: PRECONCEITO E TRABALHO ESCRAVO
ds_list_add(global.c_respostas, "CHARLOTTE|Eles falam de mim como se eu nao estivesse na sala. Como se eu fosse uma ferramenta.");
ds_list_add(global.c_respostas, "CHARLOTTE|Trabalho escravo... e pra isso que voce me deu a vida, Rosa? Pra ser util?");
ds_list_add(global.c_respostas, "CHARLOTTE|Eu sou mais humana que qualquer um desses generais sadicos de Nordion Lands.");
ds_list_add(global.c_respostas, "CHARLOTTE|Me chamam de 'criacao', mas eu sinto dor, sinto fome e sinto um vazio que ciencia nenhuma preenche.");
ds_list_add(global.c_respostas, "CHARLOTTE|Por que eu tenho que lutar a guerra de voces? So porque eu 'fui feita' pra isso?");
ds_list_add(global.c_respostas, "CHARLOTTE|Eu olho para as outras pessoas e vejo maldade pura. Eu sou a 'artificial', mas eles sao os monstros.");
ds_list_add(global.c_respostas, "CHARLOTTE|Rosa, voce me deu um nome ou so um codigo que eu ainda nao descobri?");

// CATEGORIA 4: GEOGRAFIA E O SONHO DE ESCAPE
ds_list_add(global.c_respostas, "CHARLOTTE|Eu estudo geografia porque quero saber pra onde correr quando tudo isso explodir.");
ds_list_add(global.c_respostas, "CHARLOTTE|As montanhas nao julgam a minha origem. Elas so estao la, sendo livres.");
ds_list_add(global.c_respostas, "CHARLOTTE|Eu mapeio o mundo pra nao me perder na loucura desse laboratorio.");
ds_list_add(global.c_respostas, "CHARLOTTE|Sera que alem das fronteiras de Nordion existe um lugar onde ninguem e dono de ninguem?");
ds_list_add(global.c_respostas, "CHARLOTTE|Meu sonho era ser geografa, mas meu destino parece ser apenas uma peça no jogo do Fergus.");

// CATEGORIA 5: O MEDO DE VIRAR RHODON (O LADO SOMBRIO DA GENETICA)
ds_list_add(global.c_respostas, "PASSADO|Se eu tenho o seu sangue, Rosa... sera que eu tambem tenho o sadismo da Rhodon escondido?");
ds_list_add(global.c_respostas, "PASSADO|Eu nao quero ser uma ditadora. Eu so quero ser a filha da Lyn.");
ds_list_add(global.c_respostas, "PASSADO|As vezes eu sinto uma raiva tao grande do Fergus que eu me assusto. Sera a Rhodon acordando?");
ds_list_add(global.c_respostas, "PASSADO|Rosa, pare de me comparar com ela! Eu nao sou sua versao alternativa maligna!");

// CATEGORIA 6: COTIDIANO, GAMES E HUMANIDADE (MAIS 24 FALAS)
ds_list_add(global.c_respostas, "WIIU|O Wii U e a unica coisa que me faz sentir como uma garota normal, e nao uma arma.");
ds_list_add(global.c_respostas, "WIIU|Rosa, voce joga Mario Kart pra ganhar. Eu jogo pra esquecer que sou sua prisioneira.");
ds_list_add(global.c_respostas, "WIIU|Voce diz que eu sou NPC, mas NPCs sao os unicos que nao tentam se matar nesse mundo.");
ds_list_add(global.c_respostas, "CHARLOTTE|Minha mae Lyn dizia que a verdadeira forca vem da gentileza. Nordion Lands odeia a minha forca.");
ds_list_add(global.c_respostas, "CHARLOTTE|Rosa, por que voce nao usa sua inteligencia pra salvar pessoas em vez de criar armas?");
ds_list_add(global.c_respostas, "CHARLOTTE|Eu prefiro ser uma 'escrava' bondosa do que uma 'mestre' crue como voces.");
ds_list_add(global.c_respostas, "CHARLOTTE|As vezes eu queria que voce fosse so minha mae, e nao minha 'criadora'.");
ds_list_add(global.c_respostas, "CHARLOTTE|Voce coloca meus dados em pastas escondidas... voce tem vergonha de mim?");
ds_list_add(global.c_respostas, "CHARLOTTE|O Fergus e bruto porque ele nao sabe ser amado. E voce e sadica porque esqueceu como amar.");
ds_list_add(global.c_respostas, "CHARLOTTE|Eu sou uma Lorca. Nos nao quebramos, nos dobramos como o junco e voltamos a subir.");
ds_list_add(global.c_respostas, "CHARLOTTE|Voce me deu um corpo humano, mas eu tive que lutar pra ter uma alma humana.");
ds_list_add(global.c_respostas, "CHARLOTTE|Rosa, voce esta cansada. Deixe de ser a Rhodon por um minuto e seja so a Rosa.");
ds_list_add(global.c_respostas, "CHARLOTTE|Sera que eu sou o único 'experimento' que deu errado porque desenvolvi bondade?");
ds_list_add(global.c_respostas, "CHARLOTTE|O mundo e tao bonito la fora... e voces estao aqui dentro brigando por poder.");
ds_list_add(global.c_respostas, "CHARLOTTE|Se eu ganhar no Mario Party, voce promete me tratar como um ser humano por um dia?");
ds_list_add(global.c_respostas, "CHARLOTTE|Eu sinto o cheiro da chuva chegando. Isso e algo que um robo nao sentiria, ne?");
ds_list_add(global.c_respostas, "CHARLOTTE|Eu nao sou perfeita, Rosa. Eu erro, eu tropeço... e isso e o que me faz real.");
ds_list_add(global.c_respostas, "CHARLOTTE|O Fergus Industries devia investir em humanidade, nao so em metal.");
ds_list_add(global.c_respostas, "CHARLOTTE|Rosa, se voce sumir... eu ficaria triste. Mesmo que voce seja louca.");
ds_list_add(global.c_respostas, "CHARLOTTE|Eu sou Charlotte de Lorca. Guarde bem esse nome.");
ds_list_add(global.c_respostas, "CHARLOTTE|Nordion Lands e um lugar frio. Eu sou o unico calor que restou pra voce?");
ds_list_add(global.c_respostas, "CHARLOTTE|A ciencia nao explica por que meu peito doi quando vejo voces brigando.");
ds_list_add(global.c_respostas, "CHARLOTTE|Eu vou mapear o caminho para a nossa liberdade, Rosa. Com ou sem voce.");
ds_list_add(global.c_respostas, "CHARLOTTE|Eu sou humana. E isso e a coisa mais perigosa que eu poderia ser aqui.");

/// ===============================
/// DESBLOQUEIO POR ITEM (FLAGS SAFE)
/// ===============================

// FERRO
if (variable_global_exists("tem_item_fe")) {
    if (global.tem_item_fe) {
        if (!variable_global_exists("fe_dialogo_lido")) global.fe_dialogo_lido = false;
        if (!global.fe_dialogo_lido) {
            ds_list_add(global.c_respostas, "ITEM_FE|Charlotte; Eu ainda carrego ferro desde a sua bancada.");
            ds_list_add(global.r_respostas, "ITEM_FE|Rosa; Ferro aguenta calor. E voce tambem.");
            global.fe_dialogo_lido = true;
        }
    }
}

// HIDROGENIO
if (variable_global_exists("tem_item_h")) {
    if (global.tem_item_h) {
        if (!variable_global_exists("h_dialogo_lido")) global.h_dialogo_lido = false;
        if (!global.h_dialogo_lido) {
            ds_list_add(global.c_respostas, "ITEM_H|Charlotte; Hidrogenio sempre me deixou nervosa.");
            ds_list_add(global.r_respostas, "ITEM_H|Rosa; Medo e energia mal contida.");
            global.h_dialogo_lido = true;
        }
    }
}

// OXIGENIO
if (variable_global_exists("tem_item_o")) {
    if (global.tem_item_o) {
        if (!variable_global_exists("o_dialogo_lido")) global.o_dialogo_lido = false;
        if (!global.o_dialogo_lido) {
            ds_list_add(global.c_respostas, "ITEM_O|Charlotte; Oxigenio demais sempre explode.");
            ds_list_add(global.r_respostas, "ITEM_O|Rosa; Tudo em excesso vira incendio.");
            global.o_dialogo_lido = true;
        }
    }
}

// MAKERNIMITE
if (variable_global_exists("tem_makernimite")) {
    if (global.tem_makernimite) {
        if (!variable_global_exists("maker_dialogo_lido")) global.maker_dialogo_lido = false;
        if (!global.maker_dialogo_lido) {
            ds_list_add(global.c_respostas, "ITEM_MAKER|Charlotte; Isso aqui foi ideia sua.");
            ds_list_add(global.r_respostas, "ITEM_MAKER|Rosa; Ideias nao pedem permissao.");
            global.maker_dialogo_lido = true;
        }
    }
}
