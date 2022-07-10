extends RigidBody2D

export (NodePath) var _touch_path
export (NodePath) var _build_base_button_path
export var thrust: float = 100.0
export var turn_torque: float = 10.0
export var fuel_usage_per_second: float = 0.03

onready var _touch = get_node(_touch_path)
onready var _shapes = [
	$CollisionShape2D,
	$CollisionShape2D2,
	$CollisionShape2D3,
]
onready var _build_base_button = get_node(_build_base_button_path)
onready var _sprite = $Sprite

onready var _left_particles: CPUParticles2D = $LeftThrust/ThrustParticles
onready var _right_particles: CPUParticles2D = $RightThrust/ThrustParticles

var _left_thrust: bool = false
var _right_thrust: bool = false
var _spawning_in: bool = true
var _died: bool = false

var rings: int = 3 setget set_rings
var health: float = 1.0

func set_rings(new_rings):
	rings = int(clamp(new_rings, 0.0, 3.0))

func _ready():
	for s in _shapes:
		s.disabled = true
	_sprite.scale.x = 0.0
	global_position = Game.get_game_resolution()/2.0

#func get_score() -> int:
#	return 

func _physics_process(delta):
	Game.cur_score = int(max(Game.cur_score, (Game.get_game_resolution()/2.0 - global_position).length()))
	if health <= 0.0:
		_build_base_button.can_use = false
		if not _died:
			var expl = preload("res://Explosion.tscn").instance()
			get_parent().add_child(expl)
			expl.global_position = global_position
			expl.emitting = true
			Game.game_over()
		_died = true
		visible = false
		linear_velocity = Vector2()
		angular_velocity = 0.0
		applied_force = Vector2()
		applied_torque = 0.0
		for s in _shapes:
			s.disabled = true
		return
	if _spawning_in:
		_sprite.scale.x = lerp(_sprite.scale.x, 0.2, delta*3.0)
		if abs(_sprite.scale.x - 0.2) < 0.01:
			_sprite.scale.x = 0.2
			_spawning_in = false
			for s in _shapes:
				s.disabled = false
		return

	health = clamp(health, 0.0, 1.0)
	_build_base_button.can_use = rings == 3

	applied_force = Vector2()
	applied_torque = 0.0
	var _thrust: bool = false
	if _touch.do_thrust(Game.THRUST_LEFT):
		applied_torque += turn_torque
		_thrust = true
#		add_force($LeftThrust.global_position - global_position, Vector2(0.0,-thrust))
	_left_particles.emitting = _touch.do_thrust(Game.THRUST_LEFT)
	_right_particles.emitting = _touch.do_thrust(Game.THRUST_RIGHT)
	if _left_particles.emitting or _right_particles.emitting:
		health -= fuel_usage_per_second*delta
	if _touch.do_thrust(Game.THRUST_RIGHT):
		applied_torque -= turn_torque
		_thrust = true
	if _thrust:
		applied_force = Vector2(-thrust, 0.0).rotated(global_rotation + PI/2.0)
#		add_force($RightThrust.global_position - global_position, Vector2(0.0,-thrust))


func _on_DeleteArea_body_entered(body):
	if _spawning_in:
		body.queue_free()


func _on_BuildBaseButton_pressed():
	rings = 0
	var new_base = preload("res://Base.tscn").instance()
	get_parent().add_child(new_base)
	new_base.global_position = global_position
