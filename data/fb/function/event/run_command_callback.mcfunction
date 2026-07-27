# FuseBox Event System - Execute Target Command Callback Macro
# Arguments: fn
# Executed as player (@s)

# Step 6 Diagnostic Output for RightClick Execution
$execute if data storage fb:config {debug:{event:1b}} if data storage fb:tmp event_check{name:"onRightClick"} run tellraw @a ["", {"text": "[FB RightClick Step 6] ", "color": "gold", "bold": true}, {"text": "ALL FILTERS MATCHED! EXECUTING COMMAND '", "color": "green", "bold": true}, {"text": "$(fn)", "color": "white", "bold": true}, {"text": "' FOR PLAYER ", "color": "green"}, {"selector": "@s", "color": "white"}]

# Run direct command string as a macro line
$$(fn)
