scoreboard objectives add fb.sw.t dummy
scoreboard objectives add fb.sw.at dummy
scoreboard objectives add fb.sw.s dummy
scoreboard objectives add fb.sw.m dummy
scoreboard objectives add fb.sw.h dummy
scoreboard objectives add fb.sw.d dummy

execute unless data storage fb:config debug run data modify storage fb:config debug set value 0b