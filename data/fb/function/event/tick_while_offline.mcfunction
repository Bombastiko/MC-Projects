# Initialize whileOffline execution loop
# Executed every tick if callbacks are registered

# Copy current list of offline players to loop through
data modify storage fb:tmp offline_loop set from storage fb:events offline_players

# Run recursive looping function if list is not empty
execute if data storage fb:tmp offline_loop[0] run function fb:event/loop_while_offline
