# Trigger onDamage callbacks
# Executed as the player who took damage

# Reset score first
scoreboard players set @s fb.dmg_taken 0

# Run callbacks
function fb:event/run_callbacks {event: "onDamage"}
