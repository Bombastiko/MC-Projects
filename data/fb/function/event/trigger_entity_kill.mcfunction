# Trigger onEntityKill callbacks
# Executed as the player who killed a mob

# Reset score first
scoreboard players set @s fb.mob_kills 0

# Run callbacks
function fb:event/run_callbacks {event: "onEntityKill"}
