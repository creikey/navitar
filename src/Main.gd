extends Node2D

func _ready():
	seed(str(Game.get_challenge_number()).hash())
	Game.cur_score = 0
	$Base.position = Game.get_game_resolution()/2.0
