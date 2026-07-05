# Check if the looped player matches @s
# Arguments: player

# If name matches the current player entity, show the overwrite
$execute if entity $(player) run function fb:display/ab/show_actionbar_overwrite {player: "$(player)"}
