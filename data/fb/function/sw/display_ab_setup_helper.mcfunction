# Setup display config helper
$data modify storage fb:config display."$(key)".ab set value {type: 0, player: "$(target)", key: "$(key)", sw: "$(sw)", format: "$(format)", color: "$(color)", color_sec: "$(color_sec)", color_num: "$(color_num)", prefix: "$(prefix)", suffix: "$(suffix)", bold: "$(bold)", global_type: "$(global_type)"}

# Copy is_global to a temporary check list
data modify storage fb:tmp global_check set value [{val: 0b}]
data modify storage fb:tmp global_check[0].val set from storage fb:tmp config_setup.is_global

# Tag individual player if not global (is_global == 0b)
$execute if data storage fb:tmp global_check[{val:0b}] run tag $(target) add fb.ab.custom

# Update players list
$data remove storage fb:config players[{key: "$(key)"}]
$data modify storage fb:config players append value {player: "$(target)", key: "$(key)"}
