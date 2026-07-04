# Recursive function for stopwatch system
function fb:sw/process_single with storage fb:tmp sw.list[0]

data remove storage fb:tmp sw.list[0]

#Loop
execute if data storage fb:tmp sw.list[0] run function fb:sw/loop