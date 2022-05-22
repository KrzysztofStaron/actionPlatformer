extends KinematicBody2D

class_name Player

export var maxHealth := 100
var health : int

onready var animation = $animation.get("parameters/playback")

var grounded : bool

func _ready() -> void:
	$animation.active = true
	health = maxHealth

func _process(_delta: float) -> void:
	if health <= 0:
		die()

	grounded = $data/move.grounded
	var dir := MoveInput.axis("move_left", "move_right")

	if dir != 0:
		$Sprite.flip_h = dir < 0
		$atackbox.set_scale(Vector2(dir, 1))

	if !grounded:
		animation.travel("jump")
	elif dir != 0 and Input.is_action_pressed("walk"):
		animation.travel("walk")
	elif dir != 0:
		animation.travel("run")
	else:
		animation.travel("idle")

func _input(event) -> void:
	if event.is_action_pressed("swordAtack"):
			if grounded:
				animation.travel("swordAtack")
			else:
				animation.travel("airSwordAtack")

func die() -> void:
	get_tree().paused = true
	$playerAnimations.play("death")
	$animation.active = false
	print("deth")
	set_process(false)
	set_physics_process(false)
	$data/move.set_physics_process(false)

func takeDamage(damage : int) -> void:
	get_node("camera/shake").start()
	$hitAim.play("hit")
	health -= damage
	print(damage)
