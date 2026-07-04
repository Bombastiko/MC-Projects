# Clear actionbar display configuration for player (ab)
# Arguments: player

# Clear player display config
$data remove storage fb:config display.$(player)

# Unregister player from active loop list
$data remove storage fb:config players[{player: "$(player)"}]

# Reset actionbar title on screen
$title $(player) actionbar ""
