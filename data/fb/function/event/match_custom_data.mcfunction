# Match custom data component macro
# Arguments: custom_data

# Assume custom_data match fails by default
data modify storage fb:tmp event_match set value {val: 0b}

# 1. Direct entity SelectedItem check on @s (1.20.5+ components and legacy NBT)
$execute if data entity @s SelectedItem{components:{"minecraft:custom_data":$(custom_data)}} run data modify storage fb:tmp event_match.val set value 1b
$execute if data entity @s SelectedItem{components:{custom_data:$(custom_data)}} run data modify storage fb:tmp event_match.val set value 1b
$execute if data entity @s SelectedItem{tag:$(custom_data)} run data modify storage fb:tmp event_match.val set value 1b

# 2. Extract component to tmp storage for direct compound matching
data remove storage fb:tmp cd_check
data modify storage fb:tmp cd_check set from storage fb:tmp event_context.item.components."minecraft:custom_data"
execute unless data storage fb:tmp cd_check run data modify storage fb:tmp cd_check set from storage fb:tmp event_context.item.components.custom_data
execute unless data storage fb:tmp cd_check run data modify storage fb:tmp cd_check set from storage fb:tmp event_context.item.tag

# Test if cd_check matches required compound
$execute if data storage fb:tmp cd_check$(custom_data) run data modify storage fb:tmp event_match.val set value 1b

# 3. Fallback: Test directly on event_context storage
$execute if data storage fb:tmp event_context{item: {components: {"minecraft:custom_data": $(custom_data)}}} run data modify storage fb:tmp event_match.val set value 1b
$execute if data storage fb:tmp event_context{item: {components: {custom_data: $(custom_data)}}} run data modify storage fb:tmp event_match.val set value 1b
$execute if data storage fb:tmp event_context{item: {tag: $(custom_data)}} run data modify storage fb:tmp event_match.val set value 1b
