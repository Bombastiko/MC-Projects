# Custom display config
$data modify storage fb:config display.$(player).ab set value {type: 0, player: "$(player)", sw: "$(sw)", format: "$(format)", color: "$(color)", color_sec: "$(color_sec)", color_num: "$(color_num)", prefix: "$(prefix)", suffix: "$(suffix)", bold: "$(bold)"}

# If player is @a, redirect selector to filter out players with custom config
$execute if data storage fb:config display.@a.ab run data modify storage fb:config display.@a.ab.player set value "@a[tag=!fb.ab.custom]"

# Tag individual player so global config doesn't show to them
$execute unless data storage fb:config display.$(player).ab{player: "@a"} run tag $(player) add fb.ab.custom

$data remove storage fb:config players[{player: "$(player)"}]
$data modify storage fb:config players append value {player: "$(player)"}
