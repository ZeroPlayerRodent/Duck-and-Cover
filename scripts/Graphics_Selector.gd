extends Node2D

onready var DifficultyText = $Difficulty/DifficultyText
onready var Click = $Click

var fx_arr = ["pretty", "fast"]
var fx_dex = 0

func _ready():
	fx_dex = fx_arr.find(ScoreBoard.graphics)
	DifficultyText.text = str(fx_arr[fx_dex]).capitalize()

func change_fps(num):
	fx_dex += num
	if fx_dex > 1:
		fx_dex = 0
	elif fx_dex < 0:
		fx_dex = 1
	DifficultyText.text = str(fx_arr[fx_dex]).capitalize()
	ScoreBoard.graphics = fx_arr[fx_dex]

func _on_RightBtn_input_event(_viewport, event, _shape_idx):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			pass
		elif !event.is_pressed():
			change_fps(1)
			Click.play()


func _on_LeftBtn_input_event(_viewport, event, _shape_idx):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			pass
		elif !event.is_pressed():
			change_fps(-1)
			Click.play()
