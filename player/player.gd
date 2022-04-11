extends KinematicBody2D

var velocity := Vector2.ZERO

export var maxSpeed := 70.0

export var step := 210
export var speedMultiplayer := 0.5

export var gravitation := 180
export var maxGravitation := 270

export var jumpHeight := -90
export var dust : PackedScene
export var summonDust := false

onready var animation := $playerAnimations
var grounded := true

var jumpBlock := false
var landBlock := false
var atackBlock := false

func _process(delta: float) -> void:
	# print(animation.playback_speed)
	var dir := MoveInput.axis("move_left", "move_right")

	if summonDust:
		summonDust = false

		if grounded:
			var newDust := dust.instance()
			get_node("..").add_child(newDust)
			newDust.set_global_position(get_global_position() + Vector2(0, 8))

	update_gronded()
	if atackBlock or jumpBlock or landBlock:
		pass

	elif Input.is_action_just_pressed("jump") and grounded:
		animation.play("jump")
		jumpBlock = true

	elif Input.is_action_just_pressed("swordAtack"):
		animation.play("swordAtack")
		atackBlock = true

	elif !grounded:
		animation.play("falling")

	elif animation.get_current_animation() == "falling" and grounded:
		landBlock = true
		print("land")
		animation.play("land")

	elif dir == 0:
		animation.play("idle")

	elif Input.is_action_pressed("walk"):
		animation.play("walk")

	else:
		animation.play("run")


	var sprite := $Sprite

	if dir == -1:
		sprite.set_flip_h(true)
	elif dir == 1:
		sprite.set_flip_h(false)

	velocity.y = move_toward(velocity.y, maxGravitation, gravitation * delta)
	velocity.x = move_toward(velocity.x, maxSpeed * dir * speedMultiplayer, step * delta)

	velocity = move_and_slide(velocity)

func _animation_finished(name: String) -> void:
	match name:
		"jump":
			jumpBlock = false
			velocity.y = jumpHeight
		"land":
			landBlock = false
		"swordAtack":
			atackBlock = false


func update_gronded() -> void:
	var bodies = $groundSensor.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("ground"):
			grounded = true
			return

	grounded = false
