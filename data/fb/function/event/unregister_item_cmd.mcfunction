# Unregister a specific item command callback
# Arguments: event, cmd, item_id, custom_data

# Remove the matching item callback from the list
$data remove storage fb:events $(event)[{fn: "$(cmd)", item_id: "$(item_id)", custom_data: $(custom_data)}]
