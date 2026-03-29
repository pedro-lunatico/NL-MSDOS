#define Mouse_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
switch show_message_ext("MikuNET esta indisponível agora. Chame seu providor de MikuNET com esse codígo: M403", "Volte", "Renicie meu PC", "Feche") {
       case 1:
            show_message("MIKUOS: Falha total em aplicativo MikuNET Explorer 1.01, 0xFFFF0DDEE, 0xFEEDFFDEE, 0x000FFF00")
       case 3:
            show_message("MIKUOS: Falha total em aplicativo MikuNET Explorer 1.01, 0xFFFF0DDEE, 0xFEEDFFDEE, 0x000FFF00")
}
show_message("MIKUOS: Um erro fatal aconteceu no sistema. Não podemos recuperar data perdida (0x000, 0x0ff, 0xff0)")
room_restart()
