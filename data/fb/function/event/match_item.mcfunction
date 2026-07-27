# FuseBox Event System - Match Item ID Filter
# Arguments: item_id, custom_data
# Executed as player (@s)

# 1. Reset match flag to 0b (false)
data modify storage fb:tmp event_match set value {val: 0b}

# 2. Modern 1.20.5+ / 1.21+ Item Predicate Check for item_id (Mainhand & Offhand)
$execute if items entity @s weapon.mainhand $(item_id) run data modify storage fb:tmp event_match.val set value 1b
$execute if items entity @s weapon.mainhand minecraft:$(item_id) run data modify storage fb:tmp event_match.val set value 1b
$execute if items entity @s weapon.offhand $(item_id) run data modify storage fb:tmp event_match.val set value 1b
$execute if items entity @s weapon.offhand minecraft:$(item_id) run data modify storage fb:tmp event_match.val set value 1b

# 3. Storage & Entity SelectedItem Fallbacks
$execute if data storage fb:tmp {event_context: {item: {id: "$(item_id)"}}} run data modify storage fb:tmp event_match.val set value 1b
$execute if data storage fb:tmp {event_context: {item: {id: "minecraft:$(item_id)"}}} run data modify storage fb:tmp event_match.val set value 1b
$execute if data entity @s SelectedItem{id:"$(item_id)"} run data modify storage fb:tmp event_match.val set value 1b
$execute if data entity @s SelectedItem{id:"minecraft:$(item_id)"} run data modify storage fb:tmp event_match.val set value 1b
$execute if data entity @s Inventory[{Slot:-106b,id:"$(item_id)"}] run data modify storage fb:tmp event_match.val set value 1b
$execute if data entity @s Inventory[{Slot:-106b,id:"minecraft:$(item_id)"}] run data modify storage fb:tmp event_match.val set value 1b

# 4. Step 4 Diagnostic Output for RightClick ONLY
$execute if data storage fb:config {debug:{event:1b}} if data storage fb:tmp event_check{name:"onRightClick"} if data storage fb:tmp event_match{val:1b} run tellraw @a ["", {"text": "  [FB RightClick Step 4] ", "color": "gold"}, {"text": "Item ID Check: ", "color": "yellow"}, {"text": "MATCH! ", "color": "green", "bold": true}, {"text": "(Required '$(item_id)' == Held '", "color": "gray"}, {"nbt": "event_context.item.id", "storage": "fb:tmp", "color": "aqua"}, {"text": "')", "color": "gray"}]
$execute if data storage fb:config {debug:{event:1b}} if data storage fb:tmp event_check{name:"onRightClick"} if data storage fb:tmp event_match{val:0b} run tellraw @a ["", {"text": "  [FB RightClick Step 4] ", "color": "gold"}, {"text": "Item ID Check: ", "color": "yellow"}, {"text": "MISMATCH! ", "color": "red", "bold": true}, {"text": "(Required '$(item_id)' != Held '", "color": "gray"}, {"nbt": "event_context.item.id", "storage": "fb:tmp", "color": "white"}, {"text": "')", "color": "gray"}]

# 5. Check custom_data if provided and not empty compound {}
$data modify storage fb:tmp check_cd set value $(custom_data)
execute if data storage fb:tmp event_match{val: 1b} unless data storage fb:tmp check_cd{} run function fb:event/match_custom_data with storage fb:tmp current_callback
execute if data storage fb:tmp event_match{val: 1b} if data storage fb:tmp check_cd{} if data storage fb:config {debug:{event:1b}} if data storage fb:tmp event_check{name:"onRightClick"} run tellraw @a ["", {"text": "  [FB RightClick Step 5] ", "color": "gold"}, {"text": "Custom Data Check: ", "color": "yellow"}, {"text": "SKIPPED ", "color": "gray", "bold": true}, {"text": "(No custom_data filter specified on callback)", "color": "dark_gray"}]
