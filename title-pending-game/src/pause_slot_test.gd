class_name PauseMenuSlot
extends Button

var inventory_slot : InventorySlot : set = _set_values

func _set_values(slot : InventorySlot) -> void:
	inventory_slot = slot
	
	if inventory_slot.item:
		print(inventory_slot)
		text = inventory_slot.item.item_name
	else:
		text = "null"
	pass
