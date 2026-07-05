# Check if any registered online player is no longer online
# Executed every tick

# Copy current list of online players to loop through
data modify storage fb:tmp online_check set from storage fb:events online_players

# Run recursive checking loop if there are players in the list
execute if data storage fb:tmp online_check[0] run function fb:event/loop_leaves
