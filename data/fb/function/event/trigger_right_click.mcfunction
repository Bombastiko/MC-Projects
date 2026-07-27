# FuseBox Event System - Trigger onRightClick Event Handler
# Executed as clicking player (@s)

# 1. Reset scoreboard counts immediately
scoreboard players set @s fb.rc_stick 0
scoreboard players set @s fb.rc_fungus 0

# 2. Diagnostic Step 1 Output for RightClick (if debug enabled)
execute if data storage fb:config {debug:{event:1b, event_rc:1b}} unless data storage fb:config {debug:{event_only_success:1b}} run tellraw @a ["", {"text": "[FuseBox Debug] ", "color": "yellow", "bold": true}, {"text": "Right-click detected for player ", "color": "gold"}, {"selector": "@s", "color": "white"}]

# 3. Execute callbacks for onRightClick
data modify storage fb:tmp event_context set value {name: "onRightClick"}
function fb:event/run_callbacks