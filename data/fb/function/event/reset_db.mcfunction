# Reset all FuseBox Event Registrations & Storages
data remove storage fb:events onJoin
data remove storage fb:events onDeath
data remove storage fb:events onLeave
data remove storage fb:events onKillPlayer
data remove storage fb:events onKilledByPlayer
data remove storage fb:events onDamage
data remove storage fb:events onEntityKill
data remove storage fb:events onRightClick
data remove storage fb:events onHoldItem
data remove storage fb:events whileOnline
data remove storage fb:events whileOffline
data remove storage fb:events online_players

data remove storage fb:tmp event_context
data remove storage fb:tmp current_callback
data remove storage fb:tmp cb_entry
data remove storage fb:tmp live_cd
data remove storage fb:tmp item_cd
data remove storage fb:tmp item_components
data remove storage fb:tmp event_match
data remove storage fb:tmp check_cd

# Disable event debug toggles
data modify storage fb:config debug.event set value 0b
data modify storage fb:config debug.event_show_register set value 0b
data modify storage fb:config debug.event_show_matcher set value 0b

# Reset event scoreboards for all players
scoreboard players set @a fb.rc_stick 0
scoreboard players set @a fb.rc_fungus 0
scoreboard players set @a fb.kill_p 0
scoreboard players set @a fb.killed_by_p 0
scoreboard players set @a fb.death 0
scoreboard players set @a fb.leave 0
scoreboard players set @a fb.dmg_taken 0
scoreboard players set @a fb.mob_kills 0

tellraw @a ["", {"text": "[FuseBox] ", "color": "yellow", "bold": true}, {"text": "Successfully cleared all registered events and reset event databases.", "color": "green"}]
