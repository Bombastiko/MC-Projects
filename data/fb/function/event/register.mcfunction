# Register a function callback for standard events
# Arguments: event, fn

# Ensure the specific event list exists in storage
$execute unless data storage fb:events $(event) run data modify storage fb:events $(event) set value []

# Prevent duplicate registration
$data remove storage fb:events $(event)[{fn: "$(fn)"}]

# Build callback compound with guaranteed structure
data modify storage fb:tmp cb_entry set value {fn: "", type: "function", item_id: "", custom_data: {}}
$data modify storage fb:tmp cb_entry.fn set value "$(fn)"

# Append callback to the list
data modify storage fb:events $(event) append from storage fb:tmp cb_entry

# Feedback broadcast (Debug toggle check)
$execute if data storage fb:config {debug:{event:1b}} run tellraw @a ["", {"text": "[FuseBox] ", "color": "yellow", "bold": true}, {"text": "Registered function '", "color": "green"}, {"text": "$(fn)", "color": "white"}, {"text": "' for event '", "color": "green"}, {"text": "$(event)", "color": "white"}, {"text": "'", "color": "green"}]
