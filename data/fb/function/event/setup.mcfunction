# FuseBox Event System - Setup
# Register scoreboard objectives and initialize debug config

# 1. Leave Game detection (for onJoin detection of returning players)
scoreboard objectives add fb.leave minecraft.custom:minecraft.leave_game

# 2. Death detection (for onDeath)
scoreboard objectives add fb.death minecraft.custom:minecraft.deaths

# 3. Player kills detection (for onKillPlayer)
scoreboard objectives add fb.kill_p minecraft.custom:minecraft.player_kills

# 4. Killed by player detection (for onKilledByPlayer)
scoreboard objectives add fb.killed_by_p minecraft.killed_by:minecraft.player

# 5. Right-click item detection
scoreboard objectives add fb.rc_stick minecraft.used:minecraft.carrot_on_a_stick
scoreboard objectives add fb.rc_fungus minecraft.used:minecraft.warped_fungus_on_a_stick

# 6. Initialize default debug configuration (Disabled by default)
execute unless data storage fb:config debug.event run data modify storage fb:config debug.event set value 0b
execute unless data storage fb:config debug.event_only_success run data modify storage fb:config debug.event_only_success set value 1b
execute unless data storage fb:config debug.event_show_matcher run data modify storage fb:config debug.event_show_matcher set value 0b
execute unless data storage fb:config debug.event_show_register run data modify storage fb:config debug.event_show_register set value 0b
execute unless data storage fb:config debug.event_hold run data modify storage fb:config debug.event_hold set value 1b
execute unless data storage fb:config debug.event_rc run data modify storage fb:config debug.event_rc set value 1b
