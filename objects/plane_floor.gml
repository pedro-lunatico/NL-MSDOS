#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//the floor! it's an object, and allows us to fall if we're not touching it.
z = 0;

{
tex = background_get_texture(background56);
exit;
}

tex = background_get_texture(background56);
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//draw floor and ceiling.
if (point_distance(x,y,global.camx,global.camy) > 501) exit;
d3d_draw_floor(x,y,0,x+1028,y+1028,0,tex,1,1)
