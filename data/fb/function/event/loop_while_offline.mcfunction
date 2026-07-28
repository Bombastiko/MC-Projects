# Loop recursively through offline players for whileOffline event
# Arguments: player

# Run macro executor for first player in list
function fb:event/run_single_while_offline with storage fb:tmp offline_loop[0]

# Remove processed player from list
data remove storage fb:tmp offline_loop[0]

# Recurse if more players exist
execute if data storage fb:tmp offline_loop[0] run function fb:event/loop_while_offline
