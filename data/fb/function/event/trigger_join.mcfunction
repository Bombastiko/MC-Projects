# Trigger onJoin callbacks
# Executed as the joining player

# Reset leave score to mark as active
scoreboard players set @s fb.leave 0

# Debug log
execute if data storage fb:config {debug: 1b} run tellraw @a [{"text": "[FB DEBUG] trigger_join for ", "color": "gray"}, {"selector": "@s", "color": "white"}]

# Execute all registered onJoin callbacks
function fb:event/run_callbacks {event: "onJoin"}
