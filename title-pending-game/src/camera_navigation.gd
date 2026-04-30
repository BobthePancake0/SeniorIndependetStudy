class_name CameraNavigation
extends Camera2D


#@export var origin : Vector2
#@export var teleport_point : Vector2
#var current_area 
#
#@export var timer : Timer
#@export var wait_until_transition : float = 2.0
#var can_transition : bool = true
#
#func _on_timer_timeout() -> void:
	#print("Can now transition again")
	#can_transition = true
	#pass # Replace with function body.
#
#func _on_right_area_entered(area: Area2D) -> void:
	#if area.owner is Player && can_transition:
		#print("Touching the player!")
		#position = teleport_point
		#can_transition = false
		#timer.start(wait_until_transition)
	#pass # Replace with function body.
#
#
#func _on_left_area_entered(area: Area2D) -> void:
	#if area.owner is Player && can_transition:
		#position = origin
		#can_transition = false
		#timer.start(wait_until_transition)
	#pass # Replace with function body.
	
const SCREEN_SIZE := Vector2(480, 270)
var cur_screen := Vector2(0, 0)

func _ready() -> void:
	set_as_top_level(true)
	global_position = get_parent().global_position
	_update_screen(cur_screen)

func _physics_process(_delta: float) -> void:
	var parent_screen : Vector2 = (get_parent().global_position / SCREEN_SIZE).floor()
	if not parent_screen.is_equal_approx(cur_screen):
		_update_screen(parent_screen)

func _update_screen(new_screen : Vector2):
	cur_screen = new_screen
	global_position = cur_screen * SCREEN_SIZE + SCREEN_SIZE * 0.5
