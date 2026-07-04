# Event detection tick loop
# Executed as server every tick

# 1. Join Detection (runs if player leave score is uninitialized, or player has rejoined)
execute as @a unless score @s fb.leave matches 0.. run function fb:event/trigger_join
execute as @a if score @s fb.leave matches 1.. run function fb:event/trigger_join

# 2. Death Detection
execute as @a if score @s fb.death matches 1.. run function fb:event/trigger_death

# 3. Kill Player Detection
execute as @a if score @s fb.kill_p matches 1.. run function fb:event/trigger_kill_player

# 4. Killed by Player Detection
execute as @a if score @s fb.killed_by_p matches 1.. run function fb:event/trigger_killed_by_player

