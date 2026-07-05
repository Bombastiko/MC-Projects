# Render actionbar overwrite NBT text directly with formatting interpreted
# Arguments: player

# Display the NBT formatted JSON array directly on the actionbar, interpreting it as JSON text
$title @s actionbar {"nbt": "$(player).text", "storage": "fb:overwrite", "interpret": true}
