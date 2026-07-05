# Unregister an item function callback
# Arguments: event, fn

# Remove matching function callback from the list
$data remove storage fb:events $(event)[{fn: "$(fn)"}]
