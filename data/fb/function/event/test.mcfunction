# FuseBox Event System - Automated Test Suite
# Executed as player (@s)

# 1. Reset event database
function fb:event/reset-db

# 2. Enable Event Debugging & Verbose Mode
data modify storage fb:config debug.event set value 1b
data modify storage fb:config debug.event_only_success set value 0b
data modify storage fb:config debug.event_show_matcher set value 1b
data modify storage fb:config debug.event_show_register set value 1b
data modify storage fb:config debug.event_hold set value 1b
data modify storage fb:config debug.event_rc set value 1b

# 3. Register test callbacks
function fb:event/register_item_cmd {event:"onRightClick", cmd:"tellraw @a [\"\",{\"text\":\"[TEST SUCCESS] FIRE WAND EXECUTED!\",\"color\":\"red\",\"bold\":true}]", item_id:"minecraft:carrot_on_a_stick", custom_data:{wand_type:"fire"}}
function fb:event/register_item_cmd {event:"onRightClick", cmd:"tellraw @a [\"\",{\"text\":\"[TEST SUCCESS] ICE WAND EXECUTED!\",\"color\":\"aqua\",\"bold\":true}]", item_id:"minecraft:carrot_on_a_stick", custom_data:{wand_type:"ice"}}
function fb:event/register_item_cmd {event:"onHoldItem", cmd:"title @s actionbar [\"\",{\"text\":\"[TEST SUCCESS] HOLDING SPEED STICK!\",\"color\":\"green\",\"bold\":true}]", item_id:"minecraft:stick", custom_data:{wand_type:"speed"}}

# 4. Give player test items
give @s minecraft:carrot_on_a_stick[custom_data={wand_type:"fire"},item_name='"Fire Wand"'] 1
give @s minecraft:carrot_on_a_stick[custom_data={wand_type:"ice"},item_name='"Ice Wand"'] 1
give @s minecraft:stick[custom_data={wand_type:"speed"},item_name='"Speed Stick"'] 1

# 5. Output Test Suite Instructions
tellraw @s ["", {"text": "\n=== FuseBox Automated Test Suite Initialized ===\n", "color": "yellow", "bold": true}]
tellraw @s ["", {"text": "3 Test Items given to your inventory:\n", "color": "gold"}]
tellraw @s ["", {"text": " 1. Fire Wand (Carrot on a Stick with wand_type:fire)\n", "color": "red"}]
tellraw @s ["", {"text": "    -> Right-click: Should execute Fire Wand ONLY.\n", "color": "gray"}]
tellraw @s ["", {"text": " 2. Ice Wand (Carrot on a Stick with wand_type:ice)\n", "color": "aqua"}]
tellraw @s ["", {"text": "    -> Right-click: Should execute Ice Wand ONLY.\n", "color": "gray"}]
tellraw @s ["", {"text": " 3. Speed Stick (Stick with wand_type:speed)\n", "color": "green"}]
tellraw @s ["", {"text": "    -> Hold in hand: Should display actionbar message.\n", "color": "gray"}]
tellraw @s ["", {"text": "Run ", "color": "gold"}, {"text": "/function fb:event/debug_info", "color": "white", "clickEvent": {"action": "run_command", "value": "/function fb:event/debug_info"}}, {"text": " to inspect database NBT.", "color": "gold"}]
tellraw @s ["", {"text": "================================================", "color": "yellow", "bold": true}]
