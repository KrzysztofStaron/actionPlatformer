extends KinematicBody2D

class_name Player

signal atacked

var velocity := Vector2.ZERO

export var knockback := 10.0

export var maxSpeed := 70.0
export var step := 210
export var speedMultiplayer := 1.0

var gravitation : int
var maxGravitation : int

export var jumpHeight := -90
export var autoJump := 0.15

export var dust : PackedScene

export var atackDamage := 34
export var atackRandomines := 4

export var maxHealth := 100
var health : int

onready var animation := $playerAnimations

var grounded := true

export var jumpBlock := false
var landBlock := false
var atackBlock := false

func _ready() -> void:
	health = maxHealth
	var settings = preload("res://settings.gd")

	gravitation = settings.gravitation
	maxGravitation = settings.maxGravitation

func _physics_process(delta: float) -> void:
	var dir := MoveInput.axis("move_left", "move_right")

	velocity.y = move_toward(velocity.y, maxGravitation, gravitation * delta)
	velocity.x = move_toward(velocity.x, maxSpeed * dir * speedMultiplayer, step * delta)

	velocity = move_and_slide(velocity)

func _process(_delta: float) -> void:
	var dir := MoveInput.axis("move_left", "move_right")

	match dir:
		-1:
			$Sprite.flip_h = true
			$atackbox.set_scale(Vector2(-1, 1))
		1:
			$Sprite.flip_h = false
			$atackbox.set_scale(Vector2(1, 1))

	# Animations

	if atackBlock or jumpBlock or landBlock:
		pass
	# falling
	elif !grounded:
		animation.play("falling")
	# land
	elif animation.get_current_animation() == "falling" and grounded:
		landBlock = true
		animation.play("land")
	# idle
	elif dir == 0:
		animation.play("idle")
	# walking
	elif Input.is_action_pressed("walk"):
		animation.play("walk")
	# running
	else:
		animation.play("run")

func _input(event) -> void:
	if jumpBlock or landBlock:
		pass
	# atack
	elif event.is_action_pressed("jump") and grounded:
		animation.play("jump")
		jumpBlock = true
		atackBlock = false
	# jump
	elif event.is_action_pressed("jump"):
		$jumpTimer.wait_time = autoJump
		$jumpTimer.start()
		atackBlock = false
	# autoJump
	elif event.is_action_pressed("swordAtack") and !atackBlock:
		animation.play("swordAtack")
		atackBlock = true


func _animation_finished(name: String) -> void:
	match name:
		"jump":
			jumpBlock = false
			velocity.y = jumpHeight
		"land":
			landBlock = false
		"swordAtack":
			atackBlock = false

func atack():
	emit_signal("atacked")
	var objects = $atackbox.get_overlapping_bodies()
	for object in objects:
		# if object is Enemy:
		object.takeDamage(atackDamage + rand_range(-atackRandomines, atackRandomines), knockback * $atackbox.scale.x)

func summon_dust():
	var newDust := dust.instance()
	get_parent().add_child(newDust)
	newDust.set_global_position(get_global_position() + Vector2(0, 9))

func takeDamage(damage : int):
	$hitAim.play("hit")
	health -= damage
	print(damage)

func _on_ground_state_changed(_body:Node) -> void:
	var bodies = $groundSensor.get_overlapping_bodies()
	grounded = bodies.size() > 0

	if $jumpTimer.wait_time >= 0.06:
		animation.play("jump")
		jumpBlock = true

		resetTimer()

func resetTimer():
	$jumpTimer.wait_time = 0.05
	$jumpTimer.stop()
