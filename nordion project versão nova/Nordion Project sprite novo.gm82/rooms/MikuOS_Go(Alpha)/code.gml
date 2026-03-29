sound_stop_all()
splash_set_border(false)
splash_set_cursor(false)
splash_set_close_button(false)
splash_set_interrupt(true)
splash_set_stop_key(vk_numpad9)
splash_set_stop_mouse(false)
splash_show_video(temp_directory+"\mstart.wmv",false)
if irandom(1) == 1 {
   show_message("MIKUOS: Uma erro fatal aconteceu antes do Miku-9x carregar. Reniciando")
   room_restart()
}
sound_play(MikuOS_Theme)
