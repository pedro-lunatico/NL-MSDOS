//
// Used to set a "3D" 2D image.
// Written by Cubasy. Give credit if used.
//
// scr_sprite_model(right,upright,up,upleft,left,downleft,down,downright,camera,direction)
//
// Big thing
 var left, right, up, down, upright, upleft, downleft, downright, dir, camera, spr;
 right = argument0
 upright = argument1
 up = argument2
 upleft = argument3
 left = argument4
 downleft = argument5
 down = argument6
 downright = argument7
 camera = argument8
 dir = point_direction(x,y,camera.x,camera.y)

 if direction>22.5 && direction<67.5 {spr=upright}
 else if direction>67.5 && direction<112.5 {spr=up}
 else if direction>112.5 && direction<156.5 {spr=upleft}
 else if direction>156.5 && direction<202.5 {spr=left}
 else if direction>202.5 && direction<247.5 {spr=downleft}
 else if direction>247.5 && direction<292.5 {spr=down}
 else if direction>292.5 && direction<337.5 {spr=downright}
 else {spr=right}

 if spr=right
 {
  if dir>22.5 && dir<67.5 {final_sprite=downleft}
  else if dir>67.5 && dir<112.5 {final_sprite=left}
  else if dir>112.5 && dir<156.5 {final_sprite=upleft}
  else if dir>156.5 && dir<202.5 {final_sprite=up}
  else if dir>202.5 && dir<247.5 {final_sprite=upright}
  else if dir>247.5 && dir<292.5 {final_sprite=right}
  else if dir>292.5 && dir<337.5 {final_sprite=downright}
  else {final_sprite=down}
 }
 else if spr=upright
 {
  if dir>22.5 && dir<67.5 {final_sprite=down}
  else if dir>67.5 && dir<112.5 {final_sprite=downleft}
  else if dir>112.5 && dir<156.5 {final_sprite=left}
  else if dir>156.5 && dir<202.5 {final_sprite=upleft}
  else if dir>202.5 && dir<247.5 {final_sprite=up}
  else if dir>247.5 && dir<292.5 {final_sprite=upright}
  else if dir>292.5 && dir<337.5  {final_sprite=right}
  else {final_sprite=downright}
 }
 else if spr=upleft
 {
  if dir>22.5 && dir<67.5 {final_sprite=right}
  else if dir>67.5 && dir<112.5 {final_sprite=downright}
  else if dir>112.5 && dir<156.5 {final_sprite=down}
  else if dir>156.5 && dir<202.5 {final_sprite=downleft}
  else if dir>202.5 && dir<247.5 {final_sprite=left}
  else if dir>247.5 && dir<292.5 {final_sprite=upleft}
  else if dir>292.5 && dir<337.5  {final_sprite=up}
  else {final_sprite=upright}
 }
 else if spr=up
 {
  if dir>22.5 && dir<67.5 {final_sprite=downright}
  else if dir>67.5 && dir<112.5 {final_sprite=down}
  else if dir>112.5 && dir<156.5 {final_sprite=downleft}
  else if dir>156.5 && dir<202.5 {final_sprite=left}
  else if dir>202.5 && dir<247.5 {final_sprite=upleft}
  else if dir>247.5 && dir<292.5 {final_sprite=up}
  else if dir>292.5 && dir<337.5  {final_sprite=upright}
  else {final_sprite=right}
 }
 else if spr=left
 {
  if dir>22.5 && dir<67.5 {final_sprite=upright}
  else if dir>67.5 && dir<112.5 {final_sprite=right}
  else if dir>112.5 && dir<156.5 {final_sprite=downright}
  else if dir>156.5 && dir<202.5 {final_sprite=down}
  else if dir>202.5 && dir<247.5 {final_sprite=downleft}
  else if dir>247.5 && dir<292.5 {final_sprite=left}
  else if dir>292.5 && dir<337.5  {final_sprite=upleft}
  else {final_sprite=up}
 }
 else if spr=downleft
 {
  if dir>22.5 && dir<67.5 {final_sprite=up}
  else if dir>67.5 && dir<112.5 {final_sprite=upright}
  else if dir>112.5 && dir<156.5 {final_sprite=right}
  else if dir>156.5 && dir<202.5 {final_sprite=downright}
  else if dir>202.5 && dir<247.5 {final_sprite=down}
  else if dir>247.5 && dir<292.5 {final_sprite=downleft}
  else if dir>292.5 && dir<337.5  {final_sprite=left}
  else {final_sprite=upleft}
 }
 else if spr=down
 {
  if dir>22.5 && dir<67.5 {final_sprite=upleft}
  else if dir>67.5 && dir<112.5 {final_sprite=up}
  else if dir>112.5 && dir<156.5 {final_sprite=upright}
  else if dir>156.5 && dir<202.5 {final_sprite=right}
  else if dir>202.5 && dir<247.5 {final_sprite=downright}
  else if dir>247.5 && dir<292.5 {final_sprite=down}
  else if dir>292.5 && dir<337.5  {final_sprite=downleft}
  else {final_sprite=left}
 }
 else if spr=downright
 {
  if dir>22.5 && dir<67.5 {final_sprite=left}
  else if dir>67.5 && dir<112.5 {final_sprite=upleft}
  else if dir>112.5 && dir<156.5 {final_sprite=up}
  else if dir>156.5 && dir<202.5 {final_sprite=upright}
  else if dir>202.5 && dir<247.5 {final_sprite=right}
  else if dir>247.5 && dir<292.5 {final_sprite=downright}
  else if dir>292.5 && dir<337.5  {final_sprite=down}
  else {final_sprite=downleft}
 }
