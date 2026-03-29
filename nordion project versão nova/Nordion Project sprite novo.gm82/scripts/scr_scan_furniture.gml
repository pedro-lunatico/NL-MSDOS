// Script: scr_scan_furniture
var i, row, temp_inst;

ds_grid_clear(global.catalog_grid, 0);
ds_grid_resize(global.catalog_grid, 3, 0);

for (i = 0; i < 1000; i += 1) {
    if (object_exists(i)) {
        // Verifica se é filho do controlador
        if (object_is_ancestor(i, obj_build_controller)) {

            row = ds_grid_height(global.catalog_grid);
            ds_grid_resize(global.catalog_grid, 3, row + 1);

            ds_grid_set(global.catalog_grid, 0, row, i);
            ds_grid_set(global.catalog_grid, 1, row, object_get_sprite(i));

            // PROTEÇÃO: Criar instância para ler o preço
            temp_inst = instance_create(-500, -500, i);

            // Verifica se a variável 'price' existe na instância para não travar
            if (variable_local_exists("price")) {
                ds_grid_set(global.catalog_grid, 2, row, temp_inst.price);
            } else {
                ds_grid_set(global.catalog_grid, 2, row, 999); // Preço padrão se esquecer
            }

            with (temp_inst) { instance_destroy(); }
        }
    }
}
