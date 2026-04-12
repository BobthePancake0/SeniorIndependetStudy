class_name PauseMenuEquip
extends Panel


@export var button_1 : Button
@export var button_2 : Button
@export var button_3 : Button

var slot : InventorySlot


func _init() -> void:
	#button_1.pressed.connect(_on_button_pressed.bind(1))
	#button_2.pressed.connect(_on_button_pressed.bind(2))
	#button_3.pressed.connect(_on_button_pressed.bind(3))
	pass


func _ready() -> void:
	button_1.pressed.connect(_on_button_pressed.bind(1))
	button_2.pressed.connect(_on_button_pressed.bind(2))
	button_3.pressed.connect(_on_button_pressed.bind(3))
	grab_focus()
	pass



func _on_button_pressed(index : int) -> void:
	
	if slot:
		var player : Player = get_tree().get_first_node_in_group("Player")
		player.equipment.assign_item_slot(slot, index)
	print(index)
	queue_free()


func _on_exit_pressed() -> void:
	queue_free()
	pass # Replace with function body.
