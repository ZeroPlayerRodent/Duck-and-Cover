extends Node2D

var score = 10

func _ready():
	change(0)

func change(num):
	score += num
	if score < 1:
		score = 100
	if score > 100:
		score = 1
	ScoreBoard.wincap = score
	$Score/Scorevalue.text = str(score)

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
