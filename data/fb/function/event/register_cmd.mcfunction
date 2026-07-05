# Register a direct command callback for standard events
# Arguments: event, cmd

# Ensure the specific event list exists in storage
$execute unless data storage fb:events $(event) run data modify storage fb:events $(event) set value []

# Prevent duplicate registration
$data remove storage fb:events $(event)[{fn: "$(cmd)"}]

# Append callback to the list (storing the command inside the fn field but set type to "command")
$data modify storage fb:events $(event) append value {fn: "$(cmd)", type: "command"}
