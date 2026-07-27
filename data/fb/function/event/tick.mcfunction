# FuseBox Event System - Tick Loop
# Executed as server every tick

# 1. Join Detection
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

# 7. Hold Item Detection (runs ONLY if callbacks exist in registry)
execute if data storage fb:events onHoldItem[0] as @a run function fb:event/trigger_hold

# 8. While Online Loop
execute if data storage fb:events whileOnline[0] run function fb:event/tick_while_online

# 9. While Offline Loop
execute if data storage fb:events whileOffline[0] run function fb:event/tick_while_offline

# 10. Damage Taken Detection
execute as @a if score @s fb.dmg_taken matches 1.. run function fb:event/trigger_damage

# 11. Entity Kill Detection
execute as @a if score @s fb.mob_kills matches 1.. run function fb:event/trigger_entity_kill
