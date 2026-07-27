# FuseBox Event System - Execute Target Function Callback Macro
# Macro Arguments: fn
# Executed as player (@s)

$execute if data storage fb:config {debug:{event:1b}} run tellraw @a ["", {"text": "[FuseBox Debug] ", "color": "gold", "bold": true}, {"text": "Executing function '", "color": "green"}, {"text": "$(fn)", "color": "white", "bold": true}, {"text": "' for player ", "color": "green"}, {"selector": "@s", "color": "white"}]

$function $(fn)
