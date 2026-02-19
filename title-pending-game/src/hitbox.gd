class_name Hitbox
extends Area2D

@onready var attacker_stats : Stats = owner.stats
#var hitbox_lifetime : float
#var shape : Shape2D

#func _init(_attacker_stats : Stats, _hitbox_lifetime: float, _shape = Shape2D) -> void:
	#attacker_stats = _attacker_stats
	##hitbox_lifetime = _hitbox_lifetime
	##shape = _shape
	
func _ready() -> void:
	monitorable = false
	area_entered.connect(_on_area_entered)
	
	#if hitbox_lifetime > 0.0:
		#var new_timer = Timer.new()
		#add_child(new_timer)
		#new_timer.timeout.connect(queue_free)
		#new_timer.call_deferred("start", hitbox_lifetime)
		
	#if shape:
		#var collision_shape = CollisionShape2D.new()
		#collision_shape.shape = shape
		#add_child(collision_shape)
	
	## Sets default layers to false
	#set_collision_layer_value(1, false)
	#set_collision_mask_value(1, false)
	#match attacker_stats.faction:
		#Stats.Factions.PLAYER:
			#set_collision_mask_value(LayerNames.Physics.ENEMY_HURTBOX, true)
		#Stats.Factions.ENEMY:
			#set_collision_mask_value(LayerNames.Physics.PLAYER_HURTBOX, true)
			

func _on_area_entered(area: Area2D) -> void:
	if not area.has_method("receive_hit"):
		return
	
	print("Hitbox entered " + area.owner.name)	
	area.receive_hit(attacker_stats.damage, owner)
	
	pass
	
	
	
	
	
