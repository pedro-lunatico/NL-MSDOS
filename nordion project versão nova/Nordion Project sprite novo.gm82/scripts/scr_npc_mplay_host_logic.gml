// No Step Event do NPC (Apenas se mplay_session_status() == 1)
var msg_recebida;

// Verifica se há mensagens de jogadores para o NPC
if (mplay_message_receive(0)) {
    if (mplay_message_id() == 500) { // 500 = ID de pergunta ao NPC
        msg_recebida = mplay_message_value();

        // Aqui voce processaria a IA (como no exemplo anterior)
        // Por enquanto, faremos uma resposta automatica:
        var resposta;
        resposta = "Voce disse: " + msg_recebida + ". Eu sou um NPC sincronizado!";

        // Escreve no Shared Data para que TODOS os jogadores vejam
        mplay_data_write(npc_id_data, resposta);
    }
}
