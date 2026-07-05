# Unregister a specific item function callback
# Arguments: event, fn, item_id, custom_data

# Remove the matching item callback from the list
$data remove storage fb:events $(event)[{fn: "$(fn)", item_id: "$(item_id)", custom_data: $(custom_data)}]
