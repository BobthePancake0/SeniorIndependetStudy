extends Node2D




func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.owner.is_in_group("Player"):
		var player : Player = area.owner
		
		const WEAPON_TEST = preload("uid://cyaaoiieh4kc5")
		
		player.inventory.add_to_inventory(WEAPON_TEST)
		
		for slot : InventorySlot in player.inventory.weapon_inventory:
			if slot.item is WeaponTest:
				player.equipment.assign_sword_slot(slot)
				print("Testing assigning a slot instead of an item")
				break
				
		const BOMB_RESOURCE = preload("uid://cdm607fvf3qkb")
		
		player.inventory.add_to_inventory(BOMB_RESOURCE)
		for slot : InventorySlot in player.inventory.consumable_inventory:
			if slot.item:
				player.equipment.assign_item_slot(slot, 1)
				print("Assigning bombs to the first slot")
				break
		
		
	pass # Replace with function body.


func _on_area_2d_2_area_entered(area: Area2D) -> void:
	if area.owner.is_in_group("Player"):
		var player : Player = area.owner
		const WEAPON_TEST = preload("uid://cyaaoiieh4kc5")
		
		player.inventory.remove_from_inventory(WEAPON_TEST)
	pass # Replace with function body.
