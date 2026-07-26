# Expire countdown timer
# Arguments: name

$scoreboard players set #$(name) fb.cd.state 1
$scoreboard players set #$(name) fb.cd.t 0
$scoreboard players set #$(name) fb.cd.ms 0

# Remove from active list immediately
$data remove storage fb:main cd.list[{name:"$(name)"}]

# Copy configuration from cd.db to tmp
$data modify storage fb:tmp cd_config set from storage fb:main cd.db[{name:"$(name)"}]

# Get the command and run it
data remove storage fb:tmp cd_action
data modify storage fb:tmp cd_action.cmd set from storage fb:tmp cd_config.on_complete
execute if data storage fb:tmp cd_action.cmd run function fb:cd/run_command with storage fb:tmp cd_action
