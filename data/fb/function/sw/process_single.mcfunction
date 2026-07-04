$execute if data storage fb:config {debug: 1b} run tellraw @a [{"text": "[FB DEBUG] sw/process_single for ", "color": "gray"}, {"text": "$(name)", "color": "white"}]

$scoreboard players add #$(name) fb.sw.t 1
$scoreboard players add #$(name) fb.sw.at 1

$execute if score #$(name) fb.sw.t matches 20.. run scoreboard players add #$(name) fb.sw.s 1
$execute if score #$(name) fb.sw.t matches 20.. run scoreboard players set #$(name) fb.sw.t 0

$execute if score #$(name) fb.sw.s matches 60.. run scoreboard players add #$(name) fb.sw.m 1
$execute if score #$(name) fb.sw.s matches 60.. run scoreboard players set #$(name) fb.sw.s 0

$execute if score #$(name) fb.sw.m matches 60.. run scoreboard players add #$(name) fb.sw.h 1
$execute if score #$(name) fb.sw.m matches 60.. run scoreboard players set #$(name) fb.sw.m 0

$execute if score #$(name) fb.sw.h matches 24.. run scoreboard players add #$(name) fb.sw.d 1
$execute if score #$(name) fb.sw.h matches 24.. run scoreboard players set #$(name) fb.sw.d 0

$execute if score #$(name) fb.sw.t matches ..9 run scoreboard players set #$(name)-e fb.sw.t 0
$execute unless score #$(name) fb.sw.t matches ..9 run scoreboard players reset #$(name)-e fb.sw.t

$execute if score #$(name) fb.sw.s matches ..9 run scoreboard players set #$(name)-e fb.sw.s 0
$execute unless score #$(name) fb.sw.s matches ..9 run scoreboard players reset #$(name)-e fb.sw.s

$execute if score #$(name) fb.sw.m matches ..9 run scoreboard players set #$(name)-e fb.sw.m 0
$execute unless score #$(name) fb.sw.m matches ..9 run scoreboard players reset #$(name)-e fb.sw.m

$execute if score #$(name) fb.sw.h matches ..9 run scoreboard players set #$(name)-e fb.sw.h 0
$execute unless score #$(name) fb.sw.h matches ..9 run scoreboard players reset #$(name)-e fb.sw.h