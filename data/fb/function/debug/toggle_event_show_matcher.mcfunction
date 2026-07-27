# Toggle event_show_matcher debug flag
data modify storage fb:tmp debug_toggle set from storage fb:config debug.event_show_matcher
execute if data storage fb:tmp {debug_toggle: 1b} run data modify storage fb:config debug.event_show_matcher set value 0b
execute unless data storage fb:tmp {debug_toggle: 1b} run data modify storage fb:config debug.event_show_matcher set value 1b

function fb:debug/menu
