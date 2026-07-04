# Check if player is @a
$data modify storage fb:tmp check set value [{name: "$(player)"}]

# Setup config values in temporary storage
data modify storage fb:tmp config_setup set value {key: "global", target: "@a[tag=!fb.ab.custom]", is_global: 1b}
$data modify storage fb:tmp global_check set value [{type: "$(global_type)"}]

# If player is @a and global_type is hard, change target to @a
execute if data storage fb:tmp check[{name:"@a"}] if data storage fb:tmp global_check[{type:"hard"}] run data modify storage fb:tmp config_setup.target set value "@a"

$execute unless data storage fb:tmp check[{name:"@a"}] run data modify storage fb:tmp config_setup set value {key: "$(player)", target: "$(player)", is_global: 0b, global_type: "none"}

# Copy formatting parameters to config_setup
$data modify storage fb:tmp config_setup.sw set value "$(sw)"
$data modify storage fb:tmp config_setup.format set value "$(format)"
$data modify storage fb:tmp config_setup.color set value "$(color)"
$data modify storage fb:tmp config_setup.color_sec set value "$(color_sec)"
$data modify storage fb:tmp config_setup.color_num set value "$(color_num)"
$data modify storage fb:tmp config_setup.prefix set value "$(prefix)"
$data modify storage fb:tmp config_setup.suffix set value "$(suffix)"
$data modify storage fb:tmp config_setup.bold set value "$(bold)"

# Run helper
function fb:sw/display_ab_setup_helper with storage fb:tmp config_setup
