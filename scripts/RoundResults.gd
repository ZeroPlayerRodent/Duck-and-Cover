extends Node2D

onready var P1 = $PlayerScores/P1
onready var P2 = $PlayerScores/P2
onready var P3 = $PlayerScores/P3
onready var P4 = $PlayerScores/P4

onready var label = $Text/Label
onready var Cont = $Text/Cont
onready var Cap = $Text/Cap

var finished = false

var winner

func _ready():
	if ScoreBoard.graphics == "fast":
		$TitBackground/Fires.visible = false
	winner = ScoreBoard.winner_name
	win()
	gen_board_color()
	gen_board_text()

func gen_board_text():
	Cap.text = str("Playing to\n", ScoreBoard.wincap, " points")
	P1.text = str("P1: ", ScoreBoard.wins[0])
	P2.text = str("P2: ", ScoreBoard.wins[1])
	P3.text = str("P3: ", ScoreBoard.wins[2])
	P4.text = str("P4: ", ScoreBoard.wins[3])

func gen_board_color():
	P1.modulate = Color(1,0.97,0.43)
	P2.modulate = Color(1,1,1)
	P3.modulate = Color(0.45,0.87,0.33)
	P4.modulate = Color(0.87,0.53,0.33)

func win():
	if winner != "Tie":
		ScoreBoard.wins[int(winner)-1] += 1
		if ScoreBoard.wins[int(winner)-1] == ScoreBoard.wincap:
			label.text = str("Winner: P",int(winner))
			finished = true
		else:
			label.text = str("Winner: P",int(winner))
		$Sprite.modulate = ScoreBoard.winner_color
		label.modulate = ScoreBoard.winner_color
	else:
		$Sprite.rotation_degrees = 90
		$Sprite.modulate = Color(0.33,0.53,0.87)
		label.text = "TIE"

func _process(_delta):
	if Input.is_action_just_pressed("continue"):
		if finished == false:
			Transition.change_scene("res://scenes/Arena2P.tscn")
		else:
			ScoreBoard.reset()
			Transition.change_scene("res://scenes/Victory.tscn")
