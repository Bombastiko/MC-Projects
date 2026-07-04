# Resume stopwatch
# Arguments: name

execute unless data storage fb:main sw.list run data modify storage fb:main sw.list set value []

$data remove storage fb:main sw.list[{name:"$(name)"}]
$data modify storage fb:main sw.list append value {name: "$(name)"}