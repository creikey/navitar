extends Label

func _ready():
	text = str(Game.get_challenge_number())
