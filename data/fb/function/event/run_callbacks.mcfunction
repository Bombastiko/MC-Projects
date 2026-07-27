# FuseBox Event System - Run Callbacks Dispatcher
# Arguments: event
# Executed as player (@s)

# 1. Capture player's held item (Mainhand SelectedItem or Offhand Slot -106b) into fb:tmp event_context.item
data modify storage fb:tmp event_context.item set value {}
data modify storage fb:tmp event_context.item set from entity @s SelectedItem
execute unless data storage fb:tmp event_context.item.id run data modify storage fb:tmp event_context.item set from entity @s Inventory[{Slot:-106b}]
execute unless data storage fb:tmp event_context.item.id run data modify storage fb:tmp event_context.item set value {id: "minecraft:air", count: 0b}

# 2. Extract live custom_data component compound into fb:tmp item_cd & fb:tmp event_context.item_cd
data remove storage fb:tmp item_cd
data remove storage fb:tmp item_components
data modify storage fb:tmp item_components set from storage fb:tmp event_context.item.components
data modify storage fb:tmp item_cd set from storage fb:tmp item_components."minecraft:custom_data"
execute unless data storage fb:tmp item_cd run data modify storage fb:tmp item_cd set from storage fb:tmp item_components.custom_data
execute unless data storage fb:tmp item_cd run data modify storage fb:tmp item_cd set from storage fb:tmp event_context.item.tag
execute unless data storage fb:tmp item_cd run data modify storage fb:tmp item_cd set value {}
data modify storage fb:tmp event_context.item_cd set from storage fb:tmp item_cd

# 3. Special handling: add player to online list on onJoin
data modify storage fb:tmp event_check set value {name: ""}
$data modify storage fb:tmp event_check.name set value "$(event)"
execute if data storage fb:tmp event_check{name:"onJoin"} run function fb:event/add_online_player

# 4. Copy registered callbacks array for this event into event_context.list
data remove storage fb:tmp event_context.list
$data modify storage fb:tmp event_context.list set from storage fb:events $(event)

# 5. Diagnostic Step 2 Output for RightClick ONLY
$execute if data storage fb:config {debug:{event:1b}} if data storage fb:tmp event_check{name:"onRightClick"} run tellraw @a ["", {"text": "[FB RightClick Step 2] ", "color": "gold", "bold": true}, {"text": "Extracted held item -> ID: ", "color": "yellow"}, {"nbt": "event_context.item.id", "storage": "fb:tmp", "color": "aqua"}, {"text": " | Custom Data: ", "color": "yellow"}, {"nbt": "item_cd", "storage": "fb:tmp", "color": "light_purple"}]

# 6. Diagnostic Warning if no callbacks exist in storage for RightClick ONLY
$execute unless data storage fb:tmp event_context.list[0] if data storage fb:config {debug:{event:1b}} if data storage fb:tmp event_check{name:"onRightClick"} run tellraw @a ["", {"text": "  [FB RightClick Warning] ", "color": "red", "bold": true}, {"text": "No callbacks registered for event 'onRightClick' in fb:events! Use /function fb:event/register_item_cmd to register one.", "color": "yellow"}]

# 7. Start iteration if callbacks exist in list
execute if data storage fb:tmp event_context.list[0] run function fb:event/loop_callbacks with storage fb:tmp event_context
