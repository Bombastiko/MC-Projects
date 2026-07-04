# Resume a paused stopwatch without resetting their time
$data modify storage fb:main sw.list append value {name: "$(name)"}