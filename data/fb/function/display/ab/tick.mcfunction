# Copy active players with display config to tmp storage (ab)
data modify storage fb:tmp display.players set from storage fb:config players

# Start loop through all players
execute if data storage fb:tmp display.players[0] run function fb:display/ab/loop