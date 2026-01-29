extends CharacterBody2D

@export var damage : int = 10


func _on_hitbox_area_entered(area: Area2D) -> void:
	
	if area.is_in_group("Player") && area.is_in_group("HurtBox"):
		var player : Character = area.get_parent()
		
		player.collided_with = self
		player.health_manager.take_damage(damage)
	
	pass # Replace with function body.
