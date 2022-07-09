extends Node2D

onready var _left: TouchScreenButton = $LeftButton
onready var _right: TouchScreenButton = $RightButton

func _process(delta):
	var size = Game.get_game_resolution()
	_left.shape.extents = Vector2(size.x/2.0, size.y)/2.0
	_left.position = _left.shape.extents
	# right has the same shape no need to update
	_right.position = _left.position + Vector2(size.x/2.0, 0)

func do_thrust(thrust) -> bool:
	return (thrust == Game.THRUST_LEFT && (_left.is_pressed() or Input.is_action_pressed("left"))) \
		or (thrust == Game.THRUST_RIGHT && (_right.is_pressed() or Input.is_action_pressed("right")))
