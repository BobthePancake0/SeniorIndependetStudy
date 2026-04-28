class_name CameraNavigation
extends Camera2D


@export var origin : Vector2
@export var teleport_point : Vector2

@export var timer : Timer
@export var wait_until_transition : float = 2.0
var can_transition : bool = true

func _on_timer_timeout() -> void:
	print("Can now transition again")
	can_transition = true
	pass # Replace with function body.

func _on_right_area_entered(area: Area2D) -> void:
	if area.owner is Player && can_transition:
		print("Touching the player!")
		position = teleport_point
		can_transition = false
		timer.start(wait_until_transition)
	pass # Replace with function body.


func _on_left_area_entered(area: Area2D) -> void:
	if area.owner is Player && can_transition:
		position = origin
		can_transition = false
		timer.start(wait_until_transition)
	pass # Replace with function body.
