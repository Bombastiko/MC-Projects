scoreboard objectives add fb.sw.t dummy
scoreboard objectives add fb.sw.at dummy
scoreboard objectives add fb.sw.s dummy
scoreboard objectives add fb.sw.m dummy
scoreboard objectives add fb.sw.h dummy
scoreboard objectives add fb.sw.d dummy
scoreboard objectives add fb.sw.ms dummy

execute if data storage fb:config debug unless data storage fb:config {debug:{global:0b}} unless data storage fb:config {debug:{global:1b}} run data remove storage fb:config debug
execute unless data storage fb:config debug run data modify storage fb:config debug set value {global: 0b, sw: 0b, cd: 0b, event: 0b}
scoreboard players set #5 fb.sw.ms 5