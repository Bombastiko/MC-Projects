# Register a function callback for standard events
# Arguments: event, fn

# Ensure the specific event list exists in storage
$execute unless data storage fb:events $(event) run data modify storage fb:events $(event) set value []

# Prevent duplicate registration
$data remove storage fb:events $(event)[{fn: "$(fn)"}]

# Append callback to the list
$data modify storage fb:events $(event) append value {fn: "$(fn)", type: "function"}

# Feedback broadcast
$tellraw @a ["", {"text": "[FuseBox] ", "color": "yellow", "bold": true}, {"text": "Registered function '", "color": "green"}, {"text": "$(fn)", "color": "white"}, {"text": "' for event '", "color": "green"}, {"text": "$(event)", "color": "white"}, {"text": "'", "color": "green"}]
