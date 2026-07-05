# Find player name string from online players to render their overwrite
# Executed as the player (@s)

# Copy online players list to loop through
data modify storage fb:tmp temp_online set from storage fb:events online_players

# Run find loop
execute if data storage fb:tmp temp_online[0] run function fb:display/ab/loop_find_overwrite
