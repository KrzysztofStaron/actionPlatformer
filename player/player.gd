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

onready var animation = $animation.get("parameters/playback")

var grounded := true

func _ready() -> void:
	$animation.active = true
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
	if health <= 0:
		die()

	var dir := MoveInput.axis("move_left", "move_right")

	match dir:
		-1:
			$Sprite.flip_h = true
			$atackbox.set_scale(Vector2(-1, 1))
		1:
			$Sprite.flip_h = false
			$atackbox.set_scale(Vector2(1, 1))

	if dir != 0 and Input.is_action_pressed("walk"):
		animation.travel("walk")
	elif dir != 0:
		animation.travel("run")
	else:
		animation.travel("idle")

func _input(event) -> void:
	if event.is_action_pressed("swordAtack"):
		animation.travel("swordAtack")
	elif event.is_action_pressed("jump") and grounded:
		velocity.y = jumpHeight
		summon_dust()

func die():
	$playerAnimations.play("death")
	$animation.active = false
	print("deth")
	set_process(false)
	set_physics_process(false)

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
	grounded = bodies.size() == 1
