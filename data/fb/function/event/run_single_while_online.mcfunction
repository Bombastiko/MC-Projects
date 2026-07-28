# Execute whileOnline callbacks as the specific player
# Arguments: player

# Run callbacks runner as the player, passing the player name parameter
$execute as $(player) run function fb:event/run_while_online_callbacks {player: "$(player)"}
