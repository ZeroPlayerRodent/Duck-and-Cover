extends Node2D

var players = 2

func _ready():
	change(0)

func change(num):
	players += num
	if players > 4:
		players = 2
	if players < 2:
		players = 4
	$Players/Playernum.text = str(players)
	ScoreBoard.players = players

func _on_Left_input_event(_viewport, event, _shape_idx):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			pass
		elif !event.is_pressed():
			change(-1)
			$Click.play()


func _on_Right_input_event(_viewport, event, _shape_idx):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			pass
		elif !event.is_pressed():
			change(1)
			$Click.play()
