# Event System Setup
# Register scoreboard objectives for event detection

# Leave Game detection (for onJoin detection of returning players)
scoreboard objectives add fb.leave minecraft.custom:minecraft.leave_game

# Death detection (for onDeath)
scoreboard objectives add fb.death minecraft.custom:minecraft.deaths

# Player kills detection (for onKillPlayer)
scoreboard objectives add fb.kill_p minecraft.custom:minecraft.player_kills

# Killed by player detection (for onKilledByPlayer)
scoreboard objectives add fb.killed_by_p minecraft.killed_by:minecraft.player

# Right-click item detection
scoreboard objectives add fb.rc_stick minecraft.used:minecraft.carrot_on_a_stick
scoreboard objectives add fb.rc_fungus minecraft.used:minecraft.warped_fungus_on_a_stick


