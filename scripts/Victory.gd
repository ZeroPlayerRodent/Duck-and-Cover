extends Node2D

onready var sprite = $Sprite
onready var label = $Label

func _ready():
	var winner = ScoreBoard.winner_name
	sprite.modulate = ScoreBoard.winner_color
	label.modulate = ScoreBoard.winner_color
	label.text = str("CHAMPION: P", int(winner))
