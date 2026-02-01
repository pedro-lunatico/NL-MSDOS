#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
{
  x1 = x;
  x2 = x;
  y1 = y-16;
  y2 = y+16;
  z = 0;
  tex = background_get_texture(FPS_texture_wall1);
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if point_distance(x,y,global.camx,global.camy) > 1001 exit;
d3d_draw_wall(x1,y1,z+32,x2,y2,z,tex,1,1);
