#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// JobPosts

jobs[0] = Job_Program;
jobs[1] = Job_Clone;

wellness[0] = Job_Eat;
wellness[1] = Job_Sleep;

tired = 0
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Do Job/Wellness

if tired > 75 {
    torun = floor(irandom(2))
    togo = instance_nearest(x,y,jobs[torun])
    move_towards_point(togo.x,togo.y,2)
} else {
    torun = floor(irandom(2))
    togo = instance_nearest(x,y,jobs[torun])
    move_towards_point(togo.x,togo.y,2)
}
#define Mouse_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=211
invert=0
arg0=dano_de_espada
arg1=0
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=532
relative=1
applies_to=self
invert=0
arg0=8
arg1=0
arg2=0
arg3=2
arg4=33023
arg5=0
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=203
applies_to=self
invert=0
*/
