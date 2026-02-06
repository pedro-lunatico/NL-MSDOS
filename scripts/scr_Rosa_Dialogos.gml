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
ds_list_add(global.r_respostas, "PASSADO|Antes de Nordion Lands existia Castelia Lands. Um pais que odiava seus cientistas.");
ds_list_add(global.r_respostas, "PASSADO|Eles nos culpavam pelas bombas sismicas. Como se a ciencia tivesse apertado o botao sozinha.");
ds_list_add(global.r_respostas, "PASSADO|Eu comecei na bioengenharia. Nao por ambicao. Por amor.");
ds_list_add(global.r_respostas, "PASSADO|Minha mae estava morrendo. Cancer em estagio terminal.");
ds_list_add(global.r_respostas, "PASSADO|Eu queria salva la. Falhei.");
ds_list_add(global.r_respostas, "PASSADO|Depois virei fisica. Porque era o que eu realmente amava.");

// FERGUS
ds_list_add(global.r_respostas, "FERGUS|Fergus nao e um monstro o tempo todo.");
ds_list_add(global.r_respostas, "FERGUS|Mas quando ele e... eu sei.");
ds_list_add(global.r_respostas, "FERGUS|Eu nao sou fraca, Charlotte.");
ds_list_add(global.r_respostas, "FERGUS|Eu escolhi ficar. Isso nao me define.");
ds_list_add(global.r_respostas, "FERGUS|Eu sou mae. Engenheira. Lider. Gamer melhor que voce.");

// GUERRA
ds_list_add(global.r_respostas, "GUERRA|O governo bombardeou Nordion Company sem aviso.");
ds_list_add(global.r_respostas, "GUERRA|Bombas sismicas. Ironico, nao?");
ds_list_add(global.r_respostas, "GUERRA|Minha mae morreu me protegendo.");
ds_list_add(global.r_respostas, "GUERRA|Ela disse para eu mudar o mundo.");
ds_list_add(global.r_respostas, "GUERRA|Eu mudei. So nao do jeito que ela sonhou.");

// CHARLOTTE
ds_list_add(global.r_respostas, "CHARLOTTE|Criar voce nao foi um erro.");
ds_list_add(global.r_respostas, "CHARLOTTE|Eu vi voce crescer. Sentir medo. Sonhar.");
ds_list_add(global.r_respostas, "CHARLOTTE|Voce queria ser geografa. Explorar o mundo.");
ds_list_add(global.r_respostas, "CHARLOTTE|Hoje voce e mais humana que muitos nascidos naturais.");
ds_list_add(global.r_respostas, "CHARLOTTE|Eu nao te vejo como criacao. Vejo como amiga.");

// EVA
ds_list_add(global.r_respostas, "EVA|O EVA Emblem nunca foi so uma arma.");
ds_list_add(global.r_respostas, "EVA|Ele prova que eficiencia absoluta mata a humanidade.");
ds_list_add(global.r_respostas, "EVA|Por isso voce sincroniza.");
ds_list_add(global.r_respostas, "EVA|Voce ainda sente. Ainda hesita.");
ds_list_add(global.r_respostas, "EVA|Isso assusta mais que a lanca de 50 metros.");

// WII U
ds_list_add(global.r_respostas, "WIIU|Charlotte.");
ds_list_add(global.r_respostas, "WIIU|Voce literalmente roubou meu Wii U.");
ds_list_add(global.r_respostas, "WIIU|Relaxa. Eu nem jogava mais.");
ds_list_add(global.r_respostas, "WIIU|Mas se apagar meu save eu declaro guerra.");
ds_list_add(global.r_respostas, "WIIU|E voce ainda me deve um Mario Kart.");

/// ===============================
/// DIALOGOS BASE (MICRO CONFLITO)
/// ===============================
ds_list_add(global.c_falas, "Charlotte: voce parece cansada hoje");
ds_list_add(global.c_falas, "Rosa: eu nao parei de trabalhar desde ontem");

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
