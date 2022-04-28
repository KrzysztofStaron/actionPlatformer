extends Node

var gameMode : String = "normal"

func _ready() -> void:
	if !OS.is_debug_build():
		OS.window_fullscreen = true

