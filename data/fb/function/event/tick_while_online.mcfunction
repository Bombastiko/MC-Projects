# Initialize whileOnline execution loop
# Executed every tick if callbacks are registered

# Copy current list of online players to loop through
data modify storage fb:tmp online_loop set from storage fb:events online_players

# Run recursive looping function if list is not empty
execute if data storage fb:tmp online_loop[0] run function fb:event/loop_while_online
