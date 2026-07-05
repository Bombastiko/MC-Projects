# Match item filter macro
# Arguments: item_id, custom_data

# Set match flag to 0 first
data modify storage fb:tmp event_match set value {val: 0b}

# 1. Check if base item ID matches
$execute if data storage fb:tmp event_context{item: {id: "$(item_id)"}} run data modify storage fb:tmp event_match.val set value 1b

# 2. Check custom_data if it is not empty
$data modify storage fb:tmp check_cd set value $(custom_data)

# If check_cd is not empty, we enforce custom_data match
execute if data storage fb:tmp event_match{val: 1b} unless data storage fb:tmp check_cd{} run function fb:event/match_custom_data with storage fb:tmp current_callback
