# Resolve executing player's name as a string

# Set default fallback name
data modify storage fb:tmp event_context.player set value "player"

# Summon a temporary chest minecart far below the player (safely in the void)
execute at @s run summon minecraft:chest_minecart ~ ~-64 ~ {Tags: ["fb.temp_name_holder"], Invulnerable: 1b, NoGravity: 1b, Invisible: 1b}

# Loot a player head into the minecart (fills with player profile)
execute as @s run loot replace entity @e[tag=fb.temp_name_holder,limit=1] container.0 loot fb:player_head

# Copy resolved name from profile component (1.20.5+)
data modify storage fb:tmp event_context.player set from entity @e[tag=fb.temp_name_holder,limit=1] Items[0].components."minecraft:profile".name

# Copy resolved name from legacy SkullOwner tag (1.20 and below)
execute unless data storage fb:tmp event_context.player run data modify storage fb:tmp event_context.player set from entity @e[tag=fb.temp_name_holder,limit=1] Items[0].tag.SkullOwner.Name

# Clean up minecart
kill @e[tag=fb.temp_name_holder]
