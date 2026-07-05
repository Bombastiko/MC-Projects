# Resolve name and trigger cleanup macro for player
# Executed as the player whose overwrite is expiring

# Resolve player's username string
function fb:event/resolve_name

# Delete the cached overwrite NBT data
function fb:display/ab/delete_overwrite_cache with storage fb:tmp event_context
