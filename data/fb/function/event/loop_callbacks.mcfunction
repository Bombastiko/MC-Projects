# Iterative callback loop with item matching
# Arguments: player, list

# Prepare current_callback NBT
data modify storage fb:tmp current_callback set from storage fb:tmp event_context.list[0]
data modify storage fb:tmp current_callback.player set from storage fb:tmp event_context.player

# By default, assume match is true
data modify storage fb:tmp event_match set value {val: 1b}

# If the callback has an item_id filter, we run the macro matcher
execute if data storage fb:tmp current_callback.item_id run function fb:event/match_item with storage fb:tmp current_callback

# If matched, run the callback
execute if data storage fb:tmp event_match{val: 1b} run function fb:event/run_single_callback with storage fb:tmp current_callback

# If matched and cooldown is specified, apply it
execute if data storage fb:tmp event_match{val: 1b} if data storage fb:tmp current_callback.cooldown run function fb:event/apply_cooldown with storage fb:tmp current_callback

# Remove the processed callback
data remove storage fb:tmp event_context.list[0]

# Recurse if there are more callbacks in the list
execute if data storage fb:tmp event_context.list[0] run function fb:event/loop_callbacks with storage fb:tmp event_context
