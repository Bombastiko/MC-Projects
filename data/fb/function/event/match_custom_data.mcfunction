# FuseBox Event System - Match Custom Data Component Filter
# Arguments: custom_data
# Executed as player (@s)

# 1. Reset match flag to 0b (false)
data modify storage fb:tmp event_match set value {val: 0b}

# 2. Modern 1.20.5+ / 1.21+ Item Predicate Check (Mainhand & Offhand)
$execute if items entity @s weapon.mainhand *[custom_data=$(custom_data)] run data modify storage fb:tmp event_match.val set value 1b
$execute if items entity @s weapon.offhand *[custom_data=$(custom_data)] run data modify storage fb:tmp event_match.val set value 1b

# 3. Storage compound match fallback (for pre-extracted item_cd)
$execute if data storage fb:tmp {item_cd: $(custom_data)} run data modify storage fb:tmp event_match.val set value 1b

# 4. Step 5 Diagnostic Output for RightClick ONLY (Static lines - NO leading $)
execute if data storage fb:config {debug:{event:1b}} if data storage fb:tmp event_context{name:"onRightClick"} if data storage fb:tmp event_match{val:1b} run tellraw @a ["", {"text": "  [FB RightClick Step 5] ", "color": "gold"}, {"text": "Custom Data Check: ", "color": "yellow"}, {"text": "MATCH! ", "color": "green", "bold": true}, {"text": "(Required: ", "color": "gray"}, {"nbt": "custom_data", "storage": "fb:tmp current_callback", "color": "light_purple"}, {"text": " == Held: ", "color": "gray"}, {"nbt": "item_cd", "storage": "fb:tmp", "color": "light_purple"}, {"text": ")", "color": "gray"}]
execute if data storage fb:config {debug:{event:1b}} if data storage fb:tmp event_context{name:"onRightClick"} if data storage fb:tmp event_match{val:0b} run tellraw @a ["", {"text": "  [FB RightClick Step 5] ", "color": "gold"}, {"text": "Custom Data Check: ", "color": "yellow"}, {"text": "MISMATCH! ", "color": "red", "bold": true}, {"text": "(Required: ", "color": "gray"}, {"nbt": "custom_data", "storage": "fb:tmp current_callback", "color": "yellow"}, {"text": " != Held: ", "color": "gray"}, {"nbt": "item_cd", "storage": "fb:tmp", "color": "white"}, {"text": ")", "color": "gray"}]
