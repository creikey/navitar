extends Area2D

func _on_RingPickup_body_entered(body):
	if body.is_in_group("players"):
		body.rings += 1
		queue_free()
