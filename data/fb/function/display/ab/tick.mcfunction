# Create tmp users
data modify storage fb:tmp display.players set from storage fb:config display

# Start loop
execute if data storage fb:tmp display.players[0] run function fb:display/ab/loop