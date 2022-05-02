extends Node

export var atackDamage : int
export var atackRandomines : int
export var knockback : float

func atack() -> void:
	var atackBox := get_parent().get_parent().get_node("atackbox")

	get_parent().get_parent().get_node("camera/shake").start()

	var bodies : Array = atackBox.get_overlapping_bodies()
	for object in bodies:
		object.takeDamage(atackDamage + rand_range(-atackRandomines, atackRandomines), knockback * atackBox.scale.x)
