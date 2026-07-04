# Route stopwatch display to the specific format sub-function (ab)
# Context: fb:config display.$(player).ab
# Macro parameters: $(player), $(sw), $(format)

$function fb:display/ab/sw_single_$(format) with storage fb:config display.$(player).ab
