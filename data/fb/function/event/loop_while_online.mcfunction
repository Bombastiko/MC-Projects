# Loop recursively through online players for whileOnline event
# Arguments: player

# Run macro executor for first player in list
function fb:event/run_single_while_online with storage fb:tmp online_loop[0]

# Remove processed player from list
data remove storage fb:tmp online_loop[0]

# Recurse if more players exist
execute if data storage fb:tmp online_loop[0] run function fb:event/loop_while_online
