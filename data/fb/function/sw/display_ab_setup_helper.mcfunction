# Setup display config helper
$data modify storage fb:config display.$(key).ab set value {type: 0, player: "$(target)", key: "$(key)", sw: "$(sw)", format: "$(format)", color: "$(color)", color_sec: "$(color_sec)", color_num: "$(color_num)", prefix: "$(prefix)", suffix: "$(suffix)", bold: "$(bold)"}

# Tag individual player if not global
$execute if data storage fb:tmp {config_setup:{is_global:0b}} run tag $(target) add fb.ab.custom

# Update players list
$data remove storage fb:config players[{key: "$(key)"}]
$data modify storage fb:config players append value {player: "$(target)", key: "$(key)"}
