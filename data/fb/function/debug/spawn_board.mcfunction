# FuseBox Debug System - Spawn Floating Live Text Display Hologram
# Executed as player (@s)

# Kill any existing debug board entity to avoid duplicates
kill @e[tag=fb.debug_board]

# Summon floating text_display entity 2 blocks in front of player
execute at @s run summon text_display ^ ^1.5 ^2 {Tags:["fb.debug_board"],billboard:"center",background:-16777216,shadow:true,text:'["",{"text":"=== FUSEBOX LIVE DEBUG BOARD ===\n","color":"yellow","bold":true},{"text":"Status: ","color":"gray"},{"text":"ACTIVE","color":"green","bold":true},{"text":"\nHold an item or right-click to inspect live data.","color":"gray"}]'}

tellraw @s ["", {"text": "[FuseBox] ", "color": "yellow", "bold": true}, {"text": "Spawned floating ", "color": "green"}, {"text": "[Live Debug Board]", "color": "gold", "bold": true}, {"text": " in front of you! Run ", "color": "green"}, {"text": "/function fb:debug/remove_board", "color": "white", "clickEvent": {"action": "run_command", "value": "/function fb:debug/remove_board"}}, {"text": " to despawn it.", "color": "green"}]
