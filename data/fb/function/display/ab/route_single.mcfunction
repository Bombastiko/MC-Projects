# Route display based on type (0 = sw, 1 = cd)
# Arguments: type, key

# Store the type dynamically in a scoreboard score to avoid NBT numeric type mismatch issues
$execute store result score #type fb.cd.state run data get storage fb:config display."$(key)".ab.type

# Route based on the score value
$execute if score #type fb.cd.state matches 0 run function fb:display/ab/sw_single with storage fb:config display."$(key)".ab
$execute if score #type fb.cd.state matches 1 run function fb:display/ab/cd_single with storage fb:config display."$(key)".ab
