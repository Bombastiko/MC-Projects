# Register an event callback
# Arguments: event, fn

# Ensure the event list exists in storage
$execute unless data storage fb:events $(event) run data modify storage fb:events $(event) set value []

# Prevent duplicate registration
$data remove storage fb:events $(event)[{fn: "$(fn)"}]

# Append callback to the list
$data modify storage fb:events $(event) append value {fn: "$(fn)"}
