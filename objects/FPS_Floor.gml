#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//the floor! it's an object, and allows us to fall if we're not touching it.
z = 0;

{
tex = background_get_texture(FPS_texture_floor);
exit;
}

tex = background_get_texture(FPS_texture_floor);
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//draw floor and ceiling.
if (point_distance(x,y,global.camx,global.camy) > 501) exit;
d3d_draw_floor(x,y,0,x+32,y+32,0,tex,1,1)
