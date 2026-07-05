# Trigger onKilledByPlayer callbacks
# Executed as the victim player (who was killed by a player)

# Reset score
scoreboard players set @s fb.killed_by_p 0

# Debug log
execute if data storage fb:config {debug:{event:1b}} run tellraw @a [{"text": "[FB DEBUG] trigger_killed_by_player for ", "color": "gray"}, {"selector": "@s", "color": "white"}]

# Execute callbacks
function fb:event/run_callbacks {event: "onKilledByPlayer"}
