extends Node2D

var difficulties = ["babymode", "easy", "normal", "hard", "demented"]
var bonuses = ["x0.25", "x0.5", "x1", "x1.75", "x2.5"]
var colors = [Color(0, 0.039216, 1), Color(0, 0.976562, 1), Color(0.101961, 1, 0), Color(0.945098, 1, 0), Color(1, 0, 0)]
var dif_dex = 2

onready var DifficultyText = $Difficulty/DifficultyText
onready var Click = $Click
onready var Bonus = $Difficulty/Bonus

func _ready():
	change(0)

func change(num):
	dif_dex += num
	if dif_dex > 4:
		dif_dex = 0
	elif dif_dex < 0:
		dif_dex = 4
	ScoreBoard.solo_difficulty = difficulties[dif_dex]
	DifficultyText.text = difficulties[dif_dex].capitalize()
	Bonus.text = str(bonuses[dif_dex], " score multiplier")
	DifficultyText.modulate = colors[dif_dex]

func _on_RightBtn_input_event(_viewport, event, _shape_idx):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			pass
		elif !event.is_pressed():
			change(1)
			Click.play()


func _on_LeftBtn_input_event(_viewport, event, _shape_idx):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			pass
		elif !event.is_pressed():
			change(-1)
			Click.play()
