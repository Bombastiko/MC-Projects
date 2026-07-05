# Toggle global debug flag
execute if data storage fb:config {debug:{global:1b}} run data modify storage fb:config debug.global set value 0b
execute unless data storage fb:config {debug:{global:1b}} run data modify storage fb:config debug.global set value 1b

# Feedback
execute if data storage fb:config {debug:{global:1b}} run tellraw @s ["", {"text": "Global Debug Mode: ", "color": "gray"}, {"text": "ENABLED", "color": "green", "bold": true}]
execute unless data storage fb:config {debug:{global:1b}} run tellraw @s ["", {"text": "Global Debug Mode: ", "color": "gray"}, {"text": "DISABLED", "color": "red", "bold": true}]

# Show menu
function fb:debug/menu
