extends KinematicBody2D
class_name Enemy

var gravitation : int
var maxGravitation : int

var health : int
export var maxHealth : int

var velocity : Vector2
export var speed : int
export var jumpHeight : int

export var knockbackReduction : int
export var atackDamage : int

func _ready() -> void:
	var settings = preload("res://settings.gd")
	
	gravitation = settings.gravitation
	maxGravitation = settings.maxGravitation

	health = maxHealth

func _process(_delta: float) -> void:
	if health <= 0:
		$AnimationPlayer.play("death")

func takeDamage(dmg: int) -> void:
	var anim : AnimationPlayer = $AnimationPlayer;
	if anim.get_current_animation() != "death":
		if anim.has_animation("hit"):
			anim.play("hit")

		$hitAim.play("hit")
		health -= dmg

func atack() -> void:
	var objects = $atackbox.get_overlapping_areas()
	for object in objects:
		if object.is_in_group("player"):
			object.takeDamage(atackDamage)


func _on_hitAim_animation_finished(_anim_name:String) -> void:
	if (_anim_name == "hit"):
		get_node("hitAim").play("idle")
