# Run callback iteration
# Arguments: event
# Executed as the event player

# Setup event context with currently held item NBT (mainhand or offhand)
data modify storage fb:tmp event_context.item set value {}
data modify storage fb:tmp event_context.item set from entity @s SelectedItem
execute unless data storage fb:tmp event_context.item.id run data modify storage fb:tmp event_context.item set from entity @s Inventory[{Slot:-106b}]

# If this is onJoin, add player to online list
data modify storage fb:tmp event_check set value {name: ""}
$data modify storage fb:tmp event_check.name set value "$(event)"
execute if data storage fb:tmp event_check{name:"onJoin"} run function fb:event/add_online_player

# Copy the list of callbacks for this event
$data modify storage fb:tmp event_context.list set from storage fb:events $(event)

# If callbacks are registered, loop through them
execute if data storage fb:tmp event_context.list[0] run function fb:event/loop_callbacks with storage fb:tmp event_context
