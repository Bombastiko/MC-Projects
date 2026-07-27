# Register a direct command callback for standard events
# Arguments: event, cmd

# Ensure the specific event list exists in storage
$execute unless data storage fb:events $(event) run data modify storage fb:events $(event) set value []

# Prevent duplicate registration
$data remove storage fb:events $(event)[{fn: "$(cmd)"}]

# Append callback to the list
$data modify storage fb:events $(event) append value {fn: "$(cmd)", type: "command"}

# Feedback broadcast
$tellraw @a ["", {"text": "[FuseBox] ", "color": "yellow", "bold": true}, {"text": "Registered command for event '", "color": "green"}, {"text": "$(event)", "color": "white"}, {"text": "'", "color": "green"}]
