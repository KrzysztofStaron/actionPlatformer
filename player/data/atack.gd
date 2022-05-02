extends Node

signal atacked

export var atackDamage : int
export var atackRandomines : int
export var knockback : float

func atack():
	var atackBox := get_parent().get_parent().get_node("atackbox")

	emit_signal("atacked")

	var bodies : Array = atackBox.get_overlapping_bodies()
	for object in bodies:
		object.takeDamage(atackDamage + rand_range(-atackRandomines, atackRandomines), knockback * atackBox.scale.x)
