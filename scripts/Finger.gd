extends Node2D

var look = Vector2()

func _ready():
	look_at(look)

func disappear():
	$AnimationPlayer.play_backwards("pop_in")
	yield($AnimationPlayer, "animation_finished")
	queue_free()
