# Debug
$tellraw @a [{"text": "[FB DEBUG] sw_single for ", "color": "gray"}, {"text": "$(player)", "color": "white"}, {"text": ", sw: ", "color": "gray"}, {"text": "$(sw)", "color": "white"}, {"text": ", format: ", "color": "gray"}, {"text": "$(format)", "color": "white"}]

# Route to format
$function fb:display/ab/sw_single_$(format) with storage fb:config display.$(player).ab
