extends CPUParticles2D

var _t = 0.0

func _ready():
	emitting = true

func _process(delta):
	_t += delta
	if _t >= 3.0:
		queue_free()
