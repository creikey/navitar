extends Area2D


func _process(delta):
	$Barrier.rotation += delta/3.0
	for b in get_overlapping_bodies():
		if b.is_in_group("players"):
			b.health += delta*0.1

func _on_Base_body_entered(body):
	if body.is_in_group("nobase"):
		body.queue_free()
