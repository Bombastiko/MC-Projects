# FuseBox Event System - Unregister Item Command Callback
# Arguments: event, cmd, item_id, custom_data

$data remove storage fb:events $(event)[{fn: "$(cmd)"}]

# Clean up empty event array
$execute unless data storage fb:events $(event)[0] run data remove storage fb:events $(event)

$execute if data storage fb:config {debug:{event:1b, event_show_register:1b}} run tellraw @a ["", {"text": "[FuseBox Debug] ", "color": "yellow", "bold": true}, {"text": "Unregistered item command '", "color": "red"}, {"text": "$(cmd)", "color": "white"}, {"text": "' from event '", "color": "red"}, {"text": "$(event)", "color": "white"}, {"text": "'", "color": "gray"}]
