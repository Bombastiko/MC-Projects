# Trigger onDeath callbacks
# Executed as the dead player

# Reset death score to 0
scoreboard players set @s fb.death 0

# Execute all registered onDeath callbacks
function fb:event/run_callbacks {event: "onDeath"}
