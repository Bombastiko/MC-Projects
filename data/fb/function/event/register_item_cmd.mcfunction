# FuseBox Event System - Register Item Command Callback
# Macro Arguments: event, cmd, item_id, custom_data
# Executed as server / caller

# 1. Ensure target event array exists in fb:events
$execute unless data storage fb:events $(event) run data modify storage fb:events $(event) set value []

# 2. Remove any previous callback matching the same command string
$data remove storage fb:events $(event)[{fn: "$(cmd)"}]

# 3. Construct clean callback compound
data modify storage fb:tmp cb_entry set value {fn: "", type: "command", item_id: "", custom_data: {}, has_item_filter: 1b}
$data modify storage fb:tmp cb_entry.fn set value "$(cmd)"
$data modify storage fb:tmp cb_entry.item_id set value "$(item_id)"
$data modify storage fb:tmp cb_entry.custom_data set value $(custom_data)

# 4. Calculate item_id filter flag (0b if blank or wildcard)
execute if data storage fb:tmp {cb_entry: {item_id: ""}} run data modify storage fb:tmp cb_entry.has_item_filter set value 0b
execute if data storage fb:tmp {cb_entry: {item_id: "*"}} run data modify storage fb:tmp cb_entry.has_item_filter set value 0b
execute if data storage fb:tmp {cb_entry: {item_id: "minecraft:*"}} run data modify storage fb:tmp cb_entry.has_item_filter set value 0b

# 5. Append to event callback registry
$data modify storage fb:events $(event) append from storage fb:tmp cb_entry

# 6. Visual debug feedback (controlled by debug toggles)
$execute if data storage fb:config {debug:{event:1b, event_show_register:1b}} run tellraw @a ["", {"text": "[FuseBox Debug] ", "color": "yellow", "bold": true}, {"text": "Registered item command '", "color": "gold"}, {"text": "$(cmd)", "color": "white"}, {"text": "' for event '", "color": "gold"}, {"text": "$(event)", "color": "white"}, {"text": "' [Item: ", "color": "gray"}, {"text": "$(item_id)", "color": "aqua"}, {"text": ", Custom Data: ", "color": "gray"}, {"nbt": "cb_entry.custom_data", "storage": "fb:tmp", "color": "light_purple"}, {"text": "]", "color": "gray"}]
