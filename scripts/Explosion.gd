extends Node2D

onready var modifier = get_parent().modifier
onready var Particlez = $Parts/Particles
onready var Radius = $Area2D

var timer = 0
var timermax = 0.03

func _ready():
	if ScoreBoard.graphics == "fast":
		$Fast_Mations.play("splode")
	else:
		Particlez.emitting = true
	if modifier.has("tiny_explosions"):
		scale /= 1.6
	if modifier.has("big_explosions"):
		scale *= 1.6

func _process(delta):
	timer += delta
	if timer > timermax and Radius.visible:
		deactivate()

func _on_Area2D_body_entered(body):
	if "Fly" in body.name:
		body.die()

func deactivate():
	Radius.visible = false
	Radius.monitoring = false


func _on_DespawnTimer_timeout():
	queue_free()
