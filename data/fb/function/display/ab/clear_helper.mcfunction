# Clear actionbar config helper
$data remove storage fb:config display.$(key)
$data remove storage fb:config players[{key: "$(key)"}]
$tag $(target) remove fb.ab.custom
$title $(target) actionbar ""
