$execute if data storage fb:config {debug: 1b} run tellraw @a [{"text": "[FB DEBUG] cd/process_single for ", "color": "gray"}, {"text": "$(name)", "color": "white"}]

# 1. Active ticking state
$execute if score #$(name) fb.cd.state matches 0 run scoreboard players remove #$(name) fb.cd.t 1
$execute if score #$(name) fb.cd.state matches 0 if score #$(name) fb.cd.t matches ..-1 run function fb:cd/decrement_time {name: "$(name)"}

# Update milliseconds if still active
$execute if score #$(name) fb.cd.state matches 0 run scoreboard players operation #$(name) fb.cd.ms = #$(name) fb.cd.t
$execute if score #$(name) fb.cd.state matches 0 run scoreboard players operation #$(name) fb.cd.ms *= #5 fb.cd.ms

# 2. Expired/Animating state
$execute if score #$(name) fb.cd.state matches 1 if score #$(name) fb.cd.anim matches ..60 run scoreboard players add #$(name) fb.cd.anim 1

# Check if animation is 'stay'
data modify storage fb:tmp check_stay set value [{val: "none"}]
$data modify storage fb:tmp check_stay[0].val set from storage fb:main cd.db[{name:"$(name)"}].animation

# Set state to 2 (finish animating) only if NOT 'stay'
$execute if score #$(name) fb.cd.state matches 1 if score #$(name) fb.cd.anim matches 60.. unless data storage fb:tmp check_stay[{val:"stay"}] run scoreboard players set #$(name) fb.cd.state 2
$execute if score #$(name) fb.cd.state matches 2 run data remove storage fb:main cd.list[{name:"$(name)"}]

# 3. Setup zero-padding indicator players
$execute if score #$(name) fb.cd.t matches ..9 run scoreboard players set #$(name)-e fb.cd.t 0
$execute unless score #$(name) fb.cd.t matches ..9 run scoreboard players reset #$(name)-e fb.cd.t

$execute if score #$(name) fb.cd.s matches ..9 run scoreboard players set #$(name)-e fb.cd.s 0
$execute unless score #$(name) fb.cd.s matches ..9 run scoreboard players reset #$(name)-e fb.cd.s

$execute if score #$(name) fb.cd.m matches ..9 run scoreboard players set #$(name)-e fb.cd.m 0
$execute unless score #$(name) fb.cd.m matches ..9 run scoreboard players reset #$(name)-e fb.cd.m

$execute if score #$(name) fb.cd.h matches ..9 run scoreboard players set #$(name)-e fb.cd.h 0
$execute unless score #$(name) fb.cd.h matches ..9 run scoreboard players reset #$(name)-e fb.cd.h

$execute if score #$(name) fb.cd.ms matches ..9 run scoreboard players set #$(name)-e fb.cd.ms 0
$execute unless score #$(name) fb.cd.ms matches ..9 run scoreboard players reset #$(name)-e fb.cd.ms
