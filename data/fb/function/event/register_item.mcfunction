# FuseBox Event System - Register Item Function Callback
# Macro Arguments: event, fn, item_id, custom_data
# Executed as server / caller

# 1. Ensure target event array exists in fb:events
$execute unless data storage fb:events $(event) run data modify storage fb:events $(event) set value []

# 2. Remove any previous callback matching the same function
$data remove storage fb:events $(event)[{fn: "$(fn)"}]

# 3. Construct clean callback compound
data modify storage fb:tmp cb_entry set value {fn: "", type: "function", item_id: "", custom_data: {}, has_item_filter: 1b, has_cd_filter: 1b}
$data modify storage fb:tmp cb_entry.fn set value "$(fn)"
$data modify storage fb:tmp cb_entry.item_id set value "$(item_id)"
$data modify storage fb:tmp cb_entry.custom_data set value $(custom_data)

# 4. Calculate filter flags (Using valid root NBT compound check syntax)
execute if data storage fb:tmp {cb_entry: {item_id: ""}} run data modify storage fb:tmp cb_entry.has_item_filter set value 0b
execute if data storage fb:tmp {cb_entry: {item_id: "*"}} run data modify storage fb:tmp cb_entry.has_item_filter set value 0b
execute if data storage fb:tmp {cb_entry: {item_id: "minecraft:*"}} run data modify storage fb:tmp cb_entry.has_item_filter set value 0b

execute if data storage fb:tmp {cb_entry: {custom_data: {}}} run data modify storage fb:tmp cb_entry.has_cd_filter set value 0b

# 5. Append to event callback registry
$data modify storage fb:events $(event) append from storage fb:tmp cb_entry

# 6. Visual debug feedback (controlled by debug toggles)
$execute if data storage fb:config {debug:{event:1b, event_show_register:1b}} run tellraw @a ["", {"text": "[FuseBox Debug] ", "color": "yellow", "bold": true}, {"text": "Registered item function '", "color": "gold"}, {"text": "$(fn)", "color": "white"}, {"text": "' for event '", "color": "gold"}, {"text": "$(event)", "color": "white"}, {"text": "' [Item: ", "color": "gray"}, {"text": "$(item_id)", "color": "aqua"}, {"text": ", Custom Data: ", "color": "gray"}, {"nbt": "cb_entry.custom_data", "storage": "fb:tmp", "color": "light_purple"}, {"text": "]", "color": "gray"}]
