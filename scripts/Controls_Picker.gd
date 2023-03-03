extends Node2D


var controlarr = ["arrows", "wasd", "ijkl", "tfgh", "joy0", "joy1", "joy2", "joy3"]
export var c_point = 0
var c_dex = 0

onready var ControlText = $ControlText
onready var Click = $Click

func _ready():
	c_dex = controlarr.find(ScoreBoard.controls[c_point])
	ControlText.text = controlarr[c_dex]

func change_text():
	ControlText.text = controlarr[c_dex]

func change(num):
	c_dex += num
	if c_dex > 7:
		c_dex = 0
	if c_dex < 0:
		c_dex = 7
	ScoreBoard.controls[c_point] = controlarr[c_dex]
	change_text()

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
