# Render actionbar overwrite NBT text directly
# Arguments: player

# Display the NBT formatted JSON array directly on the actionbar
$title @s actionbar {"nbt": "[\"$(player)\"].text", "storage": "fb:overwrite"}
