# Run function callback macro
# Arguments: fn

# Debug log
$execute if data storage fb:config {debug:{event:1b}} run tellraw @a ["", {"text": "[FB Callback Execute] ", "color": "green", "bold": true}, {"text": "Executing function: ", "color": "gray"}, {"text": "$(fn)", "color": "gold"}]

# Run macro function
$function $(fn)
