# FuseBox Event System - Automated Test Suite Setup
# Executed as player (@s)

# 1. Purge previous database
function fb:event/reset_db

# 2. Setup scoreboards for tracking test trigger assertions
scoreboard objectives add fb.t_fire dummy
scoreboard objectives add fb.t_ice dummy
scoreboard objectives add fb.t_hold dummy
scoreboard players set @s fb.t_fire 0
scoreboard players set @s fb.t_ice 0
scoreboard players set @s fb.t_hold 0

# 3. Configure Debug Toggles for Silent Test Execution (Report will summarize results)
data modify storage fb:config debug.event set value 0b
data modify storage fb:config debug.event_only_success set value 1b
data modify storage fb:config debug.event_show_matcher set value 0b
data modify storage fb:config debug.event_show_register set value 0b

# 4. Register test callbacks with scoreboard increment commands
function fb:event/register_item_cmd {event:"onRightClick", cmd:"scoreboard players add @s fb.t_fire 1", item_id:"minecraft:carrot_on_a_stick", custom_data:{id:"fire_wand"}}
function fb:event/register_item_cmd {event:"onRightClick", cmd:"scoreboard players add @s fb.t_ice 1", item_id:"minecraft:carrot_on_a_stick", custom_data:{id:"ice_wand"}}
function fb:event/register_item_cmd {event:"onHoldItem", cmd:"scoreboard players add @s fb.t_hold 1", item_id:"minecraft:stick", custom_data:{id:"speed_stick"}}

# 5. Give player test items
give @s minecraft:carrot_on_a_stick[custom_data={id:"fire_wand"},item_name='"[TEST] Fire Wand"'] 1
give @s minecraft:carrot_on_a_stick[custom_data={id:"ice_wand"},item_name='"[TEST] Ice Wand"'] 1
give @s minecraft:stick[custom_data={id:"speed_stick"},item_name='"[TEST] Speed Stick"'] 1

# 6. Display Clean Interactive Guide
tellraw @s ["", {"text": "\n=== FuseBox Event System Test Suite Started ===\n", "color": "yellow", "bold": true}]
tellraw @s ["", {"text": "3 Test Items given to your inventory:\n", "color": "gold"}]
tellraw @s ["", {"text": " 1. [TEST] Fire Wand ", "color": "red", "bold": true}, {"text": "(carrot_on_a_stick with custom_data:{id:\"fire_wand\"})\n", "color": "gray"}]
tellraw @s ["", {"text": "    -> Right-click with it in hand.\n", "color": "dark_gray"}]
tellraw @s ["", {"text": " 2. [TEST] Ice Wand ", "color": "aqua", "bold": true}, {"text": "(carrot_on_a_stick with custom_data:{id:\"ice_wand\"})\n", "color": "gray"}]
tellraw @s ["", {"text": "    -> Right-click with it in hand.\n", "color": "dark_gray"}]
tellraw @s ["", {"text": " 3. [TEST] Speed Stick ", "color": "green", "bold": true}, {"text": "(stick with custom_data:{id:\"speed_stick\"})\n", "color": "gray"}]
tellraw @s ["", {"text": "    -> Hold it in your hand for 2 seconds.\n\n", "color": "dark_gray"}]
tellraw @s ["", {"text": "▶ WHEN FINISHED TESTING: ", "color": "yellow", "bold": true}, {"text": "[CLICK HERE TO SEE REPORT]", "color": "green", "bold": true, "clickEvent": {"action": "run_command", "value": "/function fb:event/test_finish"}, "hoverEvent": {"action": "show_text", "contents": ["Click to display test results report card"]}}, "\n"]
tellraw @s ["", {"text": "===============================================", "color": "yellow", "bold": true}]
