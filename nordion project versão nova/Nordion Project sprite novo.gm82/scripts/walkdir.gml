left = argument1;
right = argument2;
obj = argument0;

with obj {
    if x < mouse_x {
        object_set_sprite(self, left);
    } else if x > mouse_x {
        object_set_sprite(self, right);
    }
}
