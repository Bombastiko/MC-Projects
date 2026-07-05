execute if data storage fb:config {debug:{sw:1b}} run tellraw @a [{"text": "[FB DEBUG] sw/loop processing: ", "color": "gray"}, {"nbt": "sw.list[0]", "storage": "fb:tmp"}]
function fb:sw/process_single with storage fb:tmp sw.list[0]
data remove storage fb:tmp sw.list[0]
execute if data storage fb:tmp sw.list[0] run function fb:sw/loop