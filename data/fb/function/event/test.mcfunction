# FuseBox Event System - 100% Automated Silent Test Suite
# Executed as player (@s)

# 1. Completely Mute Debug Logging During Test
data modify storage fb:config debug.global set value 0b
data modify storage fb:config debug.event set value 0b
data modify storage fb:config debug.event_only_success set value 0b
data modify storage fb:config debug.event_rc set value 0b
data modify storage fb:config debug.event_hold set value 0b

# 2. Reset Database & Setup Scoreboard Objectives
function fb:event/reset_db

scoreboard objectives add fb.t_join dummy
scoreboard objectives add fb.t_death dummy
scoreboard objectives add fb.t_dmg dummy
scoreboard objectives add fb.t_kill dummy
scoreboard objectives add fb.t_online dummy
scoreboard objectives add fb.t_rc_cmd dummy
scoreboard objectives add fb.t_rc_fn dummy
scoreboard objectives add fb.t_hold_cmd dummy
scoreboard objectives add fb.t_hold_fn dummy

scoreboard players set @s fb.t_join 0
scoreboard players set @s fb.t_death 0
scoreboard players set @s fb.t_dmg 0
scoreboard players set @s fb.t_kill 0
scoreboard players set @s fb.t_online 0
scoreboard players set @s fb.t_rc_cmd 0
scoreboard players set @s fb.t_rc_fn 0
scoreboard players set @s fb.t_hold_cmd 0
scoreboard players set @s fb.t_hold_fn 0

# 3. Register All Event Callbacks (Command & Function Variants)
function fb:event/register_cmd {event:"onJoin", cmd:"scoreboard players add @s fb.t_join 1"}
function fb:event/register_cmd {event:"onDeath", cmd:"scoreboard players add @s fb.t_death 1"}
function fb:event/register_cmd {event:"onDamage", cmd:"scoreboard players add @s fb.t_dmg 1"}
function fb:event/register_cmd {event:"onEntityKill", cmd:"scoreboard players add @s fb.t_kill 1"}
function fb:event/register_cmd {event:"whileOnline", cmd:"scoreboard players add @s fb.t_online 1"}

function fb:event/register_item_cmd {event:"onRightClick", item_id:"minecraft:carrot_on_a_stick", custom_data:{id:"test_rc"}, fn:"scoreboard players add @s fb.t_rc_cmd 1"}
function fb:event/register_item {event:"onRightClick", item_id:"minecraft:carrot_on_a_stick", custom_data:{id:"test_rc"}, fn:"fb:event/test_rc_callback"}

function fb:event/register_item_cmd {event:"onHoldItem", item_id:"minecraft:stick", custom_data:{id:"test_hold"}, fn:"scoreboard players add @s fb.t_hold_cmd 1"}
function fb:event/register_item {event:"onHoldItem", item_id:"minecraft:stick", custom_data:{id:"test_hold"}, fn:"fb:event/test_hold_callback"}

# 4. Automate Trigger Sequence

# 4a. Give test items to mainhand
item replace entity @s weapon.mainhand with minecraft:carrot_on_a_stick[custom_data={id:"test_rc"}] 1

# 4b. Trigger Join, Death, Damage & Tick Events
function fb:event/trigger_join
function fb:event/trigger_death
function fb:event/trigger_damage
function fb:event/run_while_online_callbacks

# 4c. Trigger Entity Kill Event
summon pig ~ ~ ~ {Tags:["fb_test_pig"]}
kill @e[type=pig,tag=fb_test_pig]

# 4d. Trigger RightClick Event
function fb:event/trigger_right_click

# 4e. Trigger HoldItem Event with stick
item replace entity @s weapon.mainhand with minecraft:stick[custom_data={id:"test_hold"}] 1
function fb:event/trigger_hold

# 5. Automatically Finish & Output Assertion Report Card
function fb:event/test_finish
