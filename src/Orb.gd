extends Sprite


var _t: float = 0.0

func _process(delta):
	_t += delta
	modulate.a = 0.8 + sin(_t*10.0)*0.2
