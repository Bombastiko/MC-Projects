# Trigger onLeave callbacks
# Arguments: player

# Debug log
$execute if data storage fb:config {debug:{event:1b}} run tellraw @a [{"text": "[FB DEBUG] trigger_leave for ", "color": "gray"}, {"text": "$(player)", "color": "white"}]

# Remove player from official online list in fb:events
$data remove storage fb:events online_players[{player: "$(player)"}]

# Run callbacks for onLeave (using the custom runner because player is offline)
$function fb:event/run_offline_callbacks {event: "onLeave", player: "$(player)"}
