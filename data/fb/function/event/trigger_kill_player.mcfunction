# Trigger onKillPlayer callbacks
# Executed as the killer player

# Reset score
scoreboard players set @s fb.kill_p 0

# Debug log
execute if data storage fb:config {debug: 1b} run tellraw @a [{"text": "[FB DEBUG] trigger_kill_player for ", "color": "gray"}, {"selector": "@s", "color": "white"}]

# Execute callbacks
function fb:event/run_callbacks {event: "onKillPlayer"}
