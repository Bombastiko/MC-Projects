# FuseBox Event System - Run Callbacks Dispatcher
# Executed as player (@s)

# 1. Resolve player's username as a string into fb:tmp event_context.player
function fb:event/resolve_name

# 2. Capture player's held items into fb:tmp player_items (Mainhand and Offhand)
data remove storage fb:tmp player_items

# 2a. Mainhand Extraction
data modify storage fb:tmp player_items.mainhand.id set from entity @s SelectedItem.id
execute unless data storage fb:tmp player_items.mainhand.id run data modify storage fb:tmp player_items.mainhand.id set value "minecraft:air"

data remove storage fb:tmp player_items.mainhand.custom_data
data modify storage fb:tmp player_items.mainhand.custom_data set from entity @s SelectedItem.components."minecraft:custom_data"
execute unless data storage fb:tmp player_items.mainhand.custom_data run data modify storage fb:tmp player_items.mainhand.custom_data set from entity @s SelectedItem.components.custom_data
execute unless data storage fb:tmp player_items.mainhand.custom_data run data modify storage fb:tmp player_items.mainhand.custom_data set from entity @s SelectedItem.tag.custom_data
execute unless data storage fb:tmp player_items.mainhand.custom_data run data modify storage fb:tmp player_items.mainhand.custom_data set from entity @s SelectedItem.tag
execute unless data storage fb:tmp player_items.mainhand.custom_data run data modify storage fb:tmp player_items.mainhand.custom_data set value {}

# 2b. Offhand Extraction
data modify storage fb:tmp player_items.offhand.id set from entity @s Inventory[{Slot:-106b}].id
execute unless data storage fb:tmp player_items.offhand.id run data modify storage fb:tmp player_items.offhand.id set value "minecraft:air"

data remove storage fb:tmp player_items.offhand.custom_data
data modify storage fb:tmp player_items.offhand.custom_data set from entity @s Inventory[{Slot:-106b}].components."minecraft:custom_data"
execute unless data storage fb:tmp player_items.offhand.custom_data run data modify storage fb:tmp player_items.offhand.custom_data set from entity @s Inventory[{Slot:-106b}].components.custom_data
execute unless data storage fb:tmp player_items.offhand.custom_data run data modify storage fb:tmp player_items.offhand.custom_data set from entity @s Inventory[{Slot:-106b}].tag.custom_data
execute unless data storage fb:tmp player_items.offhand.custom_data run data modify storage fb:tmp player_items.offhand.custom_data set from entity @s Inventory[{Slot:-106b}].tag
execute unless data storage fb:tmp player_items.offhand.custom_data run data modify storage fb:tmp player_items.offhand.custom_data set value {}

# 3. Special handler: add player to online list on onJoin
execute if data storage fb:tmp event_context{name:"onJoin"} run function fb:event/add_online_player

# 4. Copy registered callbacks array from fb:events into event_context.list
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

# 5. Start iteration if callbacks exist in list
execute if data storage fb:tmp event_context.list[0] run function fb:event/loop_callbacks
