# FuseBox Event System - Loop Callbacks Iteration
# Arguments: player, list
# Executed as player (@s)

# 1. Copy head callback from list into current_callback
data modify storage fb:tmp current_callback set from storage fb:tmp event_context.list[0]

# 2. Step 3 Diagnostic Output
execute if data storage fb:config {debug:{event:1b}} run tellraw @a ["", {"text": "[FB Event Step 3] ", "color": "gold", "bold": true}, {"text": "Evaluating callback -> Target: '", "color": "yellow"}, {"nbt": "current_callback.fn", "storage": "fb:tmp", "color": "white"}, {"text": "' | Required Item: '", "color": "yellow"}, {"nbt": "current_callback.item_id", "storage": "fb:tmp", "color": "aqua"}, {"text": "' | Required Custom Data: ", "color": "yellow"}, {"nbt": "current_callback.custom_data", "storage": "fb:tmp", "color": "light_purple"}]

# 3. Default match flag to 1b (true) for standard events
data modify storage fb:tmp event_match set value {val: 1b}

# 4. If this callback has an item_id filter (not empty ""), perform item matching
execute unless data storage fb:tmp current_callback{item_id:""} run function fb:event/match_item with storage fb:tmp current_callback

# 5. If match is TRUE, run callback dispatcher
execute if data storage fb:tmp event_match{val: 1b} run function fb:event/run_single_callback with storage fb:tmp current_callback

# 6. Shift processed callback out of list
data remove storage fb:tmp event_context.list[0]

# 7. Recurse if remaining callbacks exist in list
execute if data storage fb:tmp event_context.list[0] run function fb:event/loop_callbacks with storage fb:tmp event_context
