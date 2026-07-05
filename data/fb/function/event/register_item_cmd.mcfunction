# Register a direct command callback for item events with filters and cooldown
# Arguments: event, cmd, item_id, custom_data, cooldown

# Ensure the specific event list exists in storage
$execute unless data storage fb:events $(event) run data modify storage fb:events $(event) set value []

# Prevent duplicate registration
$data remove storage fb:events $(event)[{fn: "$(cmd)"}]

# Append callback to the list with item filters and cooldown (ticks)
$data modify storage fb:events $(event) append value {fn: "$(cmd)", type: "command", item_id: "$(item_id)", custom_data: $(custom_data), cooldown: $(cooldown)}
