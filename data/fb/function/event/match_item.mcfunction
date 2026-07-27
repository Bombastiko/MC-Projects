# FuseBox Event System - Match Item ID Filter
# Arguments: item_id, custom_data
# Executed as player (@s)

# 1. Reset match flag to 0b (false)
data modify storage fb:tmp event_match set value {val: 0b}

# 2. Check item ID on storage event_context or entity SelectedItem (with/without minecraft: prefix)
$execute if data storage fb:tmp {event_context: {item: {id: "$(item_id)"}}} run data modify storage fb:tmp event_match.val set value 1b
$execute if data storage fb:tmp {event_context: {item: {id: "minecraft:$(item_id)"}}} run data modify storage fb:tmp event_match.val set value 1b
$execute if data entity @s SelectedItem{id:"$(item_id)"} run data modify storage fb:tmp event_match.val set value 1b
$execute if data entity @s SelectedItem{id:"minecraft:$(item_id)"} run data modify storage fb:tmp event_match.val set value 1b
$execute if data entity @s Inventory[{Slot:-106b,id:"$(item_id)"}] run data modify storage fb:tmp event_match.val set value 1b
$execute if data entity @s Inventory[{Slot:-106b,id:"minecraft:$(item_id)"}] run data modify storage fb:tmp event_match.val set value 1b

# 3. Step 4 Diagnostic Output for RightClick Item ID Match
$execute if data storage fb:config {debug:{event:1b}} if data storage fb:tmp event_check{name:"onRightClick"} if data storage fb:tmp event_match{val:1b} run tellraw @a ["", {"text": "  [FB RightClick Step 4] ", "color": "gold"}, {"text": "Item ID Check: ", "color": "yellow"}, {"text": "MATCH! ", "color": "green", "bold": true}, {"text": "(Required '$(item_id)' == Held '", "color": "gray"}, {"nbt": "event_context.item.id", "storage": "fb:tmp", "color": "aqua"}, {"text": "')", "color": "gray"}]
$execute if data storage fb:config {debug:{event:1b}} if data storage fb:tmp event_check{name:"onRightClick"} if data storage fb:tmp event_match{val:0b} run tellraw @a ["", {"text": "  [FB RightClick Step 4] ", "color": "gold"}, {"text": "Item ID Check: ", "color": "yellow"}, {"text": "MISMATCH! ", "color": "red", "bold": true}, {"text": "(Required '$(item_id)' != Held '", "color": "gray"}, {"nbt": "event_context.item.id", "storage": "fb:tmp", "color": "white"}, {"text": "')", "color": "gray"}]

# 4. Check custom_data if provided and not empty compound {}
$data modify storage fb:tmp check_cd set value $(custom_data)
execute if data storage fb:tmp event_match{val: 1b} unless data storage fb:tmp check_cd{} run function fb:event/match_custom_data with storage fb:tmp current_callback
