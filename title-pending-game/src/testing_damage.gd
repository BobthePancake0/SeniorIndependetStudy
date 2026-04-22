class_name Enemy
extends CharacterBody2D

@export var stats : Stats
@export var health_bar : ProgressBar


func _ready() -> void:
	stats.health_depleted.connect(_on_health_depleted)
	stats.health_changed.connect(_on_health_changed)
	

func _on_health_depleted() -> void:
	print("Should be DEAD!")
	queue_free()
	
func _on_health_changed(current_health : float, max_health : float) -> void:
	print(current_health, " , ", max_health)
	health_bar.value = (current_health / max_health) * 100
	pass
