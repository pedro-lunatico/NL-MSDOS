str = string_copy(global.curstr, 1, global.advstr);
if global.tick > 50 && global.advstr <= string_length(global.curstr) {
    global.tick = 0;
    global.advstr = global.advstr + 1;
}


{   // Draw Box
    draw_set_color(c_black);
    draw_rectangle(0,room_height/3,room_width, room_height/3, false);

    // Draw Box Outline
    draw_set_color(c_white);
    draw_rectangle(0,room_height/3,room_width, room_height/3, true);
}

{
    draw_set_color(c_white);
    draw_set_font(normal);
    draw_text(5, room_height/3 - room_height/50, str);
}
