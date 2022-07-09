extends Label

func _ready():
	text = "Daily challenge number: " + str(Game.get_challenge_number())
