extends RigidBody2D

onready var _aggro: Area2D = $AggroArea
onready var _anim: AnimationPlayer = $AnimationPlayer

onready var bodyline: Line2D = $BodyLine

export var do_init = false

var player = null
var between_points: float = 10.0

func _ready():
	if do_init:
		initialize_tail()

func initialize_tail():
	seed((str(Game.get_challenge_number()) + str(global_position.x) + str(global_position.y)).hash())
	$AggroArea/CollisionShape2D.shape = $AggroArea/CollisionShape2D.shape.duplicate()
	var incrementer = Game.cur_score/15.0
	$AggroArea/CollisionShape2D.shape.radius = rand_range(150.0+incrementer, 400.0+incrementer)
	$DangerCircle.generate($AggroArea/CollisionShape2D.shape.radius)
	bodyline.set_as_toplevel(true)
	var points = []
	var length = int(rand_range(20.0, 70.0))
	for i in range(length):
		points.append(global_position + Vector2(i*between_points, 0.0))
	bodyline.points = PoolVector2Array(points)

func _physics_process(delta):
	if player.global_position.distance_to(global_position) > 2000.0:
		queue_free() # dragons delete separately from the tiles
	if get_player() != null and _anim.current_animation == "idle":
		_anim.play("chase", 0.2)
		$Roar.play()
	elif get_player() == null and _anim.current_animation != "idle":
		_anim.play("idle", 0.2)
	can_sleep = get_player() == null
	
	bodyline.points[0] = global_position
	for p in range(1, bodyline.points.size()):
		bodyline.points[p] = bodyline.points[p - 1] + (bodyline.points[p] - bodyline.points[p - 1]).normalized()*between_points
	$DeadArea.global_position = bodyline.points[bodyline.points.size() - 1]
#	if bodyline.points.size() > 0 and (bodyline.points[0] - bodyline.points[1]).length() > between_points*1.0:
#
#		for i in range(1, bodyline.points.size()):
#			bodyline.points[i] = bodyline.points[i - 1]
#		bodyline.points[0] = global_position
	
	if get_player() != null and Vector2(1, 0).rotated(global_rotation + PI).dot((get_player().global_position - global_position).normalized()) > 0.7:
		applied_force = Vector2(500.0, 0.0).rotated(global_rotation + PI)
	else:
		applied_force = Vector2()

func _integrate_forces(state: Physics2DDirectBodyState):
	if get_player() != null:
		sleeping = false
		state.transform = Transform2D(lerp_angle(global_rotation, (get_player().global_position - global_position).angle() + PI, state.step*2.1), global_position)

func get_player() -> Node2D:
	for b in _aggro.get_overlapping_bodies():
		if b.is_in_group("players"):
			return b
	return null

func bite():
	for c in $ChompArea.get_overlapping_bodies():
		if c.is_in_group("players"):
			var player: RigidBody2D = c
			c.apply_central_impulse((player.global_position - global_position).normalized()*500.0)
			c.health -= 0.25


func _on_ChompArea_body_entered(body):
	if body.is_in_group("players") and _anim.current_animation != "chomp":
		_anim.play("chomp", 0.2)
		_anim.queue("chase")

func make_explosion(pos: Vector2, delay: float = 0.0):
	var new = preload("res://DragonChunks.tscn").instance()
	new.delay = delay
	get_parent().add_child(new)
	new.global_position = pos

func _on_DeadArea_body_entered(body):
	if body.is_in_group("players"):
		for i in range(0, bodyline.points.size(), 5):
			make_explosion(bodyline.points[i], rand_range(0.05, 0.1))
		make_explosion(global_position)
		var ringdrop = preload("res://RingPickup.tscn").instance()
		get_parent().call_deferred("add_child", ringdrop)
		ringdrop.set_deferred("global_position", global_position)
		queue_free()
