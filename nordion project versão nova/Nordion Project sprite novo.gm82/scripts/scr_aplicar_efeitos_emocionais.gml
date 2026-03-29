/// scr_aplicar_efeitos_emocionais(categoria)
// Ajusta os status da Fir com base no tipo de interaÃ§Ã£o ocorrida.

var cat;
cat = string(argument0); // Garante que o argumento seja tratado como string

switch (cat) {
    case "romance":
        contador_relacao += 3;
        vergonha += 10;
        estresse -= 5;
        break;

    case "briga":
        contador_relacao -= 10;
        estresse += 20;
        vergonha += 5;
        break;

    case "aprendizado":
        contador_relacao += 1;
        // O aprendizado gera curiosidade, talvez reduzir um pouco o tÃ©dio/estresse
        estresse -= 1;
        break;

    case "conforto":
        estresse -= 15;
        vergonha -= 5;
        contador_relacao += 2;
        break;

    default:
        // Caso a categoria seja desconhecida ou genÃ©rica
        contador_relacao += 0.5;
        estresse -= 2;
        break;
}

// --- CLAMPING (LIMITADORES) ---
// Impede que os valores saiam do intervalo planejado (0 a 100/200)
// No GM 8.1, essa Ã© a forma mais segura de garantir a integridade da ficha
if (contador_relacao > 200) contador_relacao = 200;
if (contador_relacao < 0)   contador_relacao = 0;

if (estresse > 100) estresse = 100;
if (estresse < 0)   estresse = 0;

if (vergonha > 100) vergonha = 100;
if (vergonha < 0)   vergonha = 0;
