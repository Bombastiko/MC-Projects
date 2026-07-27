# Register a function callback for item events with filters
# Arguments: event, fn, item_id, custom_data

# Ensure the specific event list exists in storage
$execute unless data storage fb:events $(event) run data modify storage fb:events $(event) set value []

# Prevent duplicate registration
$data remove storage fb:events $(event)[{fn: "$(fn)"}]

# Build callback compound with guaranteed custom_data structure
data modify storage fb:tmp cb_entry set value {fn: "", type: "function", item_id: "", custom_data: {}}
$data modify storage fb:tmp cb_entry.fn set value "$(fn)"
$data modify storage fb:tmp cb_entry.item_id set value "$(item_id)"
$data modify storage fb:tmp cb_entry.custom_data set value $(custom_data)

# Append callback to the list
data modify storage fb:events $(event) append from storage fb:tmp cb_entry

# Feedback broadcast (Debug toggle check)
$execute if data storage fb:config {debug:{event:1b}} run tellraw @a ["", {"text": "[FuseBox] ", "color": "yellow", "bold": true}, {"text": "Registered item function '", "color": "green"}, {"text": "$(fn)", "color": "white"}, {"text": "' for event '", "color": "green"}, {"text": "$(event)", "color": "white"}, {"text": "' (Item: $(item_id))", "color": "green"}]
