$execute if data storage fb:config {debug:{cd:1b}} run tellraw @a [{"text": "[FB DEBUG] cd/process_single for ", "color": "gray"}, {"text": "$(name)", "color": "white"}]

# 1. Active ticking state
$execute if score #$(name) fb.cd.state matches 0 run scoreboard players remove #$(name) fb.cd.t 1
$execute if score #$(name) fb.cd.state matches 0 if score #$(name) fb.cd.t matches ..-1 run function fb:cd/decrement_time {name: "$(name)"}

# Update milliseconds if still active
$execute if score #$(name) fb.cd.state matches 0 run scoreboard players operation #$(name) fb.cd.ms = #$(name) fb.cd.t
$execute if score #$(name) fb.cd.state matches 0 run scoreboard players operation #$(name) fb.cd.ms *= #5 fb.cd.ms

# 2. Setup zero-padding indicator players
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
