# Run callback iteration
# Arguments: event
# Executed as the event player

# Resolve player's username string
function fb:event/resolve_name

# Setup event context with player name and currently held item NBT
data modify storage fb:tmp event_context.item set value {}
data modify storage fb:tmp event_context.item set from entity @s SelectedItem

# If this is onJoin, add player to online list
data modify storage fb:tmp event_check set value {name: ""}
$data modify storage fb:tmp event_check.name set value "$(event)"
execute if data storage fb:tmp event_check{name:"onJoin"} run function fb:event/add_online_player

# Copy the list of callbacks for this event
$data modify storage fb:tmp event_context.list set from storage fb:events $(event)

# Debug log
$execute if data storage fb:config {debug:{event:1b}} run tellraw @a [{"text": "[FB DEBUG] run_callbacks for event: ", "color": "gray"}, {"text": "$(event)", "color": "white"}, {"text": ", player: ", "color": "gray"}, {"nbt": "event_context.player", "storage": "fb:tmp", "color": "white"}, {"text": ", callbacks list: ", "color": "gray"}, {"nbt": "event_context.list", "storage": "fb:tmp"}]

# If callbacks are registered, loop through them
execute if data storage fb:tmp event_context.list[0] run function fb:event/loop_callbacks with storage fb:tmp event_context
