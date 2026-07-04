# Custom display config
$data modify storage fb:config display.$(player).ab set value {type: 0, player: "$(player)", sw: "$(sw)", format: "$(format)", color: "$(color)", color_sec: "$(color_sec)", color_num: "$(color_num)", prefix: "$(prefix)", suffix: "$(suffix)", bold: "$(bold)"}

$data remove storage fb:config players[{player: "$(player)"}]
$data modify storage fb:config players append value {player: "$(player)"}
