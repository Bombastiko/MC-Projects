# FuseBox Event System - Trigger onHoldItem Event Handler
# Executed as individual player (@s)

data modify storage fb:tmp event_context set value {name: "onHoldItem"}
function fb:event/run_callbacks
