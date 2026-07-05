# Unregister an item direct command callback
# Arguments: event, cmd

# Remove matching command callback from the list
$data remove storage fb:events $(event)[{fn: "$(cmd)"}]
