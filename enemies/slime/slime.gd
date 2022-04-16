extends Enemy

func _physics_process(delta: float) -> void:
	var dir := 0

	if player.get_position() < get_position():
		dir = -1
	elif player.get_position() > get_position():
		dir = 1
	
	velocity.y = move_toward(velocity.y, maxGravitation, gravitation * delta)

	applyedKnockback = move_toward(applyedKnockback, 0, knockbackReduction + 1 * delta)
	if anim.get_current_animation() != "death":
		if applyedKnockback == 0:
			velocity.x = dir * speed * speedMultiplayer
		else:
			velocity.x = applyedKnockback
	else:
		applyedKnockback = move_toward(applyedKnockback, 0, knockbackReduction + 1 * delta)
		velocity.x = applyedKnockback

	velocity = move_and_slide(velocity)

func _process(_delta: float) -> void:
	if anim.get_current_animation() == "atack":
		pass
	elif $atackbox.get_overlapping_bodies().size() != 0:
		anim.play("atack")
	elif anim.get_current_animation() != "jump" and grounded:
		anim.play("land")



func _on_AnimationPlayer_animation_finished(anim_name:String) -> void:
	if anim_name == "atack":
		anim.play("land")
