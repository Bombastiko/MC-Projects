$execute if data storage fb:config {debug: 1b} run tellraw @a [{"text": "[FB DEBUG] distribute_single for ", "color": "gray"}, {"text": "$(player)", "color": "white"}]

$data modify storage fb:tmp check set value [{key: "$(key)"}]

# Global config - always executes if it exists
execute if data storage fb:tmp check[{key:"global"}] if data storage fb:config display.global.ab run function fb:display/ab/route_single with storage fb:config display.global.ab

# Individual config - executes if it exists and hard global is NOT active
$execute unless data storage fb:tmp check[{key:"global"}] if data storage fb:config display."$(key)".ab unless data storage fb:tmp global_check[{type:"hard"}] run function fb:display/ab/route_single with storage fb:config display."$(key)".ab