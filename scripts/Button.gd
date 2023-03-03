extends Node2D

export var destination = ""
export var text = ""

onready var Txt = $TextContainer/Text

func _ready():
	Txt.text = text

func _on_ClickBox_mouse_entered():
	$Click.play()
	$Mations.play("popup")


func _on_ClickBox_mouse_exited():
	$Mations.play_backwards("popup")


func _on_ClickBox_input_event(_viewport, event, _shape_idx):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			pass
		elif !event.is_pressed():
			Transition.change_scene(destination)
			$Bang.play()
