# Add player to online registry uniquely
# Arguments: player

# Remove existing matching username if present to prevent duplicates
$data remove storage fb:events online_players[{player: "$(player)"}]

# Append to registry list
$data modify storage fb:events online_players append value {player: "$(player)"}

# Remove from offline list
$data remove storage fb:events offline_players[{player: "$(player)"}]
