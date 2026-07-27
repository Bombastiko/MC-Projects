# Run function callback macro
# Arguments: fn

# Debug log (ONLY IF master debug is ON and dbg_allow is 1)
$execute if data storage fb:config {debug:{event:1b}} if data storage fb:tmp dbg_allow{val:1b} run tellraw @a ["", {"text": "[FB Event Fired] ", "color": "green", "bold": true}, {"text": "Executing function '", "color": "gray"}, {"text": "$(fn)", "color": "gold"}, {"text": "' for player ", "color": "gray"}, {"selector": "@s", "color": "white"}]

# Run macro function
$function $(fn)
