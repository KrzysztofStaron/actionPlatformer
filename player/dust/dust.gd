extends Sprite

func _ready() -> void:
	$anim.play("main")
	
#warning-ignore:UNUSED_ARGUMENT
func _on_AnimationPlayer_animation_finished(name : String) -> void:
	queue_free()
