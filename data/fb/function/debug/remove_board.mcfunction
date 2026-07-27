# FuseBox Debug System - Despawn Floating Live Text Display Hologram
# Executed as player (@s)

kill @e[tag=fb.debug_board]

tellraw @s ["", {"text": "[FuseBox] ", "color": "yellow", "bold": true}, {"text": "Despawned Live Debug Board.", "color": "red"}]
