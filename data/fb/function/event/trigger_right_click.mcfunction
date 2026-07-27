# Trigger onRightClick callbacks
# Executed as the clicking player

# Reset scoreboard counts
scoreboard players set @s fb.rc_stick 0
scoreboard players set @s fb.rc_fungus 0

# Step 1 Diagnostic Output for RightClick ONLY
execute if data storage fb:config {debug:{event:1b}} run tellraw @a ["", {"text": "[FB RightClick Step 1] ", "color": "gold", "bold": true}, {"text": "Right-click detected for player ", "color": "yellow"}, {"selector": "@s", "color": "white"}, {"text": ". Resetted click scoreboards.", "color": "gray"}]

# Execute callbacks for onRightClick
data modify storage fb:tmp event_context set value {name: "onRightClick"}
function fb:event/run_callbacks
