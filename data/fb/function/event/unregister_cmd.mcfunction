# Unregister a direct command callback
# Arguments: event, cmd

# Remove matching command from the list
$data remove storage fb:events $(event)[{fn: "$(cmd)"}]
