extends RigidBody2D

onready var _collision: CollisionPolygon2D = $CollisionPolygon2D

func _ready():
	randomize()
	var shade_change: float = rand_range(-0.05, 0.05)
#	color = Game.asteroids + Color(shade_change,shade_change,shade_change)
	$Polygon2D.color = Game.asteroids

func create(radius: float):
	var vertex_count := int(max(3.0, radius*0.4))
	var deviation: float = radius/6
	
	var vertices: Array = []
	for v in range(vertex_count):
		var angle: float = (float(v)/float(vertex_count))*2.0*PI
		vertices.append(Vector2(radius + rand_range(-deviation*2, deviation), 0.0).rotated(angle))
	$Polygon2D.polygon = PoolVector2Array(vertices)
	_collision.polygon = $Polygon2D.polygon


func _on_Asteroid_tree_exiting():
	var chunks = preload("res://AsteroidChunks.tscn").instance()
	get_parent().call_deferred("add_child", chunks)
	chunks.set_deferred("global_position", global_position)