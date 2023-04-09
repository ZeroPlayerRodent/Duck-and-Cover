extends Node2D

export var players = 1
export var wincap = 0

var fps = 0

var graphics = "pretty"

var wins = [0,0,0,0]

var winner_name = "Tie"
var winner_color

var solo_score = 0
var solo_difficulty = ""

var cheats = []

var rand_cheats = [["low_gravity","high_gravity"],["low_speed","high_speed"],
["big_explosions","tiny_explosions"],["big_mode","tiny_mode"],["double_rockets"],
["no_air_explosions"],["big_rockets","tiny_rockets"],["stealth_rockets"],
["fragile_rockets"],["reverse_gravity"],["wrap_around"],["gravity_shift","flightless"],
["reverse_controls"],["phantom"]]

var controls = ["arrows", "wasd", "ijkl", "tfgh"]

onready var Muzak = $Muzak

func chaos():
	randomize()
	cheats.clear()
	rand_cheats.shuffle()
	var curch
	var times = 0
	var times2d = int(rand_range(5,rand_cheats.size()))
	while times < times2d:
		curch = rand_cheats[times]
		curch.shuffle()
		cheats.append(curch[0])
		times+=1
	if cheats.has("flightless") and randi()%2==1:
		cheats.erase("flightless")
	if cheats.has("reverse_controls") and randi()%2==1:
		cheats.erase("reverse_controls")
	if cheats.has("reverse_controls") and randi()%2==1:
		cheats.erase("reverse_controls")
	cheats.append("chaos")
	return cheats

func reset_wins():
	wins = [0,0,0,0]

func play_music():
	Muzak.play()

func music_playing():
	return Muzak.playing

func stop_music():
	Muzak.stop()

func reset():
	wins = [0,0,0,0]
