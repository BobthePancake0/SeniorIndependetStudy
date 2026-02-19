class_name Hurtbox 
extends Area2D

## the owner must have the stats property
@onready var owner_stats : Stats = owner.stats

func _ready() -> void:
	monitoring = false
	
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	match owner_stats.faction:
		Stats.Factions.PLAYER:
			set_collision_layer_value(LayerNames.Physics.PLAYER_HURTBOX, true)
		Stats.Factions.ENEMY:
			set_collision_layer_value(LayerNames.Physics.ENEMY_HURTBOX, true)
			
func receive_hit(damage : int, body : Node2D) -> void:
	owner_stats.take_damage(damage, body)
