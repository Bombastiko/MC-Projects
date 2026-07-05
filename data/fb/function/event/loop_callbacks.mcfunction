# Iterative callback loop
# Arguments: player, list

# Debug log
execute if data storage fb:config {debug: 1b} run tellraw @a [{"text": "[FB DEBUG] loop_callbacks: current callback is ", "color": "gray"}, {"nbt": "event_context.list[0]", "storage": "fb:tmp"}]

# Prepare single callback parameter compound (setting fn and player username)
data modify storage fb:tmp current_callback set value {player: ""}
data modify storage fb:tmp current_callback.player set from storage fb:tmp event_context.player
data modify storage fb:tmp current_callback.fn set from storage fb:tmp event_context.list[0].fn

# Run the single callback function as a macro
function fb:event/run_single_callback with storage fb:tmp current_callback

# Remove the processed callback
data remove storage fb:tmp event_context.list[0]

# Recurse if there are more callbacks in the list
execute if data storage fb:tmp event_context.list[0] run function fb:event/loop_callbacks with storage fb:tmp event_context
