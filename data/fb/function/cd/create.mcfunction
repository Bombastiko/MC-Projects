# Create countdown timer
# Arguments: name, h, m, s, on_complete, animation

execute unless data storage fb:main cd run data modify storage fb:main cd set value {list:[], db:[]}
execute unless data storage fb:main cd.list run data modify storage fb:main cd.list set value []
execute unless data storage fb:main cd.db run data modify storage fb:main cd.db set value []

# Set initial scoreboard values
$scoreboard players set #$(name) fb.cd.h $(h)
$scoreboard players set #$(name) fb.cd.m $(m)
$scoreboard players set #$(name) fb.cd.s $(s)
$scoreboard players set #$(name) fb.cd.t 0
$scoreboard players set #$(name) fb.cd.ms 0
$scoreboard players set #$(name) fb.cd.anim 0
$scoreboard players set #$(name) fb.cd.state 0

# Remove old NBT configs
$data remove storage fb:main cd.list[{name:"$(name)"}]
$data remove storage fb:main cd.db[{name:"$(name)"}]

# Append to db (stores static configuration: command, animation)
$data modify storage fb:main cd.db append value {name: "$(name)", on_complete: "$(on_complete)", animation: "$(animation)"}

# Append to active list (start running immediately)
$data modify storage fb:main cd.list append value {name: "$(name)"}
