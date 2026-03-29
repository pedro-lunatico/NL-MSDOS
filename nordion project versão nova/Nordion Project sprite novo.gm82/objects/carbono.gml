#define Mouse_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Declara o inventário no início do código
var inv;
inv = global.player_inventory;

// Adiciona o item "C"
ds_list_add(inv, "C");

// Destrói o objeto coletado
instance_destroy();
