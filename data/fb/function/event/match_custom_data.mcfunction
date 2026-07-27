# Match custom data component macro
# Arguments: custom_data

# Assume match fails by default
data modify storage fb:tmp event_match set value {val: 0b}

# Extract custom_data component from item NBT to fb:tmp item_cd
data remove storage fb:tmp item_cd
data modify storage fb:tmp item_cd set from storage fb:tmp event_context.item.components."minecraft:custom_data"
execute unless data storage fb:tmp item_cd run data modify storage fb:tmp item_cd set from storage fb:tmp event_context.item.components.custom_data
execute unless data storage fb:tmp item_cd run data modify storage fb:tmp item_cd set from storage fb:tmp event_context.item.tag
execute unless data storage fb:tmp item_cd run data modify storage fb:tmp item_cd set from entity @s SelectedItem.components."minecraft:custom_data"

# Direct compound match on item_cd
$execute if data storage fb:tmp item_cd$(custom_data) run data modify storage fb:tmp event_match.val set value 1b

# Fallback: Direct NBT check on player entity SelectedItem
$execute if data entity @s SelectedItem{components:{"minecraft:custom_data":$(custom_data)}} run data modify storage fb:tmp event_match.val set value 1b
$execute if data entity @s SelectedItem{components:{custom_data:$(custom_data)}} run data modify storage fb:tmp event_match.val set value 1b
$execute if data entity @s SelectedItem{tag:$(custom_data)} run data modify storage fb:tmp event_match.val set value 1b

# Live debug custom_data matcher report
$execute if data storage fb:config {debug:{event:1b}} if data storage fb:tmp event_match{val:1b} run tellraw @a ["", {"text": "  [FB Matcher] ", "color": "dark_gray"}, {"text": "Custom Data Matched! ", "color": "green"}, {"text": "Required: ", "color": "gray"}, {"nbt": "custom_data", "storage": "fb:tmp current_callback", "color": "light_purple"}, {"text": ", Held: ", "color": "gray"}, {"nbt": "item_cd", "storage": "fb:tmp", "color": "white"}]
$execute if data storage fb:config {debug:{event:1b}} if data storage fb:tmp event_match{val:0b} run tellraw @a ["", {"text": "  [FB Matcher] ", "color": "dark_gray"}, {"text": "Custom Data Mismatch! ", "color": "red"}, {"text": "Required: ", "color": "gray"}, {"nbt": "custom_data", "storage": "fb:tmp current_callback", "color": "yellow"}, {"text": ", Held: ", "color": "gray"}, {"nbt": "item_cd", "storage": "fb:tmp", "color": "white"}]
