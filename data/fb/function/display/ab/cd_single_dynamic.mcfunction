# Expired / Animating
$execute if score #$(cd) fb.cd.state matches 1 run function fb:display/ab/cd_anim with storage fb:config display."$(key)".ab

# Active Display (state == 0 and in cd.list)
# Case 1: Hours > 0
$execute if score #$(cd) fb.cd.state matches 0 if data storage fb:main cd.list[{name:"$(cd)"}] if score #$(cd) fb.cd.h matches 1.. run title $(player) actionbar ["", {"text": "$(prefix)", "color": "$(color)", "bold": $(bold)}, {"score": {"name": "#$(cd)", "objective": "fb.cd.h"}, "color": "$(color_num)", "bold": $(bold)}, {"text": "h ", "color": "$(color_sec)", "bold": $(bold)}, {"score": {"name": "#$(cd)", "objective": "fb.cd.m"}, "color": "$(color_num)", "bold": $(bold)}, {"text": "m ", "color": "$(color_sec)", "bold": $(bold)}, {"score": {"name": "#$(cd)", "objective": "fb.cd.s"}, "color": "$(color_num)", "bold": $(bold)}, {"text": "s", "color": "$(color_sec)", "bold": $(bold)}, {"text": "$(suffix)", "color": "$(color)", "bold": $(bold)}]

# Case 2: Hours == 0, Minutes > 0
$execute if score #$(cd) fb.cd.state matches 0 if data storage fb:main cd.list[{name:"$(cd)"}] if score #$(cd) fb.cd.h matches 0 if score #$(cd) fb.cd.m matches 1.. run title $(player) actionbar ["", {"text": "$(prefix)", "color": "$(color)", "bold": $(bold)}, {"score": {"name": "#$(cd)", "objective": "fb.cd.m"}, "color": "$(color_num)", "bold": $(bold)}, {"text": "m ", "color": "$(color_sec)", "bold": $(bold)}, {"score": {"name": "#$(cd)", "objective": "fb.cd.s"}, "color": "$(color_num)", "bold": $(bold)}, {"text": "s", "color": "$(color_sec)", "bold": $(bold)}, {"text": "$(suffix)", "color": "$(color)", "bold": $(bold)}]

# Case 3: Hours == 0, Minutes == 0
$execute if score #$(cd) fb.cd.state matches 0 if data storage fb:main cd.list[{name:"$(cd)"}] if score #$(cd) fb.cd.h matches 0 if score #$(cd) fb.cd.m matches 0 run title $(player) actionbar ["", {"text": "$(prefix)", "color": "$(color)", "bold": $(bold)}, {"score": {"name": "#$(cd)", "objective": "fb.cd.s"}, "color": "$(color_num)", "bold": $(bold)}, {"text": "s", "color": "$(color_sec)", "bold": $(bold)}, {"text": "$(suffix)", "color": "$(color)", "bold": $(bold)}]

# Paused Display (state == 0 and not in cd.list)
# Case 1: Hours > 0
$execute if score #$(cd) fb.cd.state matches 0 unless data storage fb:main cd.list[{name:"$(cd)"}] if score #$(cd) fb.cd.h matches 1.. run title $(player) actionbar ["", {"text": "$(prefix)", "color": "gray", "bold": $(bold), "italic": true}, {"score": {"name": "#$(cd)", "objective": "fb.cd.h"}, "color": "dark_gray", "bold": $(bold), "italic": true}, {"text": "h ", "color": "gray", "bold": $(bold), "italic": true}, {"score": {"name": "#$(cd)", "objective": "fb.cd.m"}, "color": "dark_gray", "bold": $(bold), "italic": true}, {"text": "m ", "color": "gray", "bold": $(bold), "italic": true}, {"score": {"name": "#$(cd)", "objective": "fb.cd.s"}, "color": "dark_gray", "bold": $(bold), "italic": true}, {"text": "s", "color": "gray", "bold": $(bold), "italic": true}, {"text": "$(suffix)", "color": "gray", "bold": $(bold), "italic": true}]

# Case 2: Hours == 0, Minutes > 0
$execute if score #$(cd) fb.cd.state matches 0 unless data storage fb:main cd.list[{name:"$(cd)"}] if score #$(cd) fb.cd.h matches 0 if score #$(cd) fb.cd.m matches 1.. run title $(player) actionbar ["", {"text": "$(prefix)", "color": "gray", "bold": $(bold), "italic": true}, {"score": {"name": "#$(cd)", "objective": "fb.cd.m"}, "color": "dark_gray", "bold": $(bold), "italic": true}, {"text": "m ", "color": "gray", "bold": $(bold), "italic": true}, {"score": {"name": "#$(cd)", "objective": "fb.cd.s"}, "color": "dark_gray", "bold": $(bold), "italic": true}, {"text": "s", "color": "gray", "bold": $(bold), "italic": true}, {"text": "$(suffix)", "color": "gray", "bold": $(bold), "italic": true}]

# Case 3: Hours == 0, Minutes == 0
$execute if score #$(cd) fb.cd.state matches 0 unless data storage fb:main cd.list[{name:"$(cd)"}] if score #$(cd) fb.cd.h matches 0 if score #$(cd) fb.cd.m matches 0 run title $(player) actionbar ["", {"text": "$(prefix)", "color": "gray", "bold": $(bold), "italic": true}, {"score": {"name": "#$(cd)", "objective": "fb.cd.s"}, "color": "dark_gray", "bold": $(bold), "italic": true}, {"text": "s", "color": "gray", "bold": $(bold), "italic": true}, {"text": "$(suffix)", "color": "gray", "bold": $(bold), "italic": true}]
