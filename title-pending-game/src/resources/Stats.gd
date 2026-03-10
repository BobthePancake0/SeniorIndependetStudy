class_name Stats
extends Resource

### A Shared STATS RESOUCE
##
## Can be used by both players and enemys
## 
## Holds data such as:
##		max health
##		Damage
##		If the user is the player or an enemy


enum Factions {
	PLAYER,
	ENEMY
}

signal damaged
signal health_changed(new_health : int, max_health: int)
signal health_depleted

@export var max_health : int = 100
@export var damage : int = 1
@export var faction : Factions = Factions.PLAYER

@export var current_health : int : set = _on_health_set

func _init() -> void:
	initialize_stats.call_deferred()

func initialize_stats() -> void:
	current_health = max_health
	

## Called whenever the hurtbox of the owner collides with a hitbox
func take_damage(amount : int, damage_source : Node2D) -> void:
	current_health -= amount
	damaged.emit(damage_source.global_position)


func _on_health_set(value : int) -> void:
	current_health = value
	print("Health was set to " , current_health)
	
	if current_health <= 0:
		health_depleted.emit()
