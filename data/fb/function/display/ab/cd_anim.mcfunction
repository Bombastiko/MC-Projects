# Render countdown expiration animation
# Arguments: player, cd, bold, animation

# Copy animation tick count to temp
scoreboard players operation #anim fb.cd.anim = #$(cd) fb.cd.anim
scoreboard players operation #anim fb.cd.anim %= #10 fb.cd.anim

# Copy animation type to check list
$data modify storage fb:tmp anim_check set value [{type: "$(animation)"}]

# 1. FLASH: flashes red/yellow [!] TIME EXPIRED [!]
$execute if data storage fb:tmp anim_check[{type:"flash"}] if score #anim fb.cd.anim matches 0..4 run title $(player) actionbar [{"text":"[!] TIME EXPIRED [!]","color":"red","bold":$(bold)}]
$execute if data storage fb:tmp anim_check[{type:"flash"}] if score #anim fb.cd.anim matches 5..9 run title $(player) actionbar [{"text":"[!] TIME EXPIRED [!]","color":"yellow","bold":$(bold)}]

# 2. ALERT: statically displays bold red [!] TIME EXPIRED [!]
$execute if data storage fb:tmp anim_check[{type:"alert"}] run title $(player) actionbar [{"text":"[!] TIME EXPIRED [!]","color":"red","bold":$(bold)}]

# 3. PULSE: alternates between > TIME EXPIRED < and >> TIME EXPIRED << in gold/yellow
$execute if data storage fb:tmp anim_check[{type:"pulse"}] if score #anim fb.cd.anim matches 0..4 run title $(player) actionbar [{"text":"> TIME EXPIRED <","color":"yellow","bold":$(bold)}]
$execute if data storage fb:tmp anim_check[{type:"pulse"}] if score #anim fb.cd.anim matches 5..9 run title $(player) actionbar [{"text":">> TIME EXPIRED <<","color":"gold","bold":$(bold)}]

# 4. NONE/FALLBACK: displays 00:00.00 in dark gray
$execute if data storage fb:tmp anim_check[{type:"none"}] run title $(player) actionbar [{"text":"00:00.00","color":"dark_gray","bold":$(bold)}]
