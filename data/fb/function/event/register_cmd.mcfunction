# FuseBox Event System - Register Standard Command Callback
# Arguments: event, cmd

# 1. Ensure target event array exists in fb:events
$execute unless data storage fb:events $(event) run data modify storage fb:events $(event) set value []

# 2. Remove any previous callback matching the same command
$data remove storage fb:events $(event)[{fn: "$(cmd)"}]

# 3. Construct clean callback compound
data modify storage fb:tmp cb_entry set value {fn: "", type: "command", item_id: "", custom_data: {}}
$data modify storage fb:tmp cb_entry.fn set value "$(cmd)"

# 4. Append to event callback registry
data modify storage fb:events $(event) append from storage fb:tmp cb_entry

# 5. Visual debug feedback (controlled by debug toggles)
$execute if data storage fb:config {debug:{event:1b, event_show_register:1b}} run tellraw @a ["", {"text": "[FuseBox Debug] ", "color": "yellow", "bold": true}, {"text": "Registered command '", "color": "gold"}, {"text": "$(cmd)", "color": "white"}, {"text": "' for event '", "color": "gold"}, {"text": "$(event)", "color": "white"}, {"text": "'", "color": "gray"}]
