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

var controls = ["arrows", "wasd", "ijkl", "tfgh"]

onready var Muzak = $Muzak

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
