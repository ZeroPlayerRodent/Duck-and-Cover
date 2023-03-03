extends CanvasLayer

signal done_changing
var can_change = true

onready var Mations = $AnimationPlayer

func _process(_delta):
	if Input.is_action_just_pressed("escape") and can_change:
		change_scene("res://scenes/Titlescreen.tscn")
		yield(self, "done_changing")
		if !ScoreBoard.music_playing():
			ScoreBoard.play_music()

func change_scene(destination):
	if can_change:
		can_change = false
		Mations.play("fade_in")
		yield(Mations, "animation_finished")
		var _butthole = get_tree().change_scene(destination)
		Mations.play_backwards("fade_in")
		yield(Mations, "animation_finished")
		emit_signal("done_changing")
		can_change = true
