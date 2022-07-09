extends Node2D

func _ready():
	randomize()
	
	$Base.position = Game.get_game_resolution()/2.0
