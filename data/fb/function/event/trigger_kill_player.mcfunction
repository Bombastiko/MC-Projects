# Trigger onKillPlayer callbacks
# Executed as the killer player

# Reset score
scoreboard players set @s fb.kill_p 0

# Execute callbacks
function fb:event/run_callbacks {event: "onKillPlayer"}
