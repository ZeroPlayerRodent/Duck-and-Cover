extends KinematicBody2D

var target = Vector2(0, 600)
var speed
var vector

var splosion = preload("res://scenes/Explosion.tscn")
var finger = preload("res://scenes/Finger.tscn")

var did_rid = false

var cur_alert
var cur_fing

var fragile

var pointvector = Vector2()

onready var Pappy = get_parent()

func _ready():
	if ScoreBoard.graphics == "pretty":
		$Parts.emitting = true
	fragile = Pappy.modifier.has("fragile_rockets")
	randomize()
	if Pappy.modifier.has("big_rockets"):
		scale *= 1.6
	if Pappy.modifier.has("tiny_rockets"):
		scale /= 1.6
	#spawn_alert(Vector2(target.x, 500))
	pointvector = (target - position)
	look_at(target)
	vector = (target - position).normalized()
	if !Pappy.modifier.has("stealth_rockets"):
		spawn_finger()
	else:
		did_rid = true


func spawn_finger():
	var f_in = finger.instance()
	cur_fing = f_in
	f_in.position.x = position.linear_interpolate(target, 0.5).x
	f_in.position.y = 45
	f_in.look = target
	Pappy.call_deferred("add_child", f_in)

func _physics_process(_delta):
	var _balls = move_and_slide(vector * speed)
	if position.y > 50 and did_rid == false:
		cur_fing.disappear()
		did_rid = true

func explode():
	#cur_alert.disappear()
	if did_rid == false:
		cur_fing.disappear()
	var boom = splosion.instance()
	boom.position = Vector2(position.x, position.y + 20)
	Pappy.call_deferred("add_child", boom)
	queue_free()

func fragile_explode():
	if position.y > 50:
		explode()

func _on_Area2D_body_entered(body):
	
	if "Rocket" in body.name and body != self:
		if fragile:
			body.fragile_explode()
			fragile_explode()
	
	if "Floor" in body.name:
		explode()
	
	if "Fly" in body.name:
		if body.explodes == true:
			explode()
		body.die()


func _on_Area2D_area_entered(area):
	if area.get_parent().name == "Explosion":
		if fragile:
			fragile_explode()


func _on_Onscreen_screen_entered():
	visible = true
