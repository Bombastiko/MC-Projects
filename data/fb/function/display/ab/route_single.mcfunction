# Route display based on type (0 = sw, 1 = cd)
# Arguments: type, key

$data modify storage fb:tmp type_check set value [{val: $(type)}]

$execute if data storage fb:tmp type_check[{val:0}] run function fb:display/ab/sw_single with storage fb:config display."$(key)".ab
$execute if data storage fb:tmp type_check[{val:1}] run function fb:display/ab/cd_single with storage fb:config display."$(key)".ab
