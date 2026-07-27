# FuseBox Event System - Match Item & Custom Data Filter
# Arguments: item_id, custom_data
# Executed as player (@s)

# 1. Reset match flags
data modify storage fb:tmp event_match set value {val: 0b, mainhand: 0b, offhand: 0b}

# --- MAINHAND CHECK ---
# A. Check Mainhand Item ID match
$execute if data storage fb:tmp {current_callback: {item_id: ""}} run data modify storage fb:tmp event_match.mainhand set value 1b
$execute if data storage fb:tmp {current_callback: {item_id: "*"}} run data modify storage fb:tmp event_match.mainhand set value 1b
$execute if data storage fb:tmp {player_items: {mainhand: {id: "$(item_id)"}}} run data modify storage fb:tmp event_match.mainhand set value 1b
$execute if data storage fb:tmp {player_items: {mainhand: {id: "minecraft:$(item_id)"}}} run data modify storage fb:tmp event_match.mainhand set value 1b

# B. Check Mainhand Custom Data match (if Mainhand Item ID matched)
execute if data storage fb:tmp event_match{mainhand: 1b} run function fb:event/match_custom_data {hand: "mainhand", custom_data: $(custom_data)}

# --- OFFHAND CHECK ---
# A. Check Offhand Item ID match
$execute if data storage fb:tmp {current_callback: {item_id: ""}} run data modify storage fb:tmp event_match.offhand set value 1b
$execute if data storage fb:tmp {current_callback: {item_id: "*"}} run data modify storage fb:tmp event_match.offhand set value 1b
$execute if data storage fb:tmp {player_items: {offhand: {id: "$(item_id)"}}} run data modify storage fb:tmp event_match.offhand set value 1b
$execute if data storage fb:tmp {player_items: {offhand: {id: "minecraft:$(item_id)"}}} run data modify storage fb:tmp event_match.offhand set value 1b

# B. Check Offhand Custom Data match (if Offhand Item ID matched)
execute if data storage fb:tmp event_match{offhand: 1b} run function fb:event/match_custom_data {hand: "offhand", custom_data: $(custom_data)}

# --- COMBINE RESULTS ---
execute if data storage fb:tmp event_match{mainhand: 1b} run data modify storage fb:tmp event_match.val set value 1b
execute if data storage fb:tmp event_match{offhand: 1b} run data modify storage fb:tmp event_match.val set value 1b

# --- DIAGNOSTICS ---
execute if data storage fb:config {debug:{event:1b}} if data storage fb:tmp event_context{name:"onRightClick"} if data storage fb:tmp event_match{val:1b} run tellraw @a ["", {"text": "  [FB RightClick Match] ", "color": "gold"}, {"text": "MATCH! ", "color": "green", "bold": true}, {"text": "(Required item: ", "color": "gray"}, {"nbt": "current_callback.item_id", "storage": "fb:tmp", "color": "aqua"}, {"text": ", custom_data: ", "color": "gray"}, {"nbt": "current_callback.custom_data", "storage": "fb:tmp", "color": "light_purple"}, {"text": ")", "color": "gray"}]
execute if data storage fb:config {debug:{event:1b}} if data storage fb:tmp event_context{name:"onRightClick"} if data storage fb:tmp event_match{val:0b} run tellraw @a ["", {"text": "  [FB RightClick Match] ", "color": "gold"}, {"text": "MISMATCH! ", "color": "red", "bold": true}, {"text": "(Required item: ", "color": "gray"}, {"nbt": "current_callback.item_id", "storage": "fb:tmp", "color": "yellow"}, {"text": ", custom_data: ", "color": "gray"}, {"nbt": "current_callback.custom_data", "storage": "fb:tmp", "color": "light_purple"}, {"text": ")", "color": "gray"}]
