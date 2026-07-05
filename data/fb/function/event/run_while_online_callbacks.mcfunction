# Execute registered callbacks for whileOnline event
# Arguments: player

# Setup event context with player name and held item
data modify storage fb:tmp event_context.player set value ""
$data modify storage fb:tmp event_context.player set value "$(player)"
data modify storage fb:tmp event_context.item set value {}
data modify storage fb:tmp event_context.item set from entity @s SelectedItem

# Copy the list of callbacks for whileOnline
data modify storage fb:tmp event_context.list set from storage fb:events whileOnline

# Loop through callbacks
execute if data storage fb:tmp event_context.list[0] run function fb:event/loop_callbacks with storage fb:tmp event_context
