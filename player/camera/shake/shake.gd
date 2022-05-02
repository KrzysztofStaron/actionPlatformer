extends Node2D

var amplitude := 0
var priority := 0

onready var camera = get_parent()

const TRANS = Tween.TRANS_SINE
const EASE = Tween.EASE_IN_OUT

func start(newAmplitude := 2, duration := 0.1, frequency := 8, newPriority := 0) -> void:
	if priority <= newPriority:
		amplitude = newAmplitude
		priority = newPriority

		$duration.wait_time = duration
		$frequency.wait_time = 1 / float(frequency)

		$duration.start()
		$frequency.start()

		_new_shake()

func _new_shake() -> void:
	var rand := Vector2()
	rand.x = rand_range(-amplitude, amplitude)
	rand.y = rand_range(-amplitude, amplitude)

	$shakeTween.interpolate_property(camera, "offset", camera.offset, rand, $frequency.wait_time, TRANS, EASE)
	$shakeTween.start()

func _reset() -> void:
	$shakeTween.interpolate_property(camera, "offset", camera.offset, Vector2(), $frequency.wait_time, TRANS, EASE)
	$shakeTween.start()

	priority = 0

func _on_duraction_timeout() -> void:
	_reset()
