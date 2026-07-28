# Trigger onJoin callbacks
# Executed as the joining player

# Reset leave score to mark as active
scoreboard players set @s fb.leave 0

# Check and display install message if new installation
execute unless data storage fb:config {installed:1b} run function fb:event/show_install_message

# Debug log
execute if data storage fb:config {debug:{event:1b}} run tellraw @a [{"text": "[FB DEBUG] trigger_join for ", "color": "gray"}, {"selector": "@s", "color": "white"}]

# Execute all registered onJoin callbacks
function fb:event/run_callbacks {event: "onJoin"}
