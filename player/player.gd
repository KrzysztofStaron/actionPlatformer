extends KinematicBody2D

var velocity := Vector2.ZERO

export var maxSpeed :float= 70
export var step := 210

export var gravitation := 180
export var maxGravitation := 270

export var jumpHeight := -90

func _ready() -> void:
	if OS.is_debug_build():
		print("speed change: ", maxSpeed/step, "sec")

func _process(delta: float) -> void:
	var dir := MoveInput.axis("move_left", "move_right")

	velocity.y = move_toward(velocity.y, maxGravitation, gravitation * delta)
	velocity.x = move_toward(velocity.x, maxSpeed * dir, step * delta)

	velocity = move_and_slide(velocity)
