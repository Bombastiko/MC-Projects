# Custom stopwatch display configuration (sw)
# Arguments: player, sw, format, color, color_sec, color_num, prefix, suffix, bold

# Set player display config under the ab compound
$data modify storage fb:config display.$(player).ab set value {type: 0, player: "$(player)", sw: "$(sw)", format: "$(format)", color: "$(color)", color_sec: "$(color_sec)", color_num: "$(color_num)", prefix: "$(prefix)", suffix: "$(suffix)", bold: "$(bold)"}

# Register player in active loop list
$data remove storage fb:config players[{player: "$(player)"}]
$data modify storage fb:config players append value {player: "$(player)"}
