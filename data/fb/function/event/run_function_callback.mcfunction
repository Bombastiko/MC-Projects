# FuseBox Event System - Execute Target Function Callback Macro
# Macro Arguments: fn, player, event
# Executed as player (@s)

$execute if data storage fb:config {debug:{event:1b}} run tellraw @a ["", {"text": "[FuseBox Debug] ", "color": "gold", "bold": true}, {"text": "Executing function '", "color": "green"}, {"text": "$(fn)", "color": "white", "bold": true}, {"text": "' for player ", "color": "green"}, {"text": "$(player)", "color": "white"}]

# Execute target function passing current_callback storage parameters (including player)
$function $(fn) with storage fb:tmp current_callback
