# Loop through online players to check if they match @s
# Arguments: player

# Check first player in temp list
function fb:display/ab/check_overwrite_match with storage fb:tmp temp_online[0]

# Remove processed player
data remove storage fb:tmp temp_online[0]

# Recurse if more players remain
execute if data storage fb:tmp temp_online[0] run function fb:display/ab/loop_find_overwrite
