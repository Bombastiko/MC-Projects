# FuseBox Event System - Test Suite Finish & Summary Report
# Executed as player (@s)

tellraw @s ["", {"text": "\n=== FuseBox Event System Test Results Report ===\n", "color": "yellow", "bold": true}]

# Assertion 1: Fire Wand RightClick
execute if score @s fb.t_fire matches 1.. run tellraw @s ["", {"text": " [PASSED] ", "color": "green", "bold": true}, {"text": "Fire Wand RightClick (wand_type:fire): ", "color": "gold"}, {"score": {"name": "@s", "objective": "fb.t_fire"}, "color": "white"}, {"text": " triggers recorded.", "color": "gray"}]
execute unless score @s fb.t_fire matches 1.. run tellraw @s ["", {"text": " [FAILED] ", "color": "red", "bold": true}, {"text": "Fire Wand RightClick (wand_type:fire): ", "color": "gold"}, {"text": "0 triggers recorded (did not fire!).", "color": "red"}]

# Assertion 2: Ice Wand RightClick
execute if score @s fb.t_ice matches 1.. run tellraw @s ["", {"text": " [PASSED] ", "color": "green", "bold": true}, {"text": "Ice Wand RightClick (wand_type:ice): ", "color": "gold"}, {"score": {"name": "@s", "objective": "fb.t_ice"}, "color": "white"}, {"text": " triggers recorded.", "color": "gray"}]
execute unless score @s fb.t_ice matches 1.. run tellraw @s ["", {"text": " [FAILED] ", "color": "red", "bold": true}, {"text": "Ice Wand RightClick (wand_type:ice): ", "color": "gold"}, {"text": "0 triggers recorded (did not fire!).", "color": "red"}]

# Assertion 3: Speed Stick HoldItem
execute if score @s fb.t_hold matches 1.. run tellraw @s ["", {"text": " [PASSED] ", "color": "green", "bold": true}, {"text": "Speed Stick HoldItem (wand_type:speed): ", "color": "gold"}, {"score": {"name": "@s", "objective": "fb.t_hold"}, "color": "white"}, {"text": " ticks recorded.", "color": "gray"}]
execute unless score @s fb.t_hold matches 1.. run tellraw @s ["", {"text": " [FAILED] ", "color": "red", "bold": true}, {"text": "Speed Stick HoldItem (wand_type:speed): ", "color": "gold"}, {"text": "0 ticks recorded (did not fire!).", "color": "red"}]

tellraw @s ["", {"text": "================================================", "color": "yellow", "bold": true}]
