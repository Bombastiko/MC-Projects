# Delete countdown timer
# Arguments: name

$scoreboard players reset #$(name) fb.cd.h
$scoreboard players reset #$(name) fb.cd.m
$scoreboard players reset #$(name) fb.cd.s
$scoreboard players reset #$(name) fb.cd.t
$scoreboard players reset #$(name) fb.cd.ms
$scoreboard players reset #$(name) fb.cd.anim
$scoreboard players reset #$(name) fb.cd.state

# Reset padding indicators
$scoreboard players reset #$(name)-e fb.cd.h
$scoreboard players reset #$(name)-e fb.cd.m
$scoreboard players reset #$(name)-e fb.cd.s
$scoreboard players reset #$(name)-e fb.cd.t
$scoreboard players reset #$(name)-e fb.cd.ms

$data remove storage fb:main cd.list[{name:"$(name)"}]
$data remove storage fb:main cd.db[{name:"$(name)"}]
