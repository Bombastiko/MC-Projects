function fb:sw/tick
function fb:cd/tick
function fb:display/ab/tick
function fb:event/tick

# Process debug menu triggers
scoreboard players enable @a fb.debug.tg
execute as @a[scores={fb.debug.tg=1}] run function fb:debug/toggle_global
execute as @a[scores={fb.debug.tg=1}] run scoreboard players set @s fb.debug.tg 0

execute as @a[scores={fb.debug.tg=2}] run function fb:debug/toggle_sw
execute as @a[scores={fb.debug.tg=2}] run scoreboard players set @s fb.debug.tg 0

execute as @a[scores={fb.debug.tg=3}] run function fb:debug/toggle_cd
execute as @a[scores={fb.debug.tg=3}] run scoreboard players set @s fb.debug.tg 0

execute as @a[scores={fb.debug.tg=4}] run function fb:debug/toggle_event
execute as @a[scores={fb.debug.tg=4}] run scoreboard players set @s fb.debug.tg 0

execute as @a[scores={fb.debug.tg=5}] run function fb:debug/toggle_event_only_success
execute as @a[scores={fb.debug.tg=5}] run scoreboard players set @s fb.debug.tg 0

execute as @a[scores={fb.debug.tg=6}] run function fb:debug/toggle_event_show_matcher
execute as @a[scores={fb.debug.tg=6}] run scoreboard players set @s fb.debug.tg 0

execute as @a[scores={fb.debug.tg=7}] run function fb:debug/toggle_event_show_register
execute as @a[scores={fb.debug.tg=7}] run scoreboard players set @s fb.debug.tg 0