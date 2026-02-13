class_name Stats
extends Resource

enum Factions {
	PLAYER,
	ENEMY
}

signal health_changed(new_health : int, max_health: int)
signal health_depleted

@export var max_health : int = 100
@export var damage : int = 1
@export var faction : Factions = Factions.PLAYER

var current_health : int : set = _on_health_set

func _init() -> void:
	initialize_stats.call_deferred()

func initialize_stats() -> void:
	current_health = max_health
	

func take_damage(amount : int) -> void:
	current_health -= amount

func _on_health_set(value : int) -> void:
	current_health = value
	print("Health was set to " , current_health)
	
	if current_health <= 0:
		health_depleted.emit()
