extends KinematicBody2D

class_name Player

signal atacked

var velocity := Vector2.ZERO

export var maxSpeed := 70.0
export var step := 210
export var speedMultiplayer := 0.5

var gravitation : int
var maxGravitation : int

export var jumpHeight := -90
export var dust : PackedScene
export var summonDust := false

export var atackDamage := 34
export var atackRandomines := 2
export var maxHealth : int
var health : int

onready var animation := $playerAnimations
var grounded := true

var jumpBlock := false
var landBlock := false
var atackBlock := false

func _ready() -> void:
	health = maxHealth
	var settings = preload("res://settings.gd")

	gravitation = settings.gravitation
	maxGravitation = settings.maxGravitation

func _process(delta: float) -> void:
	# print(animation.playback_speed)
	var dir := MoveInput.axis("move_left", "move_right")

	if summonDust:
		summonDust = false
		if grounded:
			var newDust := dust.instance()
			get_node("..").add_child(newDust)
			newDust.set_global_position(get_global_position() + Vector2(0, 9))

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
	# runing
	else:
		animation.play("run")

	var sprite := $Sprite

	if dir == -1:
		sprite.flip_h = true
		$atackbox.set_scale(Vector2(-1, 1))
	elif dir == 1:
		sprite.flip_h = false
		$atackbox.set_scale(Vector2(1, 1))

	velocity.y = move_toward(velocity.y, maxGravitation, gravitation * delta)
	velocity.x = move_toward(velocity.x, maxSpeed * dir * speedMultiplayer, step * delta)

	velocity = move_and_slide(velocity)

func _input(event) -> void:
	if atackBlock or jumpBlock or landBlock:
		pass
	# atack
	elif event.is_action_pressed("swordAtack"):
		animation.play("swordAtack")
		atackBlock = true
	# jump
	elif event.is_action_pressed("jump") and grounded:
		animation.play("jump")
		jumpBlock = true

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
		if object is Enemy:
			object.takeDamage(atackDamage + rand_range(-atackRandomines, atackRandomines))

func takeDamage(damage : int):
	health -= damage
	print(damage)

func _on_ground_state_changed(_body:Node) -> void:
	var bodies = $groundSensor.get_overlapping_bodies()
	grounded = bodies.size() > 0
