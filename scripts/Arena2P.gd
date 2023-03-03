extends Node2D

onready var Spawner = $Spawner
onready var Slimer = $Slimer

var modifier = []

export var wacky_mode = true

export var daily_mode = false

var can_change = true

signal mods_gend

func _ready():
	randomize()
	modifier = ScoreBoard.cheats
	emit_signal("mods_gend")
	if modifier.has("wrap_around"):
		get_node("Walls").set_collision_layer_bit(1, true)


func bird_died():
	Slimer.start()

func _on_Slimer_timeout():
	if Spawner.player_array.size() == 1 and can_change == true:
		ScoreBoard.winner_name = Spawner.player_array[0].name
		ScoreBoard.winner_color = Spawner.player_array[0].get_node("Bird").modulate
		Transition.change_scene("res://scenes/RoundResults.tscn")
		can_change = false
	elif Spawner.player_array.size() == 0 and can_change == true:
		ScoreBoard.winner_name = "Tie"
		Transition.change_scene("res://scenes/RoundResults.tscn")
		can_change = false
