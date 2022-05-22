extends CollisionPolygon2D
onready var timer := Timer.new()
	
var time := 0.3
 
func _ready() -> void:
	timer.wait_time = time
	timer.connect("timeout", self, "_on_timer_timeout") 
	add_child(timer)

func _process(_delta: float) -> void:
	if Input.is_action_pressed("move_down"):
		disabled = true
		timer.wait_time = time
		timer.start()
		
func _on_timer_timeout():
	disabled = false
	timer.stop()
	timer.wait_time = time
