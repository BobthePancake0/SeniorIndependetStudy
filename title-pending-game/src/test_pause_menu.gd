extends CanvasLayer


func _init() -> void:
	
	hide()


func _on_visibility_changed() -> void:
	if visible:
		print("asdasd")
		setup_inventory()
	else:
		print("Closing Menu")
	pass # Replace with function body.
	



func setup_inventory() -> void:
	var player : Player = get_tree().get_first_node_in_group("Player")
	
	var weapons_menu = $Control/WeaponContainer
	var consumable_menu = $Control/ConsumableContainer
	var key_menu = $Control/KeyContainer
	
	assign_container_buttons(weapons_menu, player.inventory.weapon_inventory)
	assign_container_buttons(consumable_menu, player.inventory.consumable_inventory)
	assign_container_buttons(key_menu, player.inventory.key_inventory)
	
	

func assign_container_buttons(container : HBoxContainer, player_inventory) -> void:
	if player_inventory is Array:
		for slot_number in container.get_child_count():
			var slot_button : PauseMenuSlot = container.get_child(slot_number)
			slot_button.inventory_slot = player_inventory[slot_number]
			if not slot_button.pressed.get_connections():
				slot_button.pressed.connect(_on_slot_pressed.bind(slot_button))

func _on_slot_pressed(slot : PauseMenuSlot) -> void:
	print(slot.text)
	
