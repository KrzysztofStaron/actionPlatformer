extends KinematicBody2D
class_name Enemy

var health : int
export var maxHealth : int
export var knockbackReduction : int
export var atackDamage : int

func _ready() -> void:
	health = maxHealth

func _process(_delta: float) -> void:
	if health <= 0:
		$AnimationPlayer.play("death")

func takeDamage(dmg: int) -> void:
	if $AnimationPlayer.get_current_animation() != "death":
		$AnimationPlayer.play("hit")
		health -= dmg

func atack() -> void:
	var objects = $atackbox.get_overlapping_areas()
	for object in objects:
		if object.is_in_group("player"):
			object.takeDamage(atackDamage)
