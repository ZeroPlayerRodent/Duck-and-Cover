extends Node2D

var Egg = preload("res://scenes/GoldenEgg.tscn")

var score = 0
var is_dead = false

var eggs = 0

onready var theLabel = $Label
onready var EggTimer = $EggTimer

var modifier = []

export var wacky_mode = true
export var daily_mode = true

var can_change = true

signal mods_gend

func _ready():
	randomize()
	modifier = ScoreBoard.cheats
	if modifier.has("chaos"):
		modifier = ScoreBoard.chaos()
	emit_signal("mods_gend")
	
	if modifier.has("wrap_around"):
		get_node("Walls").set_collision_layer_bit(1, true)


func _physics_process(_delta):
	if is_dead == false:
		score += 0.05
		theLabel.text = str("Score:\n",int(score))
	elif can_change:
		can_change = false
		ScoreBoard.solo_score = score
		ScoreBoard.solo_difficulty = get_node("Spawner").difficulty
		Transition.change_scene("res://scenes/Deathscreen.tscn")

func spawn_egg():
	var golden = Egg.instance()
	golden.position = Vector2(rand_range(50, 550), rand_range(175, 300))
	call_deferred("add_child", golden)
	eggs += 1

func _on_EggTimer_timeout():
	EggTimer.wait_time = rand_range(2, 4.5)
	if eggs < 3 and is_dead == false:
		spawn_egg()
