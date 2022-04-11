extends KinematicBody2D

var velocity := Vector2.ZERO

export var maxSpeed := 70
var relativeMaxSpeed : float

export var step := 210
export var walkMultiplayer := 0.5

export var gravitation := 180
export var maxGravitation := 270

export var jumpHeight := -90

var grounded := false

func update_gronded() -> void:
	var bodies = $groundSensor.get_overlapping_bodies()
	var touchingGround := false
	for body in bodies:
		if body.is_in_group("ground"):
			touchingGround = true
			break
	
	grounded = touchingGround

func _ready() -> void:
	if OS.is_debug_build():
		# warning-ignore:INTEGER_DIVISION
		print("speed change: ", maxSpeed/step, "sec")

func _process(delta: float) -> void:
	if Input.is_action_pressed("walk"):
		relativeMaxSpeed = maxSpeed * walkMultiplayer
	else:
		relativeMaxSpeed = maxSpeed

	if Input.is_action_just_pressed("jump"):
		update_gronded()
		if grounded:
			velocity.y = jumpHeight

	var dir := MoveInput.axis("move_left", "move_right")
	var sprite := $Sprite

	if dir == -1:
		sprite.set_flip_h(true)
	elif dir == 1:
		sprite.set_flip_h(false)

	velocity.y = move_toward(velocity.y, maxGravitation, gravitation * delta)
	velocity.x = move_toward(velocity.x, relativeMaxSpeed * dir, step * delta)

	velocity = move_and_slide(velocity)

