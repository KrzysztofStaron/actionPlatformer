extends Control

func _on_Exit_pressed() -> void:
	get_tree().quit()

func _on_Options_pressed() -> void:
	pass # Replace with function body.

func _on_Start_pressed() -> void:
	# warning-ignore: RETURN_VALUE_DISCARDED
	get_tree().change_scene("res://scenes/game.tscn")
