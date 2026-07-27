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

# 4. Update in-world Live Debug Hologram Board if present
execute if entity @e[tag=fb.debug_board,limit=1] run data modify entity @e[tag=fb.debug_board,limit=1] text set value '["",{"text":"=== FUSEBOX LIVE DEBUG BOARD ===\n","color":"yellow","bold":true},{"text":"Event: ","color":"gray"},{"text":"$(event)","color":"gold","bold":true},{"text":" | Player: ","color":"gray"},{"selector":"@s","color":"white"},{"text":"\nHeld Item: ","color":"gray"},{"nbt":"event_context.item.id","storage":"fb:tmp","color":"aqua"},{"text":"\nCustom Data: ","color":"gray"},{"nbt":"item_cd","storage":"fb:tmp","color":"light_purple"}]'

# 5. Copy registered callbacks array for this event
$data modify storage fb:tmp event_context.list set from storage fb:events $(event)

# 6. Check event-specific debug mutes (e.g. onHoldItem / onRightClick)
data modify storage fb:tmp dbg_allow set value {val: 1b}
execute if data storage fb:tmp event_check{name:"onHoldItem"} if data storage fb:config {debug:{event_hold:0b}} run data modify storage fb:tmp dbg_allow.val set value 0b
execute if data storage fb:tmp event_check{name:"onRightClick"} if data storage fb:config {debug:{event_rc:0b}} run data modify storage fb:tmp dbg_allow.val set value 0b

# 7. Live debug logging with clickable Copy-to-Clipboard button
$execute if data storage fb:config {debug:{event:1b}} if data storage fb:tmp dbg_allow{val:1b} unless data storage fb:config {debug:{event_only_success:1b}} run tellraw @a ["", {"text": "[FB Live Debug: ", "color": "yellow", "bold": true}, {"text": "$(event)", "color": "gold", "bold": true}, {"text": "] ", "color": "yellow", "bold": true}, {"text": "Player: ", "color": "gray"}, {"selector": "@s", "color": "white"}, {"text": " | Item: ", "color": "gray"}, {"nbt": "event_context.item.id", "storage": "fb:tmp", "color": "aqua"}, {"text": " | Custom Data: ", "color": "gray"}, {"nbt": "item_cd", "storage": "fb:tmp", "color": "light_purple"}]

# 8. Start iteration if callbacks exist in list
execute if data storage fb:tmp event_context.list[0] run function fb:event/loop_callbacks with storage fb:tmp event_context
