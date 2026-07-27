# FuseBox Event System - Execute Target Function Callback Macro
# Arguments: fn
# Executed as player (@s)

# Step 6 Diagnostic Output
$execute if data storage fb:config {debug:{event:1b}} run tellraw @a ["", {"text": "[FB Event Step 6] ", "color": "gold", "bold": true}, {"text": "ALL FILTERS MATCHED! EXECUTING FUNCTION '", "color": "green", "bold": true}, {"text": "$(fn)", "color": "white", "bold": true}, {"text": "' FOR PLAYER ", "color": "green"}, {"selector": "@s", "color": "white"}]

# Run macro function
$function $(fn)
