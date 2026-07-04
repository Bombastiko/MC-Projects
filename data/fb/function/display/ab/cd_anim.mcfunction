# Render countdown expiration animation
# Arguments: player, cd, bold, animation, format, prefix, suffix, color, color_sec, color_num

# Copy animation tick count to temp
scoreboard players operation #anim fb.cd.anim = #$(cd) fb.cd.anim
scoreboard players operation #anim fb.cd.anim %= #10 fb.cd.anim

# Copy animation type and format to check lists
$data modify storage fb:tmp anim_check set value [{type: "$(animation)"}]
$data modify storage fb:tmp format_check set value [{val: "$(format)"}]

# 1. FLASH: flashes red/yellow [!] TIME EXPIRED [!]
$execute if data storage fb:tmp anim_check[{type:"flash"}] if score #anim fb.cd.anim matches 0..4 run title $(player) actionbar [{"text":"[!] TIME EXPIRED [!]","color":"red","bold":$(bold)}]
$execute if data storage fb:tmp anim_check[{type:"flash"}] if score #anim fb.cd.anim matches 5..9 run title $(player) actionbar [{"text":"[!] TIME EXPIRED [!]","color":"yellow","bold":$(bold)}]

# 2. ALERT: statically displays bold red [!] TIME EXPIRED [!]
$execute if data storage fb:tmp anim_check[{type:"alert"}] run title $(player) actionbar [{"text":"[!] TIME EXPIRED [!]","color":"red","bold":$(bold)}]

# 3. PULSE: alternates between > TIME EXPIRED < and >> TIME EXPIRED << in gold/yellow
$execute if data storage fb:tmp anim_check[{type:"pulse"}] if score #anim fb.cd.anim matches 0..4 run title $(player) actionbar [{"text":"> TIME EXPIRED <","color":"yellow","bold":$(bold)}]
$execute if data storage fb:tmp anim_check[{type:"pulse"}] if score #anim fb.cd.anim matches 5..9 run title $(player) actionbar [{"text":">> TIME EXPIRED <<","color":"gold","bold":$(bold)}]

# 4. BLACKOUT: displays 00:00.00 (or equivalent) in dark gray
$execute if data storage fb:tmp anim_check[{type:"blackout"}] run title $(player) actionbar [{"text":"00:00.00","color":"dark_gray","bold":$(bold)}]

# 5. STAY: displays zeroed timer with configured colors indefinitely (does not fade out)
$execute if data storage fb:tmp anim_check[{type:"stay"}] if data storage fb:tmp format_check[{val:"digital"}] run title $(player) actionbar ["", {"text": "$(prefix)", "color": "$(color)", "bold": $(bold)}, {"text": "00", "color": "$(color_num)", "bold": $(bold)}, {"text": ":", "color": "$(color_sec)", "bold": $(bold)}, {"text": "00", "color": "$(color_num)", "bold": $(bold)}, {"text": ":", "color": "$(color_sec)", "bold": $(bold)}, {"text": "00", "color": "$(color_num)", "bold": $(bold)}, {"text": "$(suffix)", "color": "$(color)", "bold": $(bold)}]

$execute if data storage fb:tmp anim_check[{type:"stay"}] if data storage fb:tmp format_check[{val:"digital_short"}] run title $(player) actionbar ["", {"text": "$(prefix)", "color": "$(color)", "bold": $(bold)}, {"text": "00", "color": "$(color_num)", "bold": $(bold)}, {"text": ":", "color": "$(color_sec)", "bold": $(bold)}, {"text": "00", "color": "$(color_num)", "bold": $(bold)}, {"text": ".", "color": "$(color_sec)", "bold": $(bold)}, {"text": "00", "color": "$(color_num)", "bold": $(bold)}, {"text": "$(suffix)", "color": "$(color)", "bold": $(bold)}]

$execute if data storage fb:tmp anim_check[{type:"stay"}] if data storage fb:tmp format_check[{val:"letters"}] run title $(player) actionbar ["", {"text": "$(prefix)", "color": "$(color)", "bold": $(bold)}, {"text": "0", "color": "$(color_num)", "bold": $(bold)}, {"text": "h ", "color": "$(color_sec)", "bold": $(bold)}, {"text": "0", "color": "$(color_num)", "bold": $(bold)}, {"text": "m ", "color": "$(color_sec)", "bold": $(bold)}, {"text": "0", "color": "$(color_num)", "bold": $(bold)}, {"text": "s", "color": "$(color_sec)", "bold": $(bold)}, {"text": "$(suffix)", "color": "$(color)", "bold": $(bold)}]

$execute if data storage fb:tmp anim_check[{type:"stay"}] if data storage fb:tmp format_check[{val:"dynamic"}] run title $(player) actionbar ["", {"text": "$(prefix)", "color": "$(color)", "bold": $(bold)}, {"text": "0", "color": "$(color_num)", "bold": $(bold)}, {"text": "s", "color": "$(color_sec)", "bold": $(bold)}, {"text": "$(suffix)", "color": "$(color)", "bold": $(bold)}]

# 6. NONE: runs no commands, causing the actionbar to naturally fade out
