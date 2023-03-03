extends Button

export var cheat = ""
export(String, MULTILINE) var desc

onready var papa = get_tree().get_root().get_node("Cheats")
onready var Click = $Click
onready var Bang = $Bang

func _ready():
	set_color()

func set_color():
	if cheat in ScoreBoard.cheats:
		modulate = Color(0, 1, 0)
	else:
		modulate = Color(1, 0, 0)

func _on_Cheat_Button_mouse_entered():
	Click.play()
	papa.change_desc(desc)


func _on_Cheat_Button_button_up():
	if cheat in ScoreBoard.cheats:
		ScoreBoard.cheats.erase(cheat)
		modulate = Color(1, 0, 0)
		Bang.play()
	else:
		ScoreBoard.cheats.append(cheat)
		modulate = Color(0, 1, 0)
		Bang.play()
