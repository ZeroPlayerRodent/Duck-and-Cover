extends Label

func _ready():
	if ScoreBoard.cheats.size() > 0:
		visible = true
