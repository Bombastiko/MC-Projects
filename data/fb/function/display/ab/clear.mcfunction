$data remove storage fb:config display.$(player)
$data remove storage fb:config players[{player: "$(player)"}]
$tag $(player) remove fb.ab.custom
$title $(player) actionbar ""
