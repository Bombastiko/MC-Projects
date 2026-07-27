# FuseBox Event System - Loop Callbacks Iteration
# Arguments: player, list
# Executed as player (@s)

# 1. Copy head callback from list into current_callback
data modify storage fb:tmp current_callback set from storage fb:tmp event_context.list[0]

# 2. Default match flag to 1b (true) for standard events
data modify storage fb:tmp event_match set value {val: 1b}

# 3. If this callback has an item_id filter (not empty ""), perform item matching
execute unless data storage fb:tmp current_callback{item_id:""} run function fb:event/match_item with storage fb:tmp current_callback

# 4. If match is TRUE, run callback dispatcher
execute if data storage fb:tmp event_match{val: 1b} run function fb:event/run_single_callback with storage fb:tmp current_callback

# 5. Shift processed callback out of list
data remove storage fb:tmp event_context.list[0]

# 6. Recurse if remaining callbacks exist in list
execute if data storage fb:tmp event_context.list[0] run function fb:event/loop_callbacks with storage fb:tmp event_context
