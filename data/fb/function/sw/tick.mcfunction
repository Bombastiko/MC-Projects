# Create tmp list
data modify storage fb:tmp sw.list set from storage fb:main sw.list

# Start loop
execute if data storage fb:tmp sw.list[0] run function fb:sw/loop