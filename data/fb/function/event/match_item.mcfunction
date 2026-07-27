# Match item filter macro
# Arguments: item_id, custom_data

# Set match flag to 0 first
data modify storage fb:tmp event_match set value {val: 0b}

# 1. Check base item ID on mainhand item of @s (direct entity check + storage fallback)
$execute if data entity @s SelectedItem{id:"$(item_id)"} run data modify storage fb:tmp event_match.val set value 1b
$execute if data entity @s SelectedItem{id:"minecraft:$(item_id)"} run data modify storage fb:tmp event_match.val set value 1b
$execute if data storage fb:tmp event_context{item: {id: "$(item_id)"}} run data modify storage fb:tmp event_match.val set value 1b
$execute if data storage fb:tmp event_context{item: {id: "minecraft:$(item_id)"}} run data modify storage fb:tmp event_match.val set value 1b

# 2. Check custom_data filter if specified
$data modify storage fb:tmp check_cd set value $(custom_data)

# If check_cd is not empty, enforce custom_data matching
execute if data storage fb:tmp event_match{val: 1b} unless data storage fb:tmp check_cd{} run function fb:event/match_custom_data with storage fb:tmp current_callback
