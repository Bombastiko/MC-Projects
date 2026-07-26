# Render countdown config
# Arguments: key, cd, format

$execute if data storage fb:config {debug:{cd:1b}} run tellraw @a [{"text": "[FB DEBUG] cd_single for ", "color": "gray"}, {"text": "$(player)", "color": "white"}, {"text": ", cd: ", "color": "gray"}, {"text": "$(cd)", "color": "white"}]

$function fb:display/ab/cd_single_$(format) with storage fb:config display."$(key)".ab
