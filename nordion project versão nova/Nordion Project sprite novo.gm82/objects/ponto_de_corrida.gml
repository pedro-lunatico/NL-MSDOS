#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Estado do diálogo
dialog_active = false; // começa falso, aparece ao clicar

// Texto do diálogo
dialog_text = "Escolha as equipes";

// Lista de opções
choices = ds_list_create();
ds_list_add(choices, "Red Druid");
ds_list_add(choices, "Silesia Speed Stars");
ds_list_add(choices, "Project Nubes");

// Correspondência das rooms (use os nomes exatos das rooms do seu projeto)
choice_rooms = ds_list_create();
ds_list_add(choice_rooms, Kent_Dialogue_Room);
ds_list_add(choice_rooms, Heath_Dialogue_Room);
ds_list_add(choice_rooms, Ghost_Nimbus_Dialogue_Room);

// Configurações visuais
dialog_width = 400;
dialog_height = 200;
choice_width = 200;
choice_height = 30;
choice_spacing = 40;

// Inicializa posições
dialog_x = 0;
dialog_y = 0;
option_x = 0;
option_y = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (dialog_active) {
    // Centraliza na view
    dialog_x = view_xview[0] + (view_wview[0] - dialog_width) / 2;
    dialog_y = view_yview[0] + (view_hview[0] - dialog_height) / 2;

    option_x = dialog_x + (dialog_width - choice_width) / 2;

    // Checa clique nas opções
    i = 0;
    while (i < ds_list_size(choices)) {
        option_y = dialog_y + 60 + i * choice_spacing;

        if (mouse_x > option_x && mouse_x < option_x + choice_width &&
            mouse_y > option_y && mouse_y < option_y + choice_height &&
            mouse_check_button_pressed(mb_left))
        {
            room_goto(ds_list_find_value(choice_rooms, i));
        }

        i += 1;
    }
}
#define Mouse_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Ativa o diálogo ao clicar no objeto
dialog_active = true;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Desenha sprite normal
draw_self();

if (dialog_active) {
    dlg_x = dialog_x;
    dlg_y = dialog_y;
    opt_x = option_x;

    // Fundo do diálogo
    draw_set_color(c_black);
    draw_rectangle(dlg_x, dlg_y, dlg_x + dialog_width, dlg_y + dialog_height, false);

    // Texto do diálogo
    draw_set_color(c_white);
    draw_text(dlg_x + 20, dlg_y + 20, dialog_text);

    // Loop para desenhar as opções
    i = 0;
    while (i < ds_list_size(choices)) {
        opt_y = dlg_y + 60 + i * choice_spacing;

        draw_set_color(c_gray);
        draw_rectangle(opt_x, opt_y, opt_x + choice_width, opt_y + choice_height, false);

        draw_set_color(c_white);
        draw_text(opt_x + 10, opt_y + 5, ds_list_find_value(choices, i));

        i += 1;
    }
}
