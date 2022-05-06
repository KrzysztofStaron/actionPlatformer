extends CollisionPolygon2D
onready var timer := Timer.new()
	
func _ready() -> void:
	timer.wait_time = 0.2
	timer.connect("timeout", self, "_on_timer_timeout") 
	add_child(timer)

func _process(_delta: float) -> void:
	if Input.is_action_pressed("move_down"):
		disabled = true
		timer.wait_time = 0.2
		timer.start()
		
func _on_timer_timeout():
	disabled = false
	timer.stop()
	timer.wait_time = 0.2
