# FuseBox Event System - Automated Assertion Report Card
# Executed as player (@s)

tellraw @s ["", {"text": "\n=== FuseBox Event Automated Test Report ===\n", "color": "yellow", "bold": true}]

# 1. onJoin
execute if score @s fb.t_join matches 1.. run tellraw @s ["", {"text": " [PASSED] ", "color": "green", "bold": true}, {"text": "onJoin (Command): ", "color": "gold"}, {"score": {"name": "@s", "objective": "fb.t_join"}, "color": "white"}, {"text": " triggers.", "color": "gray"}]
execute unless score @s fb.t_join matches 1.. run tellraw @s ["", {"text": " [FAILED] ", "color": "red", "bold": true}, {"text": "onJoin (Command): ", "color": "gold"}, {"text": "0 triggers.", "color": "red"}]

# 2. onDeath
execute if score @s fb.t_death matches 1.. run tellraw @s ["", {"text": " [PASSED] ", "color": "green", "bold": true}, {"text": "onDeath (Command): ", "color": "gold"}, {"score": {"name": "@s", "objective": "fb.t_death"}, "color": "white"}, {"text": " triggers.", "color": "gray"}]
execute unless score @s fb.t_death matches 1.. run tellraw @s ["", {"text": " [FAILED] ", "color": "red", "bold": true}, {"text": "onDeath (Command): ", "color": "gold"}, {"text": "0 triggers.", "color": "red"}]

# 3. onDamage
execute if score @s fb.t_dmg matches 1.. run tellraw @s ["", {"text": " [PASSED] ", "color": "green", "bold": true}, {"text": "onDamage (Command): ", "color": "gold"}, {"score": {"name": "@s", "objective": "fb.t_dmg"}, "color": "white"}, {"text": " triggers.", "color": "gray"}]
execute unless score @s fb.t_dmg matches 1.. run tellraw @s ["", {"text": " [FAILED] ", "color": "red", "bold": true}, {"text": "onDamage (Command): ", "color": "gold"}, {"text": "0 triggers.", "color": "red"}]

# 4. onEntityKill
execute if score @s fb.t_kill matches 1.. run tellraw @s ["", {"text": " [PASSED] ", "color": "green", "bold": true}, {"text": "onEntityKill (Command): ", "color": "gold"}, {"score": {"name": "@s", "objective": "fb.t_kill"}, "color": "white"}, {"text": " triggers.", "color": "gray"}]
execute unless score @s fb.t_kill matches 1.. run tellraw @s ["", {"text": " [FAILED] ", "color": "red", "bold": true}, {"text": "onEntityKill (Command): ", "color": "gold"}, {"text": "0 triggers.", "color": "red"}]

# 5. whileOnline
execute if score @s fb.t_online matches 1.. run tellraw @s ["", {"text": " [PASSED] ", "color": "green", "bold": true}, {"text": "whileOnline (Command): ", "color": "gold"}, {"score": {"name": "@s", "objective": "fb.t_online"}, "color": "white"}, {"text": " ticks.", "color": "gray"}]
execute unless score @s fb.t_online matches 1.. run tellraw @s ["", {"text": " [FAILED] ", "color": "red", "bold": true}, {"text": "whileOnline (Command): ", "color": "gold"}, {"text": "0 ticks.", "color": "red"}]

# 6. onRightClick (Command)
execute if score @s fb.t_rc_cmd matches 1.. run tellraw @s ["", {"text": " [PASSED] ", "color": "green", "bold": true}, {"text": "onRightClick (Command + NBT): ", "color": "gold"}, {"score": {"name": "@s", "objective": "fb.t_rc_cmd"}, "color": "white"}, {"text": " triggers.", "color": "gray"}]
execute unless score @s fb.t_rc_cmd matches 1.. run tellraw @s ["", {"text": " [FAILED] ", "color": "red", "bold": true}, {"text": "onRightClick (Command + NBT): ", "color": "gold"}, {"text": "0 triggers.", "color": "red"}]

# 7. onRightClick (Function)
execute if score @s fb.t_rc_fn matches 1.. run tellraw @s ["", {"text": " [PASSED] ", "color": "green", "bold": true}, {"text": "onRightClick (Function Call + NBT): ", "color": "gold"}, {"score": {"name": "@s", "objective": "fb.t_rc_fn"}, "color": "white"}, {"text": " triggers.", "color": "gray"}]
execute unless score @s fb.t_rc_fn matches 1.. run tellraw @s ["", {"text": " [FAILED] ", "color": "red", "bold": true}, {"text": "onRightClick (Function Call + NBT): ", "color": "gold"}, {"text": "0 triggers.", "color": "red"}]

# 8. onHoldItem (Command)
execute if score @s fb.t_hold_cmd matches 1.. run tellraw @s ["", {"text": " [PASSED] ", "color": "green", "bold": true}, {"text": "onHoldItem (Command + NBT): ", "color": "gold"}, {"score": {"name": "@s", "objective": "fb.t_hold_cmd"}, "color": "white"}, {"text": " ticks.", "color": "gray"}]
execute unless score @s fb.t_hold_cmd matches 1.. run tellraw @s ["", {"text": " [FAILED] ", "color": "red", "bold": true}, {"text": "onHoldItem (Command + NBT): ", "color": "gold"}, {"text": "0 ticks.", "color": "red"}]

# 9. onHoldItem (Function)
execute if score @s fb.t_hold_fn matches 1.. run tellraw @s ["", {"text": " [PASSED] ", "color": "green", "bold": true}, {"text": "onHoldItem (Function Call + NBT): ", "color": "gold"}, {"score": {"name": "@s", "objective": "fb.t_hold_fn"}, "color": "white"}, {"text": " ticks.", "color": "gray"}]
execute unless score @s fb.t_hold_fn matches 1.. run tellraw @s ["", {"text": " [FAILED] ", "color": "red", "bold": true}, {"text": "onHoldItem (Function Call + NBT): ", "color": "gold"}, {"text": "0 ticks.", "color": "red"}]

tellraw @s ["", {"text": "===========================================", "color": "yellow", "bold": true}]
