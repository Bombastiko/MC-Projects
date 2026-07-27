# FuseBox Event System - Unregister Item Function Callback
# Arguments: event, fn, item_id, custom_data

$data remove storage fb:events $(event)[{fn: "$(fn)"}]

$execute if data storage fb:config {debug:{event:1b, event_show_register:1b}} run tellraw @a ["", {"text": "[FuseBox Debug] ", "color": "yellow", "bold": true}, {"text": "Unregistered item function '", "color": "red"}, {"text": "$(fn)", "color": "white"}, {"text": "' from event '", "color": "red"}, {"text": "$(event)", "color": "white"}, {"text": "'", "color": "gray"}]
