# Unregister an event callback
# Arguments: event, fn

# Remove callback from the list
$data remove storage fb:events $(event)[{fn: "$(fn)"}]
