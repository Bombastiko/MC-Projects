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

# 3. Configure Debug Toggles for Completely Silent Test Execution
data modify storage fb:config debug.event set value 0b
data modify storage fb:config debug.event_only_success set value 1b
data modify storage fb:config debug.event_show_matcher set value 0b
data modify storage fb:config debug.event_show_register set value 0b
data modify storage fb:config debug.event_hold set value 0b
data modify storage fb:config debug.event_rc set value 0b

# 4. Register test callbacks with scoreboard increment commands
function fb:event/register_item_cmd {event:"onRightClick", cmd:"scoreboard players add @s fb.t_fire 1", item_id:"minecraft:carrot_on_a_stick", custom_data:{wand_type:"fire"}}
function fb:event/register_item_cmd {event:"onRightClick", cmd:"scoreboard players add @s fb.t_ice 1", item_id:"minecraft:carrot_on_a_stick", custom_data:{wand_type:"ice"}}
function fb:event/register_item_cmd {event:"onHoldItem", cmd:"scoreboard players add @s fb.t_hold 1", item_id:"minecraft:stick", custom_data:{wand_type:"speed"}}

# 5. Give player test items
give @s minecraft:carrot_on_a_stick[custom_data={wand_type:"fire"},item_name='"[TEST] Fire Wand"'] 1
give @s minecraft:carrot_on_a_stick[custom_data={wand_type:"ice"},item_name='"[TEST] Ice Wand"'] 1
give @s minecraft:stick[custom_data={wand_type:"speed"},item_name='"[TEST] Speed Stick"'] 1

# 6. Display Clean Interactive Guide
tellraw @s ["", {"text": "\n=== FuseBox Test Suite Started ===\n", "color": "yellow", "bold": true}]
tellraw @s ["", {"text": "3 Test Items given to your inventory:\n", "color": "gold"}]
tellraw @s ["", {"text": " 1. [TEST] Fire Wand ", "color": "red", "bold": true}, {"text": "(carrot_on_a_stick with wand_type:fire)\n", "color": "gray"}]
tellraw @s ["", {"text": "    -> Right-click with it in hand.\n", "color": "dark_gray"}]
tellraw @s ["", {"text": " 2. [TEST] Ice Wand ", "color": "aqua", "bold": true}, {"text": "(carrot_on_a_stick with wand_type:ice)\n", "color": "gray"}]
tellraw @s ["", {"text": "    -> Right-click with it in hand.\n", "color": "dark_gray"}]
tellraw @s ["", {"text": " 3. [TEST] Speed Stick ", "color": "green", "bold": true}, {"text": "(stick with wand_type:speed)\n", "color": "gray"}]
tellraw @s ["", {"text": "    -> Hold it in your hand for 2 seconds.\n\n", "color": "dark_gray"}]
tellraw @s ["", {"text": "▶ WHEN FINISHED TESTING: ", "color": "yellow", "bold": true}, {"text": "[CLICK HERE TO SEE REPORT]", "color": "green", "bold": true, "clickEvent": {"action": "run_command", "value": "/function fb:event/test_finish"}, "hoverEvent": {"action": "show_text", "contents": ["Click to display test results report card"]}}, "\n"]
tellraw @s ["", {"text": "===================================", "color": "yellow", "bold": true}]
