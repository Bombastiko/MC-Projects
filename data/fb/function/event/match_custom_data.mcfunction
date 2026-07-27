# FuseBox Event System - Match Custom Data Component Filter
# Arguments: hand ("mainhand" or "offhand"), custom_data
# Executed as player (@s)

# 1. Default hand match flag to 0b
$data modify storage fb:tmp event_match.$(hand) set value 0b

# 2. If callback requires no custom_data (empty compound {}), it's an automatic match for this hand!
$execute if data storage fb:tmp {current_callback: {custom_data: {}}} run data modify storage fb:tmp event_match.$(hand) set value 1b

# 3. Perform NBT partial compound check on target hand custom_data
data modify storage fb:tmp check_cd set value {data: {}}
$data modify storage fb:tmp check_cd.data set from storage fb:tmp player_items.$(hand).custom_data
$execute if data storage fb:tmp {check_cd: {data: $(custom_data)}} run data modify storage fb:tmp event_match.$(hand) set value 1b
