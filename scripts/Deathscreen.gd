extends Node2D

onready var score = int(ScoreBoard.solo_score)
onready var difficulty = ScoreBoard.solo_difficulty

var rawscore
var multiplier = 1

func _ready():
	if ScoreBoard.graphics == "fast":
		$TitBackground/Fires.visible = false
	rawscore = score
	if difficulty == "normal":
		multiplier = 1
	elif difficulty == "hard":
		multiplier = 1.75
	elif difficulty == "demented":
		multiplier = 2.5
	elif difficulty == "easy":
		multiplier = 0.5
	elif difficulty == "babymode":
		multiplier = 0.25
	score *= multiplier
	score = int(score)
	$Scores.text = str("Raw Score: ", rawscore,
	"\n\n", "Multiplier: x", multiplier, " (", difficulty.capitalize(), ")",
	"\n\n", "Total Score: ", score)
	
	if score > 10000:
		$Rank.text = "Rank: S+"
		$Remarks.text = "(G O D L I K E)"
	elif score > 8000:
		$Rank.text = "Rank: S"
		$Remarks.text = "(HOLY SMOKES!!!)"
	elif score > 6500:
		$Rank.text = "Rank: A+"
		$Remarks.text = "(I'm buying you a pizza!)"
	elif score > 5500:
		$Rank.text = "Rank: A"
		$Remarks.text = "(Great job!)"
	elif score > 4500:
		$Rank.text = "Rank: B+"
		$Remarks.text = "(Good!)"
	elif score > 3500:
		$Rank.text = "Rank: B"
		$Remarks.text = "(You're aight at this.)"
	elif score > 2000:
		$Rank.text = "Rank: C"
		$Remarks.text = "(Whatevz...)"
	elif score > 1000:
		$Rank.text = "Rank: D"
		$Remarks.text = "(Disappointing...)"
	elif score > 500:
		$Rank.text = "Rank: F"
		$Remarks.text = "(That was AWFUL...)"
	else:
		$Rank.text = "Rank: F-"
		$Remarks.text = "(EPIC FAIL LOLZ XD)"

func _process(_delta):
	if Input.is_action_just_pressed("restart"):
		Transition.change_scene("res://scenes/Arena.tscn")
