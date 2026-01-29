class_name HealthManager
extends Node

signal health_changed
signal is_damaged

@export var max_health : int = 100
var current_health : int

func _ready() -> void:
	current_health = max_health
	

func take_damage(damage : int) -> void:
	current_health -= damage
	current_health = clamp(current_health, 0, max_health)
	
	#Debug output
	print(current_health)
	
	is_damaged.emit()
	health_changed.emit()
