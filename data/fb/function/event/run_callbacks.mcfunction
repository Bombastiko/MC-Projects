# FuseBox Event System - Run Callbacks Dispatcher
# Executed as player (@s)

# 1. Extract player's mainhand and offhand items into fb:tmp player_items
data modify storage fb:tmp player_items set value {mainhand: {id: "minecraft:air", custom_data: {}}, offhand: {id: "minecraft:air", custom_data: {}}}

data modify storage fb:tmp player_items.mainhand.id set from entity @s SelectedItem.id
data modify storage fb:tmp player_items.mainhand.custom_data set from entity @s SelectedItem.components."minecraft:custom_data"
execute unless data storage fb:tmp player_items.mainhand.custom_data run data modify storage fb:tmp player_items.mainhand.custom_data set from entity @s SelectedItem.components.custom_data
execute unless data storage fb:tmp player_items.mainhand.custom_data run data modify storage fb:tmp player_items.mainhand.custom_data set value {}

data modify storage fb:tmp player_items.offhand.id set from entity @s Inventory[{Slot:-106b}].id
data modify storage fb:tmp player_items.offhand.custom_data set from entity @s Inventory[{Slot:-106b}].components."minecraft:custom_data"
execute unless data storage fb:tmp player_items.offhand.custom_data run data modify storage fb:tmp player_items.offhand.custom_data set from entity @s Inventory[{Slot:-106b}].components.custom_data
execute unless data storage fb:tmp player_items.offhand.custom_data run data modify storage fb:tmp player_items.offhand.custom_data set value {}

# 2. Populate fallback legacy event_context.item & item_cd
data modify storage fb:tmp event_context.item set from storage fb:tmp player_items.mainhand
execute if data storage fb:tmp player_items.mainhand{id:"minecraft:air"} run data modify storage fb:tmp event_context.item set from storage fb:tmp player_items.offhand
data modify storage fb:tmp item_cd set from storage fb:tmp player_items.mainhand.custom_data
execute if data storage fb:tmp player_items.mainhand{id:"minecraft:air"} run data modify storage fb:tmp item_cd set from storage fb:tmp player_items.offhand.custom_data
data modify storage fb:tmp event_context.item_cd set from storage fb:tmp item_cd

# 3. Special handling: add player to online list on onJoin
execute if data storage fb:tmp event_context{name:"onJoin"} run function fb:event/add_online_player

# 4. Diagnostic Step 2 Output for RightClick ONLY
execute if data storage fb:config {debug:{event:1b}} if data storage fb:tmp event_context{name:"onRightClick"} run tellraw @a ["", {"text": "[FB RightClick Step 2] ", "color": "gold", "bold": true}, {"text": "Extracted held item -> Mainhand: ", "color": "yellow"}, {"nbt": "player_items.mainhand.id", "storage": "fb:tmp", "color": "aqua"}, {"text": " | Offhand: ", "color": "yellow"}, {"nbt": "player_items.offhand.id", "storage": "fb:tmp", "color": "aqua"}]

# 5. Copy registered callbacks array from fb:events into event_context.list
data remove storage fb:tmp event_context.list
execute if data storage fb:tmp event_context{name:"onRightClick"} run data modify storage fb:tmp event_context.list set from storage fb:events onRightClick
execute if data storage fb:tmp event_context{name:"onHoldItem"} run data modify storage fb:tmp event_context.list set from storage fb:events onHoldItem
execute if data storage fb:tmp event_context{name:"onJoin"} run data modify storage fb:tmp event_context.list set from storage fb:events onJoin
execute if data storage fb:tmp event_context{name:"onDeath"} run data modify storage fb:tmp event_context.list set from storage fb:events onDeath
execute if data storage fb:tmp event_context{name:"onLeave"} run data modify storage fb:tmp event_context.list set from storage fb:events onLeave
execute if data storage fb:tmp event_context{name:"onKillPlayer"} run data modify storage fb:tmp event_context.list set from storage fb:events onKillPlayer
execute if data storage fb:tmp event_context{name:"onKilledByPlayer"} run data modify storage fb:tmp event_context.list set from storage fb:events onKilledByPlayer
execute if data storage fb:tmp event_context{name:"onDamage"} run data modify storage fb:tmp event_context.list set from storage fb:events onDamage
execute if data storage fb:tmp event_context{name:"onEntityKill"} run data modify storage fb:tmp event_context.list set from storage fb:events onEntityKill

# 6. Diagnostic Warning if no callbacks exist in storage for RightClick ONLY
execute unless data storage fb:tmp event_context.list[0] if data storage fb:config {debug:{event:1b}} if data storage fb:tmp event_context{name:"onRightClick"} run tellraw @a ["", {"text": "  [FB RightClick Warning] ", "color": "red", "bold": true}, {"text": "No callbacks registered for event 'onRightClick' in fb:events!", "color": "yellow"}]

# 7. Start iteration if callbacks exist in list
execute if data storage fb:tmp event_context.list[0] run function fb:event/loop_callbacks with storage fb:tmp event_context
