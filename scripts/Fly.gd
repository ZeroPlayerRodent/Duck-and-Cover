extends KinematicBody2D


var feathers = preload("res://scenes/Feathers.tscn")

var GRAVITY = 25
var MAXFALLSPEED = 1500 #850
var MAXSPEED = 400 #350
var JUMPFORCE = 650

var motion = Vector2()
var hasplayed = false

var left
var right
var jump

var wrapping = true
var gravshift = false

onready var Bird = $Bird
onready var Flip = $Flip
onready var Mations = $Mations
onready var CHOMP = $CHOMP
onready var Pappy = get_parent()
onready var Spawner = Pappy.get_node("Spawner")

var explodes = true

func _ready():
	Bird.modulate = Color(1,0.97,0.43)
	if int(self.name) <= ScoreBoard.players:
		Pappy.get_node("Spawner").player_array.append(self)
	else:
		queue_free()
	left = str("left_", ScoreBoard.controls[int(self.name)-1])
	right = str("right_", ScoreBoard.controls[int(self.name)-1])
	jump = str("jump_", ScoreBoard.controls[int(self.name)-1])
	yield(Pappy, "mods_gend")
	modifiers()
	if self.name == "Fly2":
		Bird.modulate = Color(1,1,1)
	if self.name == "Fly3":
		Bird.modulate = Color(0.45,0.87,0.33)
	if self.name == "Fly4":
		Bird.modulate = Color(0.87,0.53,0.33)

func _physics_process(_delta):
	if abs(motion.y) < MAXFALLSPEED:
		motion.y += GRAVITY
	if wrapping == true:
		wrap_around()
	var _balls = move_and_slide(motion)

func _process(_delta):
	move()

func move():
	
	if Input.is_action_pressed(left):
		#if abs(motion.x) < MAXSPEED:
		motion.x = -MAXSPEED
		if Bird.flip_h == false:
			Bird.flip_h = true
			hasplayed = false
		if hasplayed == false:
			Mations.play("tiltleft")
			hasplayed = true
	elif Input.is_action_pressed(right):
		#if abs(motion.x) < MAXSPEED:
		motion.x = MAXSPEED
		if Bird.flip_h == true:
			Bird.flip_h = false
			hasplayed = false
		if hasplayed == false:
			Mations.play("tiltright")
			hasplayed = true
	else:
		motion.x = 0
		Mations.play("normaltilt")
		hasplayed = false

	if Input.is_action_just_pressed(jump):
		if gravshift == false:
			motion.y = -JUMPFORCE
			Flip.play()
			Bird.play("Flap")
		else:
			motion.y = 0
			GRAVITY = -GRAVITY
			scale.y = -scale.y
			Flip.play()
			Bird.play("Flap")

func die():
	pass
	Spawner.player_array.erase(self)
	if Pappy.name == "Arena":
		Pappy.is_dead = true
	else:
		Pappy.bird_died()
	feather_poof()
	queue_free()

func feather_poof():
	var poof = feathers.instance()
	poof.position = position
	poof.modulate = Bird.modulate
	poof.emitting = true
	poof.get_node("Quack").pitch_scale = rand_range(0.9,1.1)
	Pappy.call_deferred("add_child", poof)

func modifiers():
	var modifier = Pappy.modifier
	if modifier.has("low_gravity"):
		GRAVITY /= 2
	if modifier.has("high_gravity"):
		GRAVITY *= 2
	if modifier.has("tiny_mode"):
		scale /= 2
	if modifier.has("high_speed"):
		MAXSPEED *= 2
	if modifier.has("low_speed"):
		MAXSPEED /= 2
	if modifier.has("no_air_explosions"):
		explodes = false
	if modifier.has("big_mode"):
		scale *= 2
	if modifier.has("flightless"):
		jump = "nothing"
	if modifier.has("reverse_controls"):
		right = str("left_", ScoreBoard.controls[int(self.name)-1])
		left = str("right_", ScoreBoard.controls[int(self.name)-1])
	if modifier.has("phantom"):
		modulate.a /= 1.4
		set_collision_mask_bit(0, 0)
	if modifier.has("reverse_gravity"):
		GRAVITY = -GRAVITY
		JUMPFORCE = -JUMPFORCE
		scale.y = -scale.y
	if modifier.has("wrap_around"):
		wrapping = false
	if modifier.has("gravity_shift"):
		gravshift = true

func _on_AnimatedSprite_animation_finished():
	Bird.play("default")

func chomp():
	CHOMP.play()

func wrap_around():
	if position.x < 0:
		position.x = 600
	if position.x > 600:
		position.x = 0
