extends KinematicBody2D

class_name Player

export var maxHealth := 100
var health : int

onready var animation = $animation.get("parameters/playback")

func _ready() -> void:
	$animation.active = true
	health = maxHealth

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

func die() -> void:
	get_tree().paused = true
	$playerAnimations.play("death")
	$animation.active = false
	print("deth")
	set_process(false)
	set_physics_process(false)

func takeDamage(damage : int) -> void:
	get_node("camera/shake").start()
	$hitAim.play("hit")
	health -= damage
	print(damage)
