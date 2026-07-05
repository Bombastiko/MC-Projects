# Run cleanup on players whose overwrite is on its last tick (expires this tick)
execute as @a[scores={fb.ab_over=1}] run function fb:display/ab/cleanup_overwrite

# Decrement active actionbar overwrites by 1
scoreboard players remove @a[scores={fb.ab_over=1..}] fb.ab_over 1

# Render overwrite for all players who currently have an active overwrite (independent of whether they have a timer)
execute as @a[scores={fb.ab_over=1..}] run function fb:display/ab/find_and_render_overwrite

# Run normal display loop for configured players
data modify storage fb:tmp players set from storage fb:config players
execute if data storage fb:tmp players[0] run function fb:display/ab/loop