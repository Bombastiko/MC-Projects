# Trigger onRightClick callbacks
# Executed as the clicking player

# Reset scoreboard counts
scoreboard players set @s fb.rc_stick 0
scoreboard players set @s fb.rc_fungus 0

# Debug log
execute if data storage fb:config {debug:{event:1b}} run tellraw @a [{"text": "[FB DEBUG] trigger_right_click for ", "color": "gray"}, {"selector": "@s", "color": "white"}]

# Execute callbacks
function fb:event/run_callbacks {event: "onRightClick"}
