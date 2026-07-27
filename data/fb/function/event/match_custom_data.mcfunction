# Match custom data component macro
# Arguments: custom_data

# Extract custom_data component from player's held item
data remove storage fb:tmp player_cd
data modify storage fb:tmp player_cd set from storage fb:tmp event_context.item.components."minecraft:custom_data"

# Fallback for legacy tag structure if present
execute unless data storage fb:tmp player_cd run data modify storage fb:tmp player_cd set from storage fb:tmp event_context.item.tag

# If the player's held item custom data does not match the required compound, set match flag to 0
$execute unless data storage fb:tmp player_cd$(custom_data) run data modify storage fb:tmp event_match.val set value 0b
