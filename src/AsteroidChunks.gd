extends CPUParticles2D

var delay = 0.0
var _t = 0.0

func _process(delta):
	if _t > delay and not emitting:
		emitting = true
	_t += delta
	if _t >= 3.0:
		queue_free()
