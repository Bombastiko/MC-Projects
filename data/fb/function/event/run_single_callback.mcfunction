# Run single callback macro dispatcher
# Arguments: fn, type, player

# Copy type
data modify storage fb:tmp callback_type set value "function"
data modify storage fb:tmp callback_type set from storage fb:tmp current_callback.type

# Run function callback
execute if data storage fb:tmp {callback_type: "function"} run function fb:event/run_function_callback with storage fb:tmp current_callback

# Run command callback
execute if data storage fb:tmp {callback_type: "command"} run function fb:event/run_command_callback with storage fb:tmp current_callback
