# Save overwrite NBT and activate scoreboard timer
# Arguments: player, text, duration

# Store text in storage under player's name (unquoted path segment)
$data modify storage fb:overwrite $(player).text set value $(text)

# Set the overwrite timer score on the player
$scoreboard players set @s fb.ab_over $(duration)
