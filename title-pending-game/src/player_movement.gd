extends CharacterBody2D


@export var speed = 5;

func _ready() -> void:
	pass

func get_movement_direction() -> Vector2:
	return Input.get_vector("move_left", "move_right", "move_up", "move_down")	
