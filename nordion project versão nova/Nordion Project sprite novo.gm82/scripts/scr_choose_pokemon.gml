/// scr_choose_pokemon()
/// retorna o nome do pokemon escolhido

idx = 0;            // índice do pokémon atual
max = global.player_pokemon_count;

while (true)
{
    b1 = "";
    b2 = "";
    b3 = "";
    var choice;

    // preencher página
    if (idx < max)   b1 = global.player_pokemon[idx];
    if (idx+1 < max) b2 = global.player_pokemon[idx+1];
    if (idx+2 < max) b3 = global.player_pokemon[idx+2];

    // botão MAIS se houver mais pokémons
    mais = (idx+3 < max);

    if (mais)
    {
        choice = show_message_ext(
            "Escolha seu Pokémon:",
            b1,
            b2,
            "Mais >>>"
        );
    }
    else
    {
        choice = show_message_ext(
            "Escolha seu Pokémon:",
            b1,
            b2,
            b3
        );
    }

    // interpretar escolha
    if (choice == 1) return b1;
    if (choice == 2) return b2;

    if (choice == 3)
    {
        // se não tem mais, escolheu o b3
        if (!mais) return b3;

        // senão → próxima página
        idx += 3;
    }
}
