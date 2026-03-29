/// scr_sincronizar_clones(id_parceira)
var parceira, minha_grade, grade_dela, i, str_nova, cat_nova;
parceira = argument0;
minha_grade = memoria_pessoal;
grade_dela = parceira.memoria_pessoal;

// Percorre a memória da parceira para "aprender" o que ela viu
for (i = 0; i < ds_grid_height(grade_dela); i += 1) {
    str_nova = ds_grid_get(grade_dela, 0, i);
    cat_nova = ds_grid_get(grade_dela, 1, i);

    // Só aprende se a string ainda não existir na minha memória
    if (ds_grid_value_exists(minha_grade, 0, 0, 2, ds_grid_height(minha_grade)-1, str_nova) == false) {
        var h; h = ds_grid_height(minha_grade);
        ds_grid_resize(minha_grade, 3, h + 1);
        ds_grid_set(minha_grade, 0, h, str_nova);
        ds_grid_set(minha_grade, 1, h, cat_nova);

        // Feedback visual de que "aprendeu" algo
        flash_timer = 5;
        flash_color = c_lime;
    }
}
