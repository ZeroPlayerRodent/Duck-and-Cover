extends Node2D

onready var Pappy = get_parent()

func _on_Area2D_body_entered(body):
	if "Fly" in body.name:
		body.chomp()
		Pappy.score += 125
		Pappy.eggs -= 1
		queue_free()
