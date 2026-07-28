# Trigger onDeath callbacks
# Executed as the dead player

# Reset death score to 0
scoreboard players set @s fb.death 0

# Debug log
execute if data storage fb:config {debug:{event:1b}} run tellraw @a [{"text": "[FB DEBUG] trigger_death for ", "color": "gray"}, {"selector": "@s", "color": "white"}]

# Execute all registered onDeath callbacks
function fb:event/run_callbacks {event: "onDeath"}
