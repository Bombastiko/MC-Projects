# FuseBox Event System - Match Custom Data Component Filter
# Arguments: custom_data
# Executed as player (@s)

# 1. Reset match flag to 0b (false)
data modify storage fb:tmp event_match set value {val: 0b}

# 2. Compound match against pre-extracted item_cd in storage
$execute if data storage fb:tmp {item_cd: $(custom_data)} run data modify storage fb:tmp event_match.val set value 1b
$execute if data storage fb:tmp {event_context: {item_cd: $(custom_data)}} run data modify storage fb:tmp event_match.val set value 1b

# 3. Direct entity fallback checks on player entity @s SelectedItem (or Offhand Slot -106b)
$execute if data entity @s SelectedItem{components:{"minecraft:custom_data":$(custom_data)}} run data modify storage fb:tmp event_match.val set value 1b
$execute if data entity @s SelectedItem{components:{custom_data:$(custom_data)}} run data modify storage fb:tmp event_match.val set value 1b
$execute if data entity @s SelectedItem{tag:$(custom_data)} run data modify storage fb:tmp event_match.val set value 1b
$execute if data entity @s Inventory[{Slot:-106b,components:{"minecraft:custom_data":$(custom_data)}}] run data modify storage fb:tmp event_match.val set value 1b

# 4. Live debug custom_data matcher report (if verbose matcher debugging is enabled)
$execute if data storage fb:config {debug:{event:1b, event_show_matcher:1b}} if data storage fb:tmp dbg_allow{val:1b} unless data storage fb:config {debug:{event_only_success:1b}} if data storage fb:tmp event_match{val:1b} run tellraw @a ["", {"text": "  [FB Matcher] ", "color": "dark_gray"}, {"text": "Custom Data Matched! ", "color": "green"}, {"text": "Required: ", "color": "gray"}, {"nbt": "custom_data", "storage": "fb:tmp current_callback", "color": "light_purple"}, {"text": ", Held: ", "color": "gray"}, {"nbt": "item_cd", "storage": "fb:tmp", "color": "white"}]
$execute if data storage fb:config {debug:{event:1b, event_show_matcher:1b}} if data storage fb:tmp dbg_allow{val:1b} unless data storage fb:config {debug:{event_only_success:1b}} if data storage fb:tmp event_match{val:0b} run tellraw @a ["", {"text": "  [FB Matcher] ", "color": "dark_gray"}, {"text": "Custom Data Mismatch! ", "color": "red"}, {"text": "Required: ", "color": "gray"}, {"nbt": "custom_data", "storage": "fb:tmp current_callback", "color": "yellow"}, {"text": ", Held: ", "color": "gray"}, {"nbt": "item_cd", "storage": "fb:tmp", "color": "white"}]
