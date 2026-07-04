# Debug
$tellraw @a [{"text": "[FB DEBUG] distribute_single for ", "color": "gray"}, {"text": "$(player)", "color": "white"}]

# Route to sw_single
$execute if data storage fb:config display.$(player).ab{type: 0} run function fb:display/ab/sw_single with storage fb:config display.$(player).ab