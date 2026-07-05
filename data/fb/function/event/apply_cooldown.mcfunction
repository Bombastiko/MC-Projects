# Apply item cooldown to player
# Arguments: player, item_id, cooldown

# Run native cooldown command as the event player
$execute as $(player) run item cooldown @s $(item_id) $(cooldown)
