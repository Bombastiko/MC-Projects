# Decrement time helper
# Arguments: name

# If seconds > 0
$execute if score #$(name) fb.cd.s matches 1.. run scoreboard players set #$(name) fb.cd.t 19
$execute if score #$(name) fb.cd.t matches 19 run scoreboard players remove #$(name) fb.cd.s 1

# If seconds == 0 and minutes > 0
$execute if score #$(name) fb.cd.t matches ..-1 if score #$(name) fb.cd.m matches 1.. run scoreboard players set #$(name) fb.cd.s 59
$execute if score #$(name) fb.cd.t matches ..-1 if score #$(name) fb.cd.m matches 1.. run scoreboard players remove #$(name) fb.cd.m 1
$execute if score #$(name) fb.cd.t matches ..-1 if score #$(name) fb.cd.m matches 0.. run scoreboard players set #$(name) fb.cd.t 19

# If seconds == 0 and minutes == 0 and hours > 0
$execute if score #$(name) fb.cd.t matches ..-1 if score #$(name) fb.cd.h matches 1.. run scoreboard players set #$(name) fb.cd.m 59
$execute if score #$(name) fb.cd.t matches ..-1 if score #$(name) fb.cd.h matches 1.. run scoreboard players set #$(name) fb.cd.s 59
$execute if score #$(name) fb.cd.t matches ..-1 if score #$(name) fb.cd.h matches 1.. run scoreboard players remove #$(name) fb.cd.h 1
$execute if score #$(name) fb.cd.t matches ..-1 if score #$(name) fb.cd.h matches 0.. run scoreboard players set #$(name) fb.cd.t 19

# If still -1, it means h, m, s are all 0 -> Trigger Expiry!
$execute if score #$(name) fb.cd.t matches ..-1 run function fb:cd/expire {name: "$(name)"}
