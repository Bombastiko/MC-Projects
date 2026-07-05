# Match custom data component macro
# Arguments: custom_data

# If the player's held item does not match custom_data, set match flag to 0
$execute unless data storage fb:tmp event_context{item: {components: {"minecraft:custom_data": $(custom_data)}}} run data modify storage fb:tmp event_match.val set value 0b
