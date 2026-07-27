# FuseBox Event System - Loop Callbacks Iteration
# Executed as player (@s)

# 1. Copy head callback from list into current_callback
data modify storage fb:tmp current_callback set from storage fb:tmp event_context.list[0]

# 2. Perform item & custom_data matching for this callback
function fb:event/match_callback with storage fb:tmp current_callback

# 3. Diagnostic output for matcher breakdown (if enabled in debug config)
execute if data storage fb:config {debug:{event:1b, event_show_matcher:1b}} run tellraw @a ["", {"text": "[FuseBox Matcher] ", "color": "yellow"}, {"text": "Target: ", "color": "gray"}, {"nbt": "current_callback.fn", "storage": "fb:tmp", "color": "white"}, {"text": " | Match Result: ", "color": "gray"}, {"nbt": "match_result.val", "storage": "fb:tmp", "color": "aqua"}, {"text": " | Hand: ", "color": "gray"}, {"nbt": "match_result.hand", "storage": "fb:tmp", "color": "light_purple"}]

# 4. If match is TRUE (1b), run callback dispatcher
execute if data storage fb:tmp match_result{val: 1b} run function fb:event/run_single_callback with storage fb:tmp current_callback

# 5. Shift processed callback out of list
data remove storage fb:tmp event_context.list[0]

# 6. Recurse if remaining callbacks exist in list
execute if data storage fb:tmp event_context.list[0] run function fb:event/loop_callbacks
