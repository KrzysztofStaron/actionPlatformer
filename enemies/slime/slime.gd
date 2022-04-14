extends Enemy

func _process(delta: float) -> void:

	velocity.y = move_toward(velocity.y, maxGravitation, gravitation * delta)

	velocity = move_and_slide(velocity)
