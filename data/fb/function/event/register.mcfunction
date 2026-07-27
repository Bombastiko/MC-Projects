# FuseBox Event System - Register Standard Function Callback
# Arguments: event, fn

# 1. Ensure target event array exists in fb:events
$execute unless data storage fb:events $(event) run data modify storage fb:events $(event) set value []

# 2. Remove any previous callback matching the same function
$data remove storage fb:events $(event)[{fn: "$(fn)"}]

# 3. Construct clean callback compound
data modify storage fb:tmp cb_entry set value {fn: "", type: "function", item_id: "", custom_data: {}}
$data modify storage fb:tmp cb_entry.fn set value "$(fn)"

# 4. Append to event callback registry
data modify storage fb:events $(event) append from storage fb:tmp cb_entry

# 5. Visual debug feedback (controlled by debug toggles)
$execute if data storage fb:config {debug:{event:1b, event_show_register:1b}} run tellraw @a ["", {"text": "[FuseBox Debug] ", "color": "yellow", "bold": true}, {"text": "Registered function '", "color": "gold"}, {"text": "$(fn)", "color": "white"}, {"text": "' for event '", "color": "gold"}, {"text": "$(event)", "color": "white"}, {"text": "'", "color": "gray"}]
