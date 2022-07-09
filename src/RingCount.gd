extends Control

var num_rings: int = 0

onready var rings = [
	$HBoxContainer/Ring1,
	$HBoxContainer/Ring2,
	$HBoxContainer/Ring3,
]

func _process(delta):
	for r in range(rings.size()):
		var target = 0.2
		if num_rings > r:
			target = 1.0
		
		rings[r].modulate.a = lerp(rings[r].modulate.a, target, delta*2.0)
