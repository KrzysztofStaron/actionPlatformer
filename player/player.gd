extends KinematicBody2D

var velocity := Vector2.ZERO

export var maxSpeed := 70.0

export var step := 210
export var speedMultiplayer := 0.5

export var gravitation := 180
export var maxGravitation := 270

export var jumpHeight := -90

onready var animation := $playerAnimations
var grounded := false

var jumpBlock := false
var landBlock := false

func _process(delta: float) -> void:
	# print(animation.playback_speed)
	var dir := MoveInput.axis("move_left", "move_right")
	if jumpBlock:
		pass	
	elif !grounded:
		animation.play("falling")	
	else:
		if dir == 0:
			animation.play("idle")
		elif Input.is_action_pressed("walk"):
			animation.play("walk")
		else:
			animation.play("run")


	if Input.is_action_just_pressed("jump"):
		update_gronded()
		if grounded:
			animation.play("jump")
			jumpBlock = true
			velocity.y = jumpHeight

	var sprite := $Sprite

	if dir == -1:
		sprite.set_flip_h(true)
	elif dir == 1:
		sprite.set_flip_h(false)

	velocity.y = move_toward(velocity.y, maxGravitation, gravitation * delta)
	velocity.x = move_toward(velocity.x, maxSpeed * dir * speedMultiplayer, step * delta)

	velocity = move_and_slide(velocity)

func _animation_finished(name: String) -> void:
	if name == "jump":
		jumpBlock = false

func update_gronded() -> void:
	var bodies = $groundSensor.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("ground"):
			grounded = true
			return

	grounded = false
