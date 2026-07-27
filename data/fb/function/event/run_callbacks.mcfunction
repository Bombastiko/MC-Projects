# Run callback iteration
# Arguments: event
# Executed as the event player

# Setup event context with currently held item NBT (mainhand or offhand)
data modify storage fb:tmp event_context.item set value {}
data modify storage fb:tmp event_context.item set from entity @s SelectedItem
execute unless data storage fb:tmp event_context.item.id run data modify storage fb:tmp event_context.item set from entity @s Inventory[{Slot:-106b}]

# Extract live custom_data compound for debug display and matching
data remove storage fb:tmp live_cd
data modify storage fb:tmp live_cd set from storage fb:tmp event_context.item.components."minecraft:custom_data"
execute unless data storage fb:tmp live_cd run data modify storage fb:tmp live_cd set from storage fb:tmp event_context.item.components.custom_data
execute unless data storage fb:tmp live_cd run data modify storage fb:tmp live_cd set from storage fb:tmp event_context.item.tag

# If this is onJoin, add player to online list
data modify storage fb:tmp event_check set value {name: ""}
$data modify storage fb:tmp event_check.name set value "$(event)"
execute if data storage fb:tmp event_check{name:"onJoin"} run function fb:event/add_online_player

# Copy the list of callbacks for this event
$data modify storage fb:tmp event_context.list set from storage fb:events $(event)

# Check event type specific debug mutes (e.g. onHoldItem / onRightClick)
data modify storage fb:tmp dbg_allow set value {val: 1b}
execute if data storage fb:tmp event_check{name:"onHoldItem"} if data storage fb:config {debug:{event_hold:0b}} run data modify storage fb:tmp dbg_allow.val set value 0b
execute if data storage fb:tmp event_check{name:"onRightClick"} if data storage fb:config {debug:{event_rc:0b}} run data modify storage fb:tmp dbg_allow.val set value 0b

# Detailed Live Event Debug Log (using exact live storage data)
$execute if data storage fb:config {debug:{event:1b}} if data storage fb:tmp dbg_allow{val:1b} unless data storage fb:config {debug:{event_only_success:1b}} run tellraw @a ["", {"text": "[FB Live Debug: ", "color": "yellow", "bold": true}, {"text": "$(event)", "color": "gold", "bold": true}, {"text": "] ", "color": "yellow", "bold": true}, {"text": "Player: ", "color": "gray"}, {"selector": "@s", "color": "white"}, {"text": " | Item: ", "color": "gray"}, {"nbt": "event_context.item.id", "storage": "fb:tmp", "color": "aqua"}, {"text": " | Live NBT (wand_type): ", "color": "gray"}, {"nbt": "live_cd", "storage": "fb:tmp", "color": "light_purple"}]

# If callbacks are registered, loop through them
execute if data storage fb:tmp event_context.list[0] run function fb:event/loop_callbacks with storage fb:tmp event_context
