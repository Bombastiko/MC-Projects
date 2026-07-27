# Register a direct command callback for item events with filters
# Arguments: event, cmd, item_id, custom_data

# Ensure the specific event list exists in storage
$execute unless data storage fb:events $(event) run data modify storage fb:events $(event) set value []

# Prevent duplicate registration
$data remove storage fb:events $(event)[{fn: "$(cmd)"}]

# Append callback to the list with item filters
$data modify storage fb:events $(event) append value {fn: "$(cmd)", type: "command", item_id: "$(item_id)", custom_data: $(custom_data)}

# Feedback broadcast
$tellraw @a ["", {"text": "[FuseBox] ", "color": "yellow", "bold": true}, {"text": "Registered item command for event '", "color": "green"}, {"text": "$(event)", "color": "white"}, {"text": "' (Item: $(item_id))", "color": "green"}]
