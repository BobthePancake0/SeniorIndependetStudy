class_name PauseMenuSlot
extends Control

var inventory_slot : InventorySlot : set = _set_values

@export var button : Button

@export var marker : Control
@export var amount_label : Label

func _set_values(slot : InventorySlot) -> void:
	inventory_slot = slot
	
	if inventory_slot.item:
		print(inventory_slot)
		button.text = inventory_slot.item.item_name
		if inventory_slot.is_slot_stackable:
			amount_label.text = str(inventory_slot.quantity)
			amount_label.visible = true
		else:
			amount_label.visible = false
	else:
		button.text = "null"
		amount_label.text = "0"
		amount_label.visible = false
	pass



func get_equippable_spawn_pos() -> Vector2:
	return marker.global_position
	
