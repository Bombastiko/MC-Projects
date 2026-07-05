# Main Actionbar Overwrite Entrypoint
# Arguments: player, text, duration

# Run setup for each targeted player
$execute as $(player) run function fb:display/ab/setup_single_overwrite {text: $(text), duration: $(duration)}
