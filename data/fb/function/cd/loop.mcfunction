execute if data storage fb:config {debug: 1b} run tellraw @a [{"text": "[FB DEBUG] cd/loop processing: ", "color": "gray"}, {"nbt": "cd.list[0]", "storage": "fb:tmp"}]
function fb:cd/process_single with storage fb:tmp cd.list[0]
data remove storage fb:tmp cd.list[0]
execute if data storage fb:tmp cd.list[0] run function fb:cd/loop
