# Print FuseBox Debug Menu
# Executed as player

tellraw @s ["", {"text": "\n=== FuseBox Debug Menu (0.1 Alpha) ===\n", "color": "yellow", "bold": true}]

# 1. Global Debug Row
execute if data storage fb:config {debug:{global:1b}} run tellraw @s ["", {"text": "  Global: ", "color": "gold"}, {"text": "[ENABLED] ", "color": "green", "bold": true, "clickEvent": {"action": "run_command", "value": "/function fb:debug/toggle_global"}}, {"text": "[DISABLE]", "color": "gray", "clickEvent": {"action": "run_command", "value": "/function fb:debug/toggle_global"}}]
execute unless data storage fb:config {debug:{global:1b}} run tellraw @s ["", {"text": "  Global: ", "color": "gold"}, {"text": "[ENABLE] ", "color": "gray", "clickEvent": {"action": "run_command", "value": "/function fb:debug/toggle_global"}}, {"text": "[DISABLED]", "color": "red", "bold": true, "clickEvent": {"action": "run_command", "value": "/function fb:debug/toggle_global"}}]

# 2. Stopwatch Row
execute if data storage fb:config {debug:{sw:1b}} run tellraw @s ["", {"text": "  Stopwatch: ", "color": "gold"}, {"text": "[ENABLED] ", "color": "green", "bold": true, "clickEvent": {"action": "run_command", "value": "/function fb:debug/toggle_sw"}}, {"text": "[DISABLE]", "color": "gray", "clickEvent": {"action": "run_command", "value": "/function fb:debug/toggle_sw"}}]
execute unless data storage fb:config {debug:{sw:1b}} run tellraw @s ["", {"text": "  Stopwatch: ", "color": "gold"}, {"text": "[ENABLE] ", "color": "gray", "clickEvent": {"action": "run_command", "value": "/function fb:debug/toggle_sw"}}, {"text": "[DISABLED]", "color": "red", "bold": true, "clickEvent": {"action": "run_command", "value": "/function fb:debug/toggle_sw"}}]

# 3. Countdown Row
execute if data storage fb:config {debug:{cd:1b}} run tellraw @s ["", {"text": "  Countdown: ", "color": "gold"}, {"text": "[ENABLED] ", "color": "green", "bold": true, "clickEvent": {"action": "run_command", "value": "/function fb:debug/toggle_cd"}}, {"text": "[DISABLE]", "color": "gray", "clickEvent": {"action": "run_command", "value": "/function fb:debug/toggle_cd"}}]
execute unless data storage fb:config {debug:{cd:1b}} run tellraw @s ["", {"text": "  Countdown: ", "color": "gold"}, {"text": "[ENABLE] ", "color": "gray", "clickEvent": {"action": "run_command", "value": "/function fb:debug/toggle_cd"}}, {"text": "[DISABLED]", "color": "red", "bold": true, "clickEvent": {"action": "run_command", "value": "/function fb:debug/toggle_cd"}}]

# 4. Event Row
execute if data storage fb:config {debug:{event:1b}} run tellraw @s ["", {"text": "  Events: ", "color": "gold"}, {"text": "[ENABLED] ", "color": "green", "bold": true, "clickEvent": {"action": "run_command", "value": "/function fb:debug/toggle_event"}}, {"text": "[DISABLE]", "color": "gray", "clickEvent": {"action": "run_command", "value": "/function fb:debug/toggle_event"}}]
execute unless data storage fb:config {debug:{event:1b}} run tellraw @s ["", {"text": "  Events: ", "color": "gold"}, {"text": "[ENABLE] ", "color": "gray", "clickEvent": {"action": "run_command", "value": "/function fb:debug/toggle_event"}}, {"text": "[DISABLED]", "color": "red", "bold": true, "clickEvent": {"action": "run_command", "value": "/function fb:debug/toggle_event"}}]

tellraw @s ["", {"text": "========================================", "color": "yellow", "bold": true}]
