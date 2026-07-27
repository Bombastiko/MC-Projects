# FuseBox Event System - Interactive Log Book Generator
# Executed as player (@s)

# Give written book with interactive debug pages
give @s minecraft:written_book[written_book_content={author:"FuseBox System",title:"FuseBox Debug Log",pages:['["",{"text":"=== FuseBox Log ===\\n\\n","color":"dark_purple","bold":true},{"text":"Event Debugger Active\\n\\n","color":"gray"},{"text":"[Inspect Registry]\\n","color":"blue","bold":true,"clickEvent":{"action":"run_command","value":"/function fb:event/debug_info"}},{"text":"[Run Auto Test]\\n","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/function fb:event/test"}},{"text":"[Reset Database]\\n\\n","color":"red","bold":true,"clickEvent":{"action":"run_command","value":"/function fb:event/reset_db"}},{"text":"Turn page for live item NBT.","color":"dark_gray"}]','["",{"text":"=== Live Item NBT ===\\n\\n","color":"dark_purple","bold":true},{"text":"Held Item NBT:\\n","color":"gold"},{"nbt":"item_cd","storage":"fb:tmp","color":"black"},{"text":"\\n\\nLast Match Flag:\\n","color":"gold"},{"nbt":"event_match.val","storage":"fb:tmp","color":"dark_green"}]']}] 1

tellraw @s ["", {"text": "[FuseBox] ", "color": "yellow", "bold": true}, {"text": "Given ", "color": "green"}, {"text": "[FuseBox Debug Log Book]", "color": "gold", "bold": true}, {"text": " to your inventory!", "color": "green"}]
