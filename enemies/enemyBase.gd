extends KinematicBody2D
class_name Enemy

var health : int
export var maxHealth : int

func _ready() -> void:
	health = maxHealth

func _process(_delta: float) -> void:
	if health <= 0:
		queue_free()

func takeDamage(dmg: int):
	health -= dmg