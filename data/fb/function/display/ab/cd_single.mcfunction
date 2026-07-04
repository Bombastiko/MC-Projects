# Render countdown config
# Arguments: key, cd, format

$execute if data storage fb:config {debug: 1b} run tellraw @a [{"text": "[FB DEBUG] cd_single for ", "color": "gray"}, {"text": "$(player)", "color": "white"}, {"text": ", cd: ", "color": "gray"}, {"text": "$(cd)", "color": "white"}]

# Retrieve animation type from cd.db and inject it into the display configuration compound
$data modify storage fb:tmp cd_db_anim set from storage fb:main cd.db[{name:"$(cd)"}].animation
$execute if data storage fb:tmp cd_db_anim run data modify storage fb:config display."$(key)".ab.animation set from storage fb:tmp cd_db_anim

$function fb:display/ab/cd_single_$(format) with storage fb:config display."$(key)".ab
