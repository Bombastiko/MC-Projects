# FuseBox Event System - Execute Target Command Callback Macro
# Macro Arguments: fn
# Executed as player (@s)

$execute if data storage fb:config {debug:{event:1b}} run tellraw @a ["", {"text": "[FuseBox Debug] ", "color": "gold", "bold": true}, {"text": "Executing command '", "color": "green"}, {"text": "$(fn)", "color": "white", "bold": true}, {"text": "' for player ", "color": "green"}, {"selector": "@s", "color": "white"}]

$$(fn)
