extends Node2D

onready var DifficultyText = $Difficulty/DifficultyText
onready var Click = $Click

var fpsarr = [0, 120, 60, 50, 40, 30]
var fpsdex = 0

func _ready():
	fpsdex = fpsarr.find(ScoreBoard.fps)
	if fpsarr[fpsdex] == 0:
		DifficultyText.text = "None"
	else:
		DifficultyText.text = str(fpsarr[fpsdex], " FPS")

func change_fps(num):
	fpsdex += num
	if fpsdex > fpsarr.size()-1:
		fpsdex = 0
	elif fpsdex < 0:
		fpsdex = fpsarr.size()-1
	if fpsarr[fpsdex] == 0:
		DifficultyText.text = "None"
	else:
		DifficultyText.text = str(fpsarr[fpsdex], " FPS")
	ScoreBoard.fps = fpsarr[fpsdex]
	Engine.target_fps = fpsarr[fpsdex]

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
