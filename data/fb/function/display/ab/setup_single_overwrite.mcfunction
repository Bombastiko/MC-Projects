# Setup overwrite for a single player
# Arguments: text, duration
# Executed as the targeted player

# Resolve player's username string
function fb:event/resolve_name

# Prepare arguments for save
data modify storage fb:tmp overwrite_args.player set from storage fb:tmp event_context.player
$data modify storage fb:tmp overwrite_args.text set value $(text)
$data modify storage fb:tmp overwrite_args.duration set value $(duration)

# Call save_overwrite
function fb:display/ab/save_overwrite with storage fb:tmp overwrite_args
