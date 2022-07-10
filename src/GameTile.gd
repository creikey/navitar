extends Node2D

signal deleting(pos)

var player: Node2D
var dragon_chance = 0.1

func _process(delta):
	if player.global_position.distance_to(global_position) > Game.tile*3.0:
		emit_signal("deleting", global_position)
		queue_free()

func generate():
	seed((str(global_position.x) + str(global_position.y) + str(Game.get_challenge_number())).hash())
	for x in range(0.0, Game.tile, Game.tile/2.0):
		for y in range(0.0, Game.tile, Game.tile/2.0):
			var target := Vector2(x, y) + Vector2(rand_range(-100.0, 100.0), rand_range(-100.0, 100.0))
			var random_result = rand_range(0.0, 1.0)
			if random_result < dragon_chance:
				var dragon = preload("res://Dragon.tscn").instance()
				get_parent().add_child(dragon)
				dragon.global_position = global_position + target
				dragon.player = player
				dragon.initialize_tail()
				continue
			var asteroid = preload("res://Asteroid.tscn").instance()
			add_child(asteroid)
			asteroid.position = target
			asteroid.create(rand_range(75, 125))

