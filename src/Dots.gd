extends ColorRect

export var dots_radius: float = 0.0

func _ready():
	material = material.duplicate()

func _process(delta):
	material.set_shader_param("radius", dots_radius)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
