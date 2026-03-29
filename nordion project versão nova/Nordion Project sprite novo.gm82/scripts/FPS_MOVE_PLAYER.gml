//Argument0 = pixels to move
//Argument1 = maximum direction it can slide along (try 95)
//argument2 = current direction
//Argument3 = Collision radius
//Argument4 = Wall object to check against
//Argument5 = Amount of running w/ shift (put 0 for no running)
//Returns true if we were able to move/slide or False if we cannot move at all.
var run;
run = 0;
if keyboard_check(vk_shift) {
run = argument5;
}
x += lengthdir_x(argument0+run, argument2);
y += lengthdir_y(argument0+run, argument2);
var ii, i;
ii = 1;
if(collision_circle(x, y, argument3, argument4, true, true))
{
    x = xprevious;
    y = yprevious;
    for(i = 0; i < 8; i += 1)
    {
        repeat(2)
        {
            x += lengthdir_x(argument0+run, argument2+ ((i*argument1/8)*ii));
            y += lengthdir_y(argument0+run, argument2+ ((i*argument1/8)*ii));
            if(!collision_circle(x, y, argument3, argument4, true, true)) return true;
            x = xprevious;
            y = yprevious;
            ii = -ii;
        }
    }
} else return true;
return false;
