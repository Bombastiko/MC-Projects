# Execute whileOffline callbacks for the specific offline player
# Arguments: player

# Run offline callbacks runner
$function fb:event/run_offline_callbacks {event: "whileOffline", player: "$(player)"}
