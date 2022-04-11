extends Node

func _ready() -> void:
	if OS.is_debug_build():
		OS.window_fullscreen = true
