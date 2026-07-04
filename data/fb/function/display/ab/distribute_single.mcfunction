$execute if data storage fb:config {debug: 1b} run tellraw @a [{"text": "[FB DEBUG] distribute_single for ", "color": "gray"}, {"text": "$(player)", "color": "white"}]

# Initialize check list
data modify storage fb:tmp check set value [{key: "none"}]
$data modify storage fb:tmp check[0].key set value "$(key)"

# Initialize global check list
data modify storage fb:tmp global_check set value [{type: "none"}]
data modify storage fb:tmp global_check[0].type set from storage fb:config display.global.ab.global_type

# Global config - always executes if it exists
execute if data storage fb:tmp check[{key:"global"}] if data storage fb:config display.global.ab run function fb:display/ab/route_single with storage fb:config display.global.ab

# Individual config - executes if it exists and hard global is NOT active
$execute unless data storage fb:tmp check[{key:"global"}] if data storage fb:config display."$(key)".ab unless data storage fb:tmp global_check[{type:"hard"}] run function fb:display/ab/route_single with storage fb:config display."$(key)".ab