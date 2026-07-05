# Decrement active actionbar overwrites by 1
scoreboard players remove @a[scores={fb.ab_over=1..}] fb.ab_over 1

data modify storage fb:tmp players set from storage fb:config players
execute if data storage fb:tmp players[0] run function fb:display/ab/loop