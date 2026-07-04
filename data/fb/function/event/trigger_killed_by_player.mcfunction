# Trigger onKilledByPlayer callbacks
# Executed as the victim player (who was killed by a player)

# Reset score
scoreboard players set @s fb.killed_by_p 0

# Execute callbacks
function fb:event/run_callbacks {event: "onKilledByPlayer"}
