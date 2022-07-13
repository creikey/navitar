extends TouchScreenButton

var can_use: bool = true

func _process(delta):
	set_process_input(can_use)
	var _target: float = 1.0
	if not can_use:
		_target = 0.2
	modulate.a = lerp(modulate.a, _target, delta*2.0)
	position.x = Game.get_game_resolution().x/2.0 - (normal.get_size().x*scale.x)/2.0
	position.y = Game.get_game_resolution().y*0.75
