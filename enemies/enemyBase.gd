extends KinematicBody2D
class_name Enemy

var health : int
export var maxHealth : int
export var knockbackReductin : int

func _ready() -> void:
	health = maxHealth

func _process(_delta: float) -> void:
	if health <= 0:
		$AnimationPlayer.play("death")

func takeDamage(dmg: int):
	$AnimationPlayer.play("hit")
	print(name, "Dmg: ", dmg)
	health -= dmg