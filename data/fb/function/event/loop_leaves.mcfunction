# Iterative online player check loop
# Arguments: player

# Run macro check on the first player in the temp list
function fb:event/check_single_leave with storage fb:tmp online_check[0]

# Remove the processed player from the temp list
data remove storage fb:tmp online_check[0]

# Recurse if there are more players to check
execute if data storage fb:tmp online_check[0] run function fb:event/loop_leaves
