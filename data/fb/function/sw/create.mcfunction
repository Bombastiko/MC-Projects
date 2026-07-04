# Create stopwatch
# Arguments: name

execute unless data storage fb:main sw.list run data modify storage fb:main sw.list set value []

$scoreboard players set #$(name) fb.sw.t 0
$scoreboard players set #$(name) fb.sw.at 0
$scoreboard players set #$(name) fb.sw.s 0
$scoreboard players set #$(name) fb.sw.m 0
$scoreboard players set #$(name) fb.sw.h 0
$scoreboard players set #$(name) fb.sw.d 0

$data remove storage fb:main sw.list[{name:"$(name)"}]
$data modify storage fb:main sw.list append value {name: "$(name)"}