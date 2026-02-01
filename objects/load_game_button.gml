#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_xscale = 1;
image_yscale = 1;
target_scale = 1;
target_x = x;
lerp_speed = 0.15;

image_alpha = 1;
y_default = y;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// interpolação horizontal
x += (target_x - x) * lerp_speed;

// interpolação escala
image_xscale += (target_scale - image_xscale) * lerp_speed;
image_yscale = image_xscale;

// profundidade
y = y_default + (1 - image_xscale) * 30;

// alpha cinematográfico
var target_alpha;
target_alpha = clamp(image_xscale, 0.5, 1);
image_alpha += (target_alpha - image_alpha) * 0.15;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_self();
