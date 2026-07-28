# Show FuseBox install message
# Executed by trigger_join on first join

# Mark as installed so it never displays again
data modify storage fb:config installed set value 1b

# Beautiful chat splash
tellraw @a ["", {"text": "========================================\n", "color": "yellow", "bold": true}]
tellraw @a ["", {"text": "  ⚡ FuseBox ", "color": "gold", "bold": true}, {"text": "v0.1 Alpha", "color": "yellow", "bold": true}, {"text": " has been successfully installed!\n", "color": "gray"}]
tellraw @a ["", {"text": "  Developed by ", "color": "gray"}, {"text": "Bombastiko", "color": "gold", "bold": true}, {"text": ".\n", "color": "gray"}]
tellraw @a ["", {"text": "========================================", "color": "yellow", "bold": true}]
