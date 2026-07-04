# Event detection tick loop
# Executed as server every tick

# 1. Join Detection (runs if player leave score is uninitialized, or player has rejoined)
execute as @a unless score @s fb.leave matches 0.. run function fb:event/trigger_join
execute as @a if score @s fb.leave matches 1.. run function fb:event/trigger_join

# 2. Death Detection
execute as @a if score @s fb.death matches 1.. run function fb:event/trigger_death
