# Route stopwatch display to the specific format sub-function (ab)
# Context: fb:config display.$(player)
# Macro parameters: $(player), $(ab.sw), $(ab.format)

$function fb:display/ab/sw_single_$(ab.format) with storage fb:config display.$(player)
