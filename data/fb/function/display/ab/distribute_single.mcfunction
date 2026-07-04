$execute if data storage fb:config {debug: 1b} run tellraw @a [{"text": "[FB DEBUG] distribute_single for ", "color": "gray"}, {"text": "$(player)", "color": "white"}]

$data modify storage fb:tmp check set value {key: "$(key)"}

# Global config - always executes
$execute if data storage fb:tmp {check:{key:"global"}} if data storage fb:config display.global.ab{type: 0} run function fb:display/ab/sw_single with storage fb:config display.global.ab

# Individual config - executes only if hard global is NOT active
$execute unless data storage fb:tmp {check:{key:"global"}} if data storage fb:config display.$(key).ab{type: 0} unless data storage fb:config display.global.ab{global_type: "hard"} run function fb:display/ab/sw_single with storage fb:config display.$(key).ab