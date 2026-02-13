class_name Enemy
extends CharacterBody2D

@export var stats : Stats


func _ready() -> void:
	stats.health_depleted.connect(_on_health_depleted)
	

func _on_health_depleted() -> void:
	print("Should be DEAD!")
	queue_free()
