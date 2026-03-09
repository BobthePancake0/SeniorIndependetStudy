extends Node2D




func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.owner.is_in_group("Player"):
		var player : Player = area.owner
		const WEAPON_TEST = preload("uid://cyaaoiieh4kc5")
		
		player.inventory.add_to_inventory(WEAPON_TEST)
	pass # Replace with function body.


func _on_area_2d_2_area_entered(area: Area2D) -> void:
	if area.owner.is_in_group("Player"):
		var player : Player = area.owner
		const WEAPON_TEST = preload("uid://cyaaoiieh4kc5")
		
		player.inventory.remove_from_inventory(WEAPON_TEST)
	pass # Replace with function body.
