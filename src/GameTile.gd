extends Node2D

signal deleting(pos)

var player: Node2D

func _process(delta):
	if player.global_position.distance_to(global_position) > 6000.0:
		emit_signal("deleting", global_position)
		queue_free()

func generate():
	rand_seed(int(global_position.x + global_position.y))
	for x in range(0.0, Game.tile, 300):
		for y in range(0.0, Game.tile, 300):
			var asteroid = preload("res://Asteroid.tscn").instance()
			add_child(asteroid)
			asteroid.position = Vector2(x, y) + Vector2(rand_range(-50.0, 50.0), rand_range(-50.0, 50.0))
			asteroid.create(rand_range(35, 75))
