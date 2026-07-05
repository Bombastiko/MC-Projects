# Event system debug info
tellraw @a ["", {"text": "=== FuseBox Event System Debug Info ===", "color": "yellow", "bold": true}]
tellraw @a ["", {"text": "Registered Events: ", "color": "gold"}, {"nbt": "", "storage": "fb:events", "color": "white"}]
tellraw @a ["", {"text": "Player Event Scores: ", "color": "gold"}]
execute as @a run tellraw @a ["", {"text": "  ", "color": "gray"}, {"selector": "@s"}, {"text": " - fb.leave: ", "color": "gray"}, {"score": {"name": "@s", "objective": "fb.leave"}, "color": "white"}, {"text": " - fb.death: ", "color": "gray"}, {"score": {"name": "@s", "objective": "fb.death"}, "color": "white"}, {"text": " - fb.kill_p: ", "color": "gray"}, {"score": {"name": "@s", "objective": "fb.kill_p"}, "color": "white"}, {"text": " - fb.killed_by_p: ", "color": "gray"}, {"score": {"name": "@s", "objective": "fb.killed_by_p"}, "color": "white"}]
tellraw @a ["", {"text": "========================================", "color": "yellow", "bold": true}]
