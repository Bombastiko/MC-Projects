# Check if a single player is offline
# Arguments: player

# If the player is no longer online, trigger the leave event
$execute unless entity $(player) run function fb:event/trigger_leave {player: "$(player)"}
