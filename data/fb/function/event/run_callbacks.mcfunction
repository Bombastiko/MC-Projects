# Run callback iteration
# Arguments: event
# Executed as the event player

# Setup event context with player name (falling back to "player" if Profile.Name is missing)
data modify storage fb:tmp event_context set value {player: "player"}
data modify storage fb:tmp event_context.player set from entity @s Profile.Name

# Copy the list of callbacks for this event
$data modify storage fb:tmp event_context.list set from storage fb:events $(event)

# Debug log
$execute if data storage fb:config {debug: 1b} run tellraw @a [{"text": "[FB DEBUG] run_callbacks for event: ", "color": "gray"}, {"text": "$(event)", "color": "white"}, {"text": ", player: ", "color": "gray"}, {"nbt": "event_context.player", "storage": "fb:tmp", "color": "white"}, {"text": ", callbacks list: ", "color": "gray"}, {"nbt": "event_context.list", "storage": "fb:tmp"}]

# If callbacks are registered, loop through them
execute if data storage fb:tmp event_context.list[0] run function fb:event/loop_callbacks with storage fb:tmp event_context
