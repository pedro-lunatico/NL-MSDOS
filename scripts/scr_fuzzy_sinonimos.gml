var s;
s = argument0;

// --- SAUDAÃ‡Ã•ES E DESPEDIDAS ---
s = string_replace_all(s, "oi", "ola");
s = string_replace_all(s, "eae", "ola");
s = string_replace_all(s, "salve", "ola");
s = string_replace_all(s, "opa", "ola");
s = string_replace_all(s, "bom dia", "ola");
s = string_replace_all(s, "boa tarde", "ola");
s = string_replace_all(s, "boa noite", "ola");
s = string_replace_all(s, "tchau", "adeus");
s = string_replace_all(s, "flw", "adeus");
s = string_replace_all(s, "fui", "adeus");
s = string_replace_all(s, "ate logo", "adeus");

// --- ELOGIOS (O NÃšCLEO DO ROMANCE) ---
s = string_replace_all(s, "bonita", "linda");
s = string_replace_all(s, "gata", "linda");
s = string_replace_all(s, "perfeita", "linda");
s = string_replace_all(s, "fofa", "linda");
s = string_replace_all(s, "maravilhosa", "linda");
s = string_replace_all(s, "incrivel", "linda");
s = string_replace_all(s, "inteligente", "sabia");
s = string_replace_all(s, "genia", "sabia");
s = string_replace_all(s, "esperta", "sabia");

// --- AFETO E RELACIONAMENTO ---
s = string_replace_all(s, "te amo", "amo");
s = string_replace_all(s, "adoro voce", "amo");
s = string_replace_all(s, "gosto de voce", "amo");
s = string_replace_all(s, "querida", "amor");
s = string_replace_all(s, "meu bem", "amor");
s = string_replace_all(s, "namorada", "esposa"); // Se global.casado for true, ela entende como um sÃ³
s = string_replace_all(s, "parceira", "esposa");

// --- SENTIMENTOS NEGATIVOS / BRIGAS ---
s = string_replace_all(s, "odeio", "raiva");
s = string_replace_all(s, "detesto", "raiva");
s = string_replace_all(s, "horror", "raiva");
s = string_replace_all(s, "burra", "idiota");
s = string_replace_all(s, "lixo", "idiota");
s = string_replace_all(s, "inutil", "idiota");
s = string_replace_all(s, "feia", "horrivel");
s = string_replace_all(s, "tiste", "triste"); // CorreÃ§Ã£o de typo comum
s = string_replace_all(s, "chateado", "triste");

// --- TERMOS DE GAME DEV (PARA O LEGACY) ---
s = string_replace_all(s, "codigo", "script");
s = string_replace_all(s, "programar", "script");
s = string_replace_all(s, "bug", "erro");
s = string_replace_all(s, "travou", "erro");
s = string_replace_all(s, "lento", "lag");
s = string_replace_all(s, "fps baixo", "lag");
s = string_replace_all(s, "desenhar", "renderizar");
s = string_replace_all(s, "boneco", "sprite");
s = string_replace_all(s, "imagem", "sprite");

// --- MUNDO DE NORDION / SACAE ---
s = string_replace_all(s, "cavalo", "trueno");
s = string_replace_all(s, "montaria", "trueno");
s = string_replace_all(s, "espada", "lamina");
s = string_replace_all(s, "katana", "lamina");
s = string_replace_all(s, "combate", "luta");
s = string_replace_all(s, "treinar", "luta");
s = string_replace_all(s, "copia", "clone");
s = string_replace_all(s, "outra fir", "clone");

// --- VARIAÃ‡Ã•ES DE ESCRITA INTERNET ---
s = string_replace_all(s, " vc ", " voce "); // Normaliza o "vc"
s = string_replace_all(s, " pq ", " porque ");
s = string_replace_all(s, " tbm ", " tambem ");
s = string_replace_all(s, " mt ", " muito ");
s = string_replace_all(s, " mto ", " muito ");

s = string_replace_all(s, "becker", "pai_cruel");
s = string_replace_all(s, "sintetico", "artificial");
s = string_replace_all(s, "clone", "artificial");
s = string_replace_all(s, "miata", "carro");

 s = string_replace_all(s, "experimento", "becker");
s = string_replace_all(s, "sintetico", "becker");
s = string_replace_all(s, "artificial", "becker");
s = string_replace_all(s, "falha", "becker");
return s;
