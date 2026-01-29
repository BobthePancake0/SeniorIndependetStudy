class_name Character
extends CharacterBody2D

@export_category("details")
@export var movement_speed = 5;

@export_category("Nodes")
@export_category("Managers")
@export var health_manager : HealthManager
@export_category("Boxes")
@export var hurt_box : Area2D
var collided_with : Node2D



func get_movement_direction() -> Vector2:
	return Input.get_vector("move_left", "move_right", "move_up", "move_down")	
	

	
