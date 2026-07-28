# FuseBox Event System - Single Callback Dispatcher
# Arguments: current_callback (type, fn)
# Executed as player (@s)

# 1. Attach player name & event context to current_callback for macro passing
data modify storage fb:tmp current_callback.player set from storage fb:tmp event_context.player
data modify storage fb:tmp current_callback.event set from storage fb:tmp event_context.name

# 2. Copy callback type
data modify storage fb:tmp callback_type set value "function"
data modify storage fb:tmp callback_type set from storage fb:tmp current_callback.type

# 3. Dispatch to target execution handler with full storage parameters
execute if data storage fb:tmp {callback_type: "function"} run function fb:event/run_function_callback with storage fb:tmp current_callback
execute if data storage fb:tmp {callback_type: "command"} run function fb:event/run_command_callback with storage fb:tmp current_callback
