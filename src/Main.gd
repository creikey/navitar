extends Node2D

func _ready():
	seed(str(Game.get_challenge_number()).hash())
	Game.cur_score = 0
	$CalendarSymbol.rect_position.x = Game.get_game_resolution().x/2.0 - $CalendarSymbol.rect_size.x/2.0
	$CalendarSymbol.rect_position.y = Game.get_game_resolution().y/4.0 - $CalendarSymbol.rect_size.y/2.0
