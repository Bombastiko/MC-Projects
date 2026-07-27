# FuseBox Event System - Test Suite Finish & Summary Report
# Executed as player (@s)

tellraw @s ["", {"text": "\n=== FuseBox Event System Test Results Report ===\n", "color": "yellow", "bold": true}]

# Assertion 1: Fire Wand RightClick
execute if score @s fb.t_fire matches 1.. run tellraw @s ["", {"text": " [PASSED] ", "color": "green", "bold": true}, {"text": "Fire Wand RightClick (custom_data:{id:\"fire_wand\"}): ", "color": "gold"}, {"score": {"name": "@s", "objective": "fb.t_fire"}, "color": "white"}, {"text": " triggers recorded.", "color": "gray"}]
execute unless score @s fb.t_fire matches 1.. run tellraw @s ["", {"text": " [FAILED] ", "color": "red", "bold": true}, {"text": "Fire Wand RightClick (custom_data:{id:\"fire_wand\"}): ", "color": "gold"}, {"text": "0 triggers recorded.", "color": "red"}]

# Assertion 2: Ice Wand RightClick
execute if score @s fb.t_ice matches 1.. run tellraw @s ["", {"text": " [PASSED] ", "color": "green", "bold": true}, {"text": "Ice Wand RightClick (custom_data:{id:\"ice_wand\"}): ", "color": "gold"}, {"score": {"name": "@s", "objective": "fb.t_ice"}, "color": "white"}, {"text": " triggers recorded.", "color": "gray"}]
execute unless score @s fb.t_ice matches 1.. run tellraw @s ["", {"text": " [FAILED] ", "color": "red", "bold": true}, {"text": "Ice Wand RightClick (custom_data:{id:\"ice_wand\"}): ", "color": "gold"}, {"text": "0 triggers recorded.", "color": "red"}]

# Assertion 3: Speed Stick HoldItem
execute if score @s fb.t_hold matches 1.. run tellraw @s ["", {"text": " [PASSED] ", "color": "green", "bold": true}, {"text": "Speed Stick HoldItem (custom_data:{id:\"speed_stick\"}): ", "color": "gold"}, {"score": {"name": "@s", "objective": "fb.t_hold"}, "color": "white"}, {"text": " ticks recorded.", "color": "gray"}]
execute unless score @s fb.t_hold matches 1.. run tellraw @s ["", {"text": " [FAILED] ", "color": "red", "bold": true}, {"text": "Speed Stick HoldItem (custom_data:{id:\"speed_stick\"}): ", "color": "gold"}, {"text": "0 ticks recorded.", "color": "red"}]

# Automatically disable debug mode after test finishes to keep chat clean
data modify storage fb:config debug.event set value 0b

tellraw @s ["", {"text": "================================================", "color": "yellow", "bold": true}]
