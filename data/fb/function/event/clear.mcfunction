# Clear all callbacks registered for a specific event
# Arguments: event

# Delete the entire event registry list from storage
$data remove storage fb:events $(event)

# Debug feedback
$execute if data storage fb:config {debug:{event:1b}} run tellraw @a [{"text": "[FB DEBUG] Cleared all callbacks for event: ", "color": "gray"}, {"text": "$(event)", "color": "white"}]
