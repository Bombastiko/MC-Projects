# Start countdown timer
# Arguments: name

execute unless data storage fb:main cd.list run data modify storage fb:main cd.list set value []

# Ensure it's not duplicated in running list
$data remove storage fb:main cd.list[{name:"$(name)"}]
$data modify storage fb:main cd.list append value {name: "$(name)"}
