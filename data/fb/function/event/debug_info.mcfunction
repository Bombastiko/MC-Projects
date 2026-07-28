# FuseBox Event System Debug Info
tellraw @a ["", {"text": "=== FuseBox Event System Registry Inspection ===", "color": "yellow", "bold": true}]

execute if data storage fb:events onRightClick[0] run tellraw @a ["", {"text": "  onRightClick: ", "color": "gold"}, {"nbt": "onRightClick", "storage": "fb:events", "color": "white"}]
execute unless data storage fb:events onRightClick[0] run tellraw @a ["", {"text": "  onRightClick: ", "color": "gray"}, {"text": "(None registered)", "color": "dark_gray"}]

execute if data storage fb:events onHoldItem[0] run tellraw @a ["", {"text": "  onHoldItem: ", "color": "gold"}, {"nbt": "onHoldItem", "storage": "fb:events", "color": "white"}]
execute unless data storage fb:events onHoldItem[0] run tellraw @a ["", {"text": "  onHoldItem: ", "color": "gray"}, {"text": "(None registered)", "color": "dark_gray"}]

execute if data storage fb:events onJoin[0] run tellraw @a ["", {"text": "  onJoin: ", "color": "gold"}, {"nbt": "onJoin", "storage": "fb:events", "color": "white"}]
execute unless data storage fb:events onJoin[0] run tellraw @a ["", {"text": "  onJoin: ", "color": "gray"}, {"text": "(None registered)", "color": "dark_gray"}]

execute if data storage fb:events onDeath[0] run tellraw @a ["", {"text": "  onDeath: ", "color": "gold"}, {"nbt": "onDeath", "storage": "fb:events", "color": "white"}]
execute unless data storage fb:events onDeath[0] run tellraw @a ["", {"text": "  onDeath: ", "color": "gray"}, {"text": "(None registered)", "color": "dark_gray"}]

execute if data storage fb:events onLeave[0] run tellraw @a ["", {"text": "  onLeave: ", "color": "gold"}, {"nbt": "onLeave", "storage": "fb:events", "color": "white"}]
execute unless data storage fb:events onLeave[0] run tellraw @a ["", {"text": "  onLeave: ", "color": "gray"}, {"text": "(None registered)", "color": "dark_gray"}]

execute if data storage fb:events onKillPlayer[0] run tellraw @a ["", {"text": "  onKillPlayer: ", "color": "gold"}, {"nbt": "onKillPlayer", "storage": "fb:events", "color": "white"}]
execute unless data storage fb:events onKillPlayer[0] run tellraw @a ["", {"text": "  onKillPlayer: ", "color": "gray"}, {"text": "(None registered)", "color": "dark_gray"}]

execute if data storage fb:events onKilledByPlayer[0] run tellraw @a ["", {"text": "  onKilledByPlayer: ", "color": "gold"}, {"nbt": "onKilledByPlayer", "storage": "fb:events", "color": "white"}]
execute unless data storage fb:events onKilledByPlayer[0] run tellraw @a ["", {"text": "  onKilledByPlayer: ", "color": "gray"}, {"text": "(None registered)", "color": "dark_gray"}]

execute if data storage fb:events onDamage[0] run tellraw @a ["", {"text": "  onDamage: ", "color": "gold"}, {"nbt": "onDamage", "storage": "fb:events", "color": "white"}]
execute unless data storage fb:events onDamage[0] run tellraw @a ["", {"text": "  onDamage: ", "color": "gray"}, {"text": "(None registered)", "color": "dark_gray"}]

execute if data storage fb:events onEntityKill[0] run tellraw @a ["", {"text": "  onEntityKill: ", "color": "gold"}, {"nbt": "onEntityKill", "storage": "fb:events", "color": "white"}]
execute unless data storage fb:events onEntityKill[0] run tellraw @a ["", {"text": "  onEntityKill: ", "color": "gray"}, {"text": "(None registered)", "color": "dark_gray"}]

execute if data storage fb:events whileOnline[0] run tellraw @a ["", {"text": "  whileOnline: ", "color": "gold"}, {"nbt": "whileOnline", "storage": "fb:events", "color": "white"}]
execute unless data storage fb:events whileOnline[0] run tellraw @a ["", {"text": "  whileOnline: ", "color": "gray"}, {"text": "(None registered)", "color": "dark_gray"}]

execute if data storage fb:events whileOffline[0] run tellraw @a ["", {"text": "  whileOffline: ", "color": "gold"}, {"nbt": "whileOffline", "storage": "fb:events", "color": "white"}]
execute unless data storage fb:events whileOffline[0] run tellraw @a ["", {"text": "  whileOffline: ", "color": "gray"}, {"text": "(None registered)", "color": "dark_gray"}]

tellraw @a ["", {"text": "\n▶ Live In-World Hologram Display: ", "color": "yellow", "bold": true}, {"text": "[SPAWN HOLOGRAM BOARD]", "color": "green", "bold": true, "clickEvent": {"action": "run_command", "value": "/function fb:debug/spawn_board"}, "hoverEvent": {"action": "show_text", "contents": ["Spawn live text display hologram in front of you"]}}, {"text": " ", "color": "gray"}, {"text": "[DESPAWN BOARD]", "color": "red", "bold": true, "clickEvent": {"action": "run_command", "value": "/function fb:debug/remove_board"}, "hoverEvent": {"action": "show_text", "contents": ["Despawn text display hologram"]}}, "\n"]
tellraw @a ["", {"text": "===============================================", "color": "yellow", "bold": true}]
