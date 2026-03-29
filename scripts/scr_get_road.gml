// Argumentos:
// argument0 = O array (ex: road_x)
// argument1 = A posição (pos)

var _pos, _i, _a, _len, _idx1, _idx2;

_pos = argument1;
_len = 200; // O tamanho que definimos no Create

_i = floor(_pos);
_a = _pos - _i;

// Faz o wrap (loop da pista)
_idx1 = _i mod _len;
_idx2 = (_i + 1) mod _len;

// Garante que o índice não seja negativo
if (_idx1 < 0) _idx1 += _len;
if (_idx2 < 0) _idx2 += _len;

// No GM 8.1, acessamos o array passado pelo argumento assim:
return argument0[_idx1] * (1 - _a) + argument0[_idx2] * _a;
