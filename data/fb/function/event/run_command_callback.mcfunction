# FuseBox Event System - Execute Target Command Callback Macro
# Macro Arguments: fn, player, event
# Executed as player (@s)

$execute if data storage fb:config {debug:{event:1b}} run tellraw @a ["", {"text": "[FuseBox Debug] ", "color": "gold", "bold": true}, {"text": "Executing command '", "color": "green"}, {"text": "$(fn)", "color": "white", "bold": true}, {"text": "' for player ", "color": "green"}, {"text": "$(player)", "color": "white"}]

# Run direct command string as a macro line
$$(fn)
