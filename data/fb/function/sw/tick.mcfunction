data modify storage fb:tmp sw set from storage fb:main sw
execute if data storage fb:config {debug: 1b} if data storage fb:tmp sw.list[0] run tellraw @a [{"text": "[FB DEBUG] sw/tick starting loop, active: ", "color": "gray"}, {"nbt": "sw.list", "storage": "fb:tmp"}]
execute if data storage fb:tmp sw.list[0] run function fb:sw/loop