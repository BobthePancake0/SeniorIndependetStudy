extends CanvasLayer

@export_category("Main Area")
@export var menu_button: MenuButton
var popup_menu : PopupMenu

@export_category("Labels")
@export var inventory_label : Label
@export var current_item : Label

@export_category("Central Section")
@export_subgroup("Selections")
@export var slot_spinbox : SpinBox
@export var item_options : OptionButton
@export_subgroup("Buttons")
@export var remove : Button
@export var add : Button


## References
var player : Player
var inventory
var slot : InventorySlot
var item_uid_list : Array[String] = []
var item_uid

func _on_visibility_changed() -> void:
	if visible:
		setup()
	pass # Replace with function body.

func _ready() -> void:
	visible = false
	player = get_tree().get_first_node_in_group("Player")
	popup_menu = menu_button.get_popup()
	
	popup_menu.id_pressed.connect(_on_id_pressed)
	pass

func setup() -> void:
	remove.visible = false
	add.visible = false
	update_slot(int(slot_spinbox.value) - 1)

func _on_id_pressed(id : int) -> void:
	change_mode(id)



func change_mode(id : int) -> void:
	match id:
		0:
			inventory_label.text = popup_menu.get_item_text(id)
			inventory = player.inventory.weapon_inventory
			add.visible = true
		1: 
			inventory_label.text = popup_menu.get_item_text(id)
			inventory = player.inventory.consumable_inventory
			add.visible = true
		2: 
			inventory_label.text = popup_menu.get_item_text(id)
			inventory = player.inventory.key_inventory
			add.visible = true
		_:
			print()
	set_initial_mode_value()	
	set_item_options()

func set_initial_mode_value() -> void:
	slot_spinbox.value = 1
	var slot_number = slot_spinbox.value - 1
	update_slot(slot_number)

func update_slot(value : int) -> void:
	if inventory:
		slot = inventory[value]
		if slot.is_slot_empty:
			current_item.text = "EMPTY"
			remove.visible = false
		else:
			current_item.text = slot.item.item_name
			remove.visible = true
		

func _on_spin_box_value_changed(value: float) -> void:
	
	update_slot(int(value) - 1)


func set_item_options() -> void:
	item_options.clear()
	item_options.add_item("")	## Selection Buffer
	
	item_uid_list.clear()
	
	var dir
	var files
	
	if (inventory_label.text == popup_menu.get_item_text(0)):	## Weapon
		dir = "res://resources/items/weapons/"
		files = DirAccess.get_files_at(dir)
		
	elif (inventory_label.text == popup_menu.get_item_text(1)):	## Consumable
		dir = "res://resources/items/consumables/"
		files = DirAccess.get_files_at(dir)
		pass
	elif (inventory_label.text == popup_menu.get_item_text(2)):	## Key
		dir = "res://resources/items/keys/"
		files = DirAccess.get_files_at(dir)
		pass		
	
	for file in files:
		var id = ResourceLoader.get_resource_uid(dir+file)
		var uid = ResourceUID.id_to_text(id)
		item_uid_list.append(uid)
		item_options.add_item(file.trim_suffix(".tres"))
	pass	
	

func _on_option_button_item_selected(index: int) -> void:
	if item_options.get_item_text(index) == "":
		item_uid = ""
		pass
	else:
		item_uid = item_uid_list[index - 1]
		#item_uid = "res://resources/items/" + inventory_label.text.to_lower() + "s/" + item_options.get_item_text(index) + ".tres"
		pass
	pass # Replace with function body.

func _on_remove_pressed() -> void:
	if player && slot && inventory:
		var slot_number = slot_spinbox.value - 1
		player.inventory.remove_from_inventory(slot.item, 0, slot_number)
		update_slot(slot_number)
	pass # Replace with function body.


func _on_add_pressed() -> void:
	if item_uid and item_uid != "":

		if player && slot && inventory:
			if slot.is_slot_empty:
				var item = load(item_uid)
				if item is Item:
					var slot_number = slot_spinbox.value - 1
					player.inventory.add_to_inventory(item, 0, slot_number)
					update_slot(slot_number)
	pass # Replace with function body.
