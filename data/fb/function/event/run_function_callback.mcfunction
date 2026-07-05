# Run function callback macro
# Arguments: fn

# Debug log
$execute if data storage fb:config {debug:{event:1b}} run tellraw @a [{"text": "[FB DEBUG] run_function_callback: calling function ", "color": "gray"}, {"text": "$(fn)", "color": "white"}]

# Run macro function
$function $(fn) with storage fb:tmp current_callback
