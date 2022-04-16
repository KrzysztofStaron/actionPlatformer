extends KinematicBody2D
class_name Enemy

onready var player = get_tree().get_nodes_in_group("player")[0]

var grounded := false

var gravitation : int
var maxGravitation : int

var health : int
export var maxHealth : int

var velocity : Vector2
export var speed : int
export var speedMultiplayer : float

export var jumpHeight : int

export var knockbackReduction : int
var applyedKnockback : float

export var atackDamage : int

onready var anim : AnimationPlayer = $AnimationPlayer

func _jump() -> void:
	velocity.y = jumpHeight

func _ready() -> void:
	_on_ground_state_changed()
	var settings = preload("res://settings.gd")
	
	gravitation = settings.gravitation
	maxGravitation = settings.maxGravitation

	health = maxHealth

func _process(_delta: float) -> void:
	if health <= 0:
		anim.play("death")

func takeDamage(dmg: int, knockback: float) -> void:
	applyedKnockback = knockback
	if anim.get_current_animation() != "death":
		if anim.has_animation("hit"):
			anim.play("hit")

		$hitAim.play("hit")
		health -= dmg


func atack() -> void:
	var objects = $atackbox.get_overlapping_bodies()
	for object in objects:
		object.takeDamage(atackDamage)

func _on_ground_state_changed(_body:Node = Node.new()) -> void:
		var bodies = $groundSensor.get_overlapping_bodies()
		grounded = bodies.size() > 0
