// scr_npc_mplay_init()
// Tenta iniciar TCP/IP (o mais comum hoje)
if (mplay_init_tcpip('')) {
    show_message("Conectado ao protocolo TCP/IP!");
} else {
    show_message("Erro ao iniciar protocolo.");
}

npc_id_data = 10; // Usaremos a posicao 10 do Shared Data para este NPC
mplay_data_mode(true); // Garantir que os dados cheguem a todos
