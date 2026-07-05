# Toggle event debug flag

# Copy current state to temporary storage
data modify storage fb:tmp debug_toggle set from storage fb:config debug.event

# Toggle based on temporary state
execute if data storage fb:tmp {debug_toggle: 1b} run data modify storage fb:config debug.event set value 0b
execute unless data storage fb:tmp {debug_toggle: 1b} run data modify storage fb:config debug.event set value 1b

# Feedback
execute if data storage fb:config {debug:{event:1b}} run tellraw @s ["", {"text": "Event Debug Mode: ", "color": "gray"}, {"text": "ENABLED", "color": "green", "bold": true}]
execute unless data storage fb:config {debug:{event:1b}} run tellraw @s ["", {"text": "Event Debug Mode: ", "color": "gray"}, {"text": "DISABLED", "color": "red", "bold": true}]

# Show menu
function fb:debug/menu
