extends Node

var gameMode : String = "normal"

func _ready() -> void:
	if !OS.is_debug_build():
		OS.window_fullscreen = true

func _input(event: InputEvent) -> void:
	if OS.is_debug_build() and event.is_action_pressed("fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
