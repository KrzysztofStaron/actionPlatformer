extends Node

var gravitation : int
var maxGravitation : int

var velocity := Vector2.ZERO
var grounded := true
onready var player := get_parent().get_parent()

export var maxSpeed : float
export var step : int

export var dust : PackedScene

export var jumpHeight := -90

export var speedMultiplayer := 1.0

func _ready() -> void:
	var settings = preload("res://settings.gd")

	gravitation = settings.gravitation
	maxGravitation = settings.maxGravitation

func _physics_process(delta: float) -> void:
	var dir := MoveInput.axis("move_left", "move_right")

	velocity.y = move_toward(velocity.y, maxGravitation, gravitation * delta)
	velocity.x = move_toward(velocity.x, maxSpeed * dir * speedMultiplayer, step * delta)

	velocity = player.move_and_slide(velocity)

func _input(event) -> void:
	if event.is_action_pressed("jump") and grounded:
		velocity.y = jumpHeight
		summon_dust()

func _on_ground_state_changed(_body:Node) -> void:
	var bodies = player.get_node("groundSensor").get_overlapping_bodies()
	grounded = bodies.size() == 1

func summon_dust() -> void:
	var newDust := dust.instance()
	get_parent().add_child(newDust)
	newDust.set_global_position(player.get_global_position() + Vector2(0, 9))
