# Run callbacks for offline events (e.g. onLeave)
# Arguments: event, player

# Setup event context with player name
data modify storage fb:tmp event_context set value {player: ""}
$data modify storage fb:tmp event_context.player set value "$(player)"

# Copy list of callbacks for this event
$data modify storage fb:tmp event_context.list set from storage fb:events $(event)

# If callbacks exist, loop through them
execute if data storage fb:tmp event_context.list[0] run function fb:event/loop_callbacks with storage fb:tmp event_context
