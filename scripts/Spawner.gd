extends Node2D

var rocket = preload("res://scenes/Rocket.tscn")

var rocket_speed = 445 #450
var timer_time = 3 #2
var max_rocket_speed = 800 #800
var min_timer_time = 0.95 #1
var target = Vector2(0, 600)
var player_array = []

onready var papa = get_parent()

var loglevel = 2 #99999

export var shooting = true
#var targeting_player = false

onready var theTimer = $Timer



var difficulty

var cheater_x = 0
var cheaterarr = []

var multiplier = 0.996 #0.9935

func logWithBase(value, base):
	return log(value) / log(base)

func max_out():
	rocket_speed = max_rocket_speed
	timer_time = min_timer_time

func _ready():
	ScoreBoard.stop_music()
	difficulty = ScoreBoard.solo_difficulty
	if papa.name == "Arena2P":
		multiplier = 0.99
	if difficulty == "normal":
		rocket_speed = 450 #450
		timer_time = 2 #2
	elif difficulty == "hard":
		rocket_speed = 620
		timer_time = 1.47
	elif difficulty == "easy":
		rocket_speed = 350
		timer_time = 3
	elif difficulty == "demented":
		max_out()
	elif difficulty == "babymode":
		rocket_speed = 250
		timer_time = 4.3
	theTimer.wait_time = timer_time
	randomize()
	pass

func get_target():
	if randi()%2 == 0 and player_array.size() > 0:
		player_array.shuffle()
		return(player_array[0].position.x)
		#targeting_player = true
		#print("TARGETED")
	else:
		return(rand_range(0, 600))

#func get_spawnpoint():
#	if targeting_player == true and player_array.size() > 0 and randi()%2==0:
#		player_array.shuffle()
#		return(player_array[0].position.x)
#	else:
#		return(rand_range(-10, 610))

func spawn_rocket(spotted = get_target(), piss_poss = Vector2(rand_range(-10,610),-350)): #Vector2(rand_range(-10,610),rand_range(-150,-1000))):
	target.x = spotted
	#spawn_alert(Vector2(target.x, 500))
	var rocket_instance = rocket.instance()
	rocket_instance.position = piss_poss
	rocket_instance.speed = rocket_speed
	rocket_instance.target = target
	papa.call_deferred("add_child", rocket_instance)
	#targeting_player = false

func _on_Timer_timeout():
	if shooting == true:
		fire()

func fire():
	if theTimer.wait_time > min_timer_time:
		theTimer.wait_time *= multiplier

	if theTimer.wait_time < min_timer_time:
		theTimer.wait_time = min_timer_time
	
	if rocket_speed < max_rocket_speed:
		rocket_speed /= multiplier

	if rocket_speed >= max_rocket_speed:
		var newg = log(loglevel+1)
		var newg2 = newg + (max_rocket_speed)
		rocket_speed = newg2
		loglevel += 25
		#print("New speed!: ", rocket_speed)
		#print("it's above or equal!: ", rocket_speed, ">", max_rocket_speed)


	double_rocket()
	if randi()%3 == 0:
		time_rocket()
	#if get_parent().name == "Arena2P":
	#	gigadeath()
	if cheaterarr.size() > 0:
		cheater_rocket()

func double_rocket():
	spawn_rocket()
	time_rocket()
	if papa.modifier.has("double_rockets"):
		spawn_rocket()
		time_rocket()

func time_rocket():
	var t = Timer.new()
	t.set_wait_time(rand_range(0, 0.6))
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	spawn_rocket()

func cheater_rocket():
	cheater_x = cheaterarr[0].position.x
	spawn_rocket(cheater_x, Vector2(cheater_x, -350))
	pass
	#spawn_rocket(5,Vector2(85,-350))
	#spawn_rocket(595,Vector2(515,-350))

func _on_CheaterSquares_body_entered(body):
	if "Fly" in body.name:
		cheaterarr.append(body)

func _on_CheaterSquares_body_exited(body):
	if "Fly" in body.name:
		cheaterarr.erase(body)
