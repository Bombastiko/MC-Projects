# Match item filter macro
# Arguments: item_id, custom_data

# Set match flag to 0 first
data modify storage fb:tmp event_match set value {val: 0b}

# Check if item ID matches
$execute if data storage fb:tmp event_context{item: {id: "$(item_id)"}} run data modify storage fb:tmp event_match.val set value 1b

# If custom_data is specified, check if it matches as well
$execute if data storage fb:tmp event_match{val: 1b} unless data storage fb:tmp event_context{item: {components: {"minecraft:custom_data": $(custom_data)}}} run data modify storage fb:tmp event_match.val set value 0b
