# Run direct command callback macro
# Arguments: fn

# Debug log
$execute if data storage fb:config {debug:{event:1b}} run tellraw @a [{"text": "[FB DEBUG] run_command_callback: executing command: ", "color": "gray"}, {"text": "$(fn)", "color": "white"}]

# Run direct command string as a macro line
$$(fn)
