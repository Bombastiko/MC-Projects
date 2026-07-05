# Toggle countdown debug flag

# Copy current state to temporary storage
data modify storage fb:tmp debug_toggle set from storage fb:config debug.cd

# Toggle based on temporary state
execute if data storage fb:tmp {debug_toggle: 1b} run data modify storage fb:config debug.cd set value 0b
execute unless data storage fb:tmp {debug_toggle: 1b} run data modify storage fb:config debug.cd set value 1b

# Feedback
execute if data storage fb:config {debug:{cd:1b}} run tellraw @s ["", {"text": "Countdown Debug Mode: ", "color": "gray"}, {"text": "ENABLED", "color": "green", "bold": true}]
execute unless data storage fb:config {debug:{cd:1b}} run tellraw @s ["", {"text": "Countdown Debug Mode: ", "color": "gray"}, {"text": "DISABLED", "color": "red", "bold": true}]

# Show menu
function fb:debug/menu
