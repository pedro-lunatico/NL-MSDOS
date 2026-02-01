#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Load LeekBox Services

files[0] = 0
click[0,0] = 0 /// [i,t], t={1=TYPE,2=INS,3=USR}

i = 100
// carregar os arquivo
while i > 0 {
    i = i - 1
    switch irandom(5) {
        case 0:
            files[i] = "MikuOS - Welcome.mid"
            click[i,2] = MikuOS_Welcome
            click[i,1] = "audio"
            click[i,3] = "MikuOS"
        case 1:
            files[i] = "Diva.fff"
    }
}
