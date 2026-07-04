# Check if player is @a
$data modify storage fb:tmp check set value [{name: "$(player)"}]

# Setup config values in temporary storage
data modify storage fb:tmp config_setup set value {key: "global", target: "@a[tag=!fb.ab.custom]"}
$execute unless data storage fb:tmp check[{name:"@a"}] run data modify storage fb:tmp config_setup set value {key: "$(player)", target: "$(player)"}

# Run clear helper
function fb:display/ab/clear_helper with storage fb:tmp config_setup
