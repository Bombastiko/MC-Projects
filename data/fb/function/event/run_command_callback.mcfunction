# FuseBox Event System - Execute Target Command Callback Macro
# Arguments: fn
# Executed as player (@s)

# 1. Live debug log when callback actually fires
$execute if data storage fb:config {debug:{event:1b}} if data storage fb:tmp dbg_allow{val:1b} run tellraw @a ["", {"text": "[FB Event Fired] ", "color": "green", "bold": true}, {"text": "Executing command '", "color": "gray"}, {"text": "$(fn)", "color": "gold"}, {"text": "' for player ", "color": "gray"}, {"selector": "@s", "color": "white"}]

# 2. Run raw command string line as macro
$$(fn)
