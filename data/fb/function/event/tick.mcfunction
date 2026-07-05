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

# 5. Leave Detection
function fb:event/check_leaves

# 6. Right Click Item Detection
execute as @a if score @s fb.rc_stick matches 1.. run function fb:event/trigger_right_click
execute as @a if score @s fb.rc_fungus matches 1.. run function fb:event/trigger_right_click

# 7. Hold Item Detection
execute as @a if data storage fb:events onHoldItem run function fb:event/run_callbacks {event: "onHoldItem"}

# 8. While Online Loop (runs every tick for all online players if callbacks are registered)
execute if data storage fb:events whileOnline run function fb:event/tick_while_online

# 9. While Offline Loop (runs every tick for all offline players if callbacks are registered)
execute if data storage fb:events whileOffline run function fb:event/tick_while_offline

# 10. Damage Taken Detection
execute as @a if score @s fb.dmg_taken matches 1.. run function fb:event/trigger_damage

# 11. Entity Kill Detection
execute as @a if score @s fb.mob_kills matches 1.. run function fb:event/trigger_entity_kill




