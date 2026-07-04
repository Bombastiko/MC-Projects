# Trigger onJoin callbacks
# Executed as the joining player

# Reset leave score to mark as active
scoreboard players set @s fb.leave 0

# Execute all registered onJoin callbacks
function fb:event/run_callbacks {event: "onJoin"}
