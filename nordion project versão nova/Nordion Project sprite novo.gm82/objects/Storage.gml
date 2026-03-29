#define Mouse_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
show_message("Vamos ver um video!")

video = get_open_filename("Video | *.wmv, *.avi, *.mpg, *.mp4",'')

splash_set_interrupt(true);

splash_set_main(true);

splash_set_scale(2);

splash_show_video(video, false);
