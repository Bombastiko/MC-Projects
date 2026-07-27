# FuseBox Event System - Match Callback Filter Macro
# Macro Arguments: item_id, custom_data, has_item_filter, has_cd_filter
# Executed as player (@s)

# 1. Initialize match results and temporary flags
data modify storage fb:tmp match_result set value {val: 0b, hand: "none"}
data modify storage fb:tmp match_flags set value {m_item: 1b, m_cd: 1b, o_item: 1b, o_cd: 1b}

# 2. Check if this callback has any item/NBT requirements at all
execute if data storage fb:tmp current_callback{has_item_filter: 0b, has_cd_filter: 0b} run data modify storage fb:tmp match_result.val set value 1b
execute if data storage fb:tmp current_callback{has_item_filter: 0b, has_cd_filter: 0b} run return 1

# 3. MAINHAND EVALUATION
# 3a. Mainhand Item ID match
$execute if data storage fb:tmp current_callback{has_item_filter: 1b} unless data storage fb:tmp player_items{mainhand: {id: "$(item_id)"}} unless data storage fb:tmp player_items{mainhand: {id: "minecraft:$(item_id)"}} run data modify storage fb:tmp match_flags.m_item set value 0b

# 3b. Mainhand Custom Data match
$execute if data storage fb:tmp current_callback{has_cd_filter: 1b} unless data storage fb:tmp {player_items: {mainhand: {custom_data: $(custom_data)}}} run data modify storage fb:tmp match_flags.m_cd set value 0b

# 3c. Evaluate Mainhand overall match
execute if data storage fb:tmp match_flags{m_item: 1b, m_cd: 1b} run data modify storage fb:tmp match_result set value {val: 1b, hand: "mainhand"}
execute if data storage fb:tmp match_result{val: 1b} run return 1

# 4. OFFHAND EVALUATION (if mainhand did not match)
# 4a. Offhand Item ID match
$execute if data storage fb:tmp current_callback{has_item_filter: 1b} unless data storage fb:tmp player_items{offhand: {id: "$(item_id)"}} unless data storage fb:tmp player_items{offhand: {id: "minecraft:$(item_id)"}} run data modify storage fb:tmp match_flags.o_item set value 0b

# 4b. Offhand Custom Data match
$execute if data storage fb:tmp current_callback{has_cd_filter: 1b} unless data storage fb:tmp {player_items: {offhand: {custom_data: $(custom_data)}}} run data modify storage fb:tmp match_flags.o_cd set value 0b

# 4c. Evaluate Offhand overall match
execute if data storage fb:tmp match_flags{o_item: 1b, o_cd: 1b} run data modify storage fb:tmp match_result set value {val: 1b, hand: "offhand"}
