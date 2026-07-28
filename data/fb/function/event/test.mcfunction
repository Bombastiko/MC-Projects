# FuseBox Event System - Guided Step-by-Step Test Suite Setup
# Executed as player (@s)

# 1. Mute Debug Logging (Keep chat clean)
data modify storage fb:config debug.global set value 0b
data modify storage fb:config debug.event set value 0b

# 2. Reset Database & Setup Scoreboard Objectives
function fb:event/reset_db

scoreboard objectives add fb.t_join dummy
scoreboard objectives add fb.t_death dummy
scoreboard objectives add fb.t_dmg dummy
scoreboard objectives add fb.t_kill dummy
scoreboard objectives add fb.t_online dummy
scoreboard objectives add fb.t_rc_cmd dummy
scoreboard objectives add fb.t_rc_fn dummy
scoreboard objectives add fb.t_hold_cmd dummy
scoreboard objectives add fb.t_hold_fn dummy

scoreboard players set @s fb.t_join 0
scoreboard players set @s fb.t_death 0
scoreboard players set @s fb.t_dmg 0
scoreboard players set @s fb.t_kill 0
scoreboard players set @s fb.t_online 0
scoreboard players set @s fb.t_rc_cmd 0
scoreboard players set @s fb.t_rc_fn 0
scoreboard players set @s fb.t_hold_cmd 0
scoreboard players set @s fb.t_hold_fn 0

# 3. Register Test Callbacks
function fb:event/register_cmd {event:"onJoin", cmd:"scoreboard players add @s fb.t_join 1"}
function fb:event/register_cmd {event:"onDeath", cmd:"scoreboard players add @s fb.t_death 1"}
function fb:event/register_cmd {event:"onDamage", cmd:"scoreboard players add @s fb.t_dmg 1"}
function fb:event/register_cmd {event:"onEntityKill", cmd:"scoreboard players add @s fb.t_kill 1"}
function fb:event/register_cmd {event:"whileOnline", cmd:"scoreboard players add @s fb.t_online 1"}

function fb:event/register_item_cmd {event:"onRightClick", item_id:"minecraft:carrot_on_a_stick", custom_data:{id:"test_rc"}, fn:"scoreboard players add @s fb.t_rc_cmd 1"}
function fb:event/register_item {event:"onRightClick", item_id:"minecraft:carrot_on_a_stick", custom_data:{id:"test_rc"}, fn:"fb:event/test_rc_callback"}

function fb:event/register_item_cmd {event:"onHoldItem", item_id:"minecraft:stick", custom_data:{id:"test_hold"}, fn:"scoreboard players add @s fb.t_hold_cmd 1"}
function fb:event/register_item {event:"onHoldItem", item_id:"minecraft:stick", custom_data:{id:"test_hold"}, fn:"fb:event/test_hold_callback"}

# 4. Give Test Items to Player Inventory
give @s minecraft:carrot_on_a_stick[custom_data={id:"test_rc"},item_name='"[TEST] Fire Wand"'] 1
give @s minecraft:stick[custom_data={id:"test_hold"},item_name='"[TEST] Speed Stick"'] 1

# 5. Output Step-by-Step Guided Instructions in Chat
tellraw @s ["", {"text": "\n=== FuseBox Event Guided Test Suite ===\n", "color": "yellow", "bold": true}]
tellraw @s ["", {"text": "Follow these steps to test each event type:\n\n", "color": "gold"}]

tellraw @s ["", {"text": "Step 1 [onRightClick]: ", "color": "yellow", "bold": true}, {"text": "Right-click with ", "color": "gray"}, {"text": "[TEST] Fire Wand", "color": "red", "bold": true}, {"text": " in hand.\n", "color": "gray"}]
tellraw @s ["", {"text": "Step 2 [onHoldItem]: ", "color": "yellow", "bold": true}, {"text": "Hold ", "color": "gray"}, {"text": "[TEST] Speed Stick", "color": "green", "bold": true}, {"text": " in hand for 2 seconds.\n", "color": "gray"}]

tellraw @s ["", {"text": "Step 3 [onDamage]: ", "color": "yellow", "bold": true}, {"text": "Take damage or click: ", "color": "gray"}, {"text": "[⚡ Self Damage]", "color": "red", "bold": true, "clickEvent": {"action": "run_command", "value": "/damage @s 1"}, "hoverEvent": {"action": "show_text", "contents": ["Deals 1 damage to test onDamage"]}}, "\n"]

tellraw @s ["", {"text": "Step 4 [onEntityKill]: ", "color": "yellow", "bold": true}, {"text": "Kill a mob or click: ", "color": "gray"}, {"text": "[⚔️ Spawn 1-HP Zombie]", "color": "green", "bold": true, "clickEvent": {"action": "run_command", "value": "/summon zombie ~ ~ ~ {Health:1f}"}, "hoverEvent": {"action": "show_text", "contents": ["Spawns a 1-HP Zombie to kill"]}}, "\n"]

tellraw @s ["", {"text": "Step 5 [onDeath & onJoin]: ", "color": "yellow", "bold": true}, {"text": "Die or rejoin world to test death/join callbacks.\n\n", "color": "gray"}]

tellraw @s ["", {"text": "▶ WHEN DONE: ", "color": "yellow", "bold": true}, {"text": "[CLICK HERE TO SEE TEST REPORT]", "color": "green", "bold": true, "clickEvent": {"action": "run_command", "value": "/function fb:event/test_finish"}, "hoverEvent": {"action": "show_text", "contents": ["Displays report card with PASSED / FAILED results"]}}, "\n"]
tellraw @s ["", {"text": "=======================================", "color": "yellow", "bold": true}]
