extends CollisionPolygon2D


func _process(delta: float) -> void:
	disabled = Input.is_action_pressed("move_down")
