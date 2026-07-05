# Run single callback macro
# Arguments: fn, player

# Debug log
$execute if data storage fb:config {debug: 1b} run tellraw @a [{"text": "[FB DEBUG] run_single_callback: calling function ", "color": "gray"}, {"text": "$(fn)", "color": "white"}, {"text": " for player: ", "color": "gray"}, {"text": "$(player)", "color": "white"}]

# Run macro function with storage parameter containing $(player) username
$function $(fn) with storage fb:tmp current_callback
