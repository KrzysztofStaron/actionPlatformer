extends Enemy

func _ready() -> void:
	if player.get_position() < get_position():
		dir = 1
	elif player.get_position() > get_position():
		dir = -1

func _physics_process(_delta: float) -> void:
	if player.get_position() < get_position():
		dir = 1
	elif player.get_position() > get_position():
		dir = -1

	velocity = move_and_slide(velocity)

func _process(_delta: float) -> void:
	if anim.get_current_animation() == "atack":
		pass
	elif $atackbox.get_overlapping_bodies().size() != 0 and grounded:
		anim.play("atack")
	elif anim.get_current_animation() != "jump" and grounded:
		anim.play("land")

func _on_AnimationPlayer_animation_finished(anim_name:String) -> void:
	if anim_name == "atack":
		anim.play("land")
