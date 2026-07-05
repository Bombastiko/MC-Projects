data modify storage fb:tmp cd set from storage fb:main cd
execute if data storage fb:config {debug:{cd:1b}} if data storage fb:tmp cd.list[0] run tellraw @a [{"text": "[FB DEBUG] cd/tick starting loop, active: ", "color": "gray"}, {"nbt": "cd.list", "storage": "fb:tmp"}]
execute if data storage fb:tmp cd.list[0] run function fb:cd/loop
