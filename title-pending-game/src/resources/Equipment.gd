class_name Equipment
extends Resource

### EQUIPMENT
##
## Holds each of the items the player has assigned into it
##
## Each slot is designated it's own button
## When that button is pressed, if an item is assigned and has a USE function, it is called
##


var sword_slot : InventorySlot = null
@export var sword_button : String = "attack"

var item_1_slot : InventorySlot = null
@export var item_1_button : String = "item_1"

var item_2_slot : InventorySlot = null
@export var item_2_button : String = "item_2"

var item_3_slot : InventorySlot = null
@export var item_3_button : String = "item_3"


var player		# set to the instance of the player on load



func assign_sword_slot(inventory_slot : InventorySlot) -> void:
	if inventory_slot.item is WeaponTest:
		sword_slot = inventory_slot

func remove_sword_slot() -> void:
	sword_slot = null

func assign_item_slot(inventory_slot : InventorySlot, slot_number : int) -> void:
	if inventory_slot.item && inventory_slot.item.is_equippable:
		match slot_number:
			1:
				print("Assigning a slot with " + inventory_slot.item.item_name + " inventory equipment slot " , slot_number, "!")
				item_1_slot = inventory_slot
			2:
				print("Assigning a slot with " + inventory_slot.item.item_name + " inventory equipment slot " , slot_number, "!")
				item_2_slot = inventory_slot
			3:
				print("Assigning a slot with " + inventory_slot.item.item_name + " inventory equipment slot " , slot_number, "!")
				item_3_slot = inventory_slot
			_:
				print("Not a viable slot number")
	
	print("Slot does not contain an item, cannot assign")

func remove_item_slot(slot_number : int) -> void:
	match slot_number:
			1:
				item_1_slot = null
			2:
				item_2_slot = null
			3:
				item_3_slot = null
			_:
				print("Not a viable slot number")
			
func do_button_input(event : InputEvent) -> bool:
	
	if !event is InputEventMouseMotion and !event.is_echo() and !event.is_released():
		if event.is_action_pressed(sword_button):
			if sword_slot :#&& sword_slot.has_method("use"):
				sword_slot.use_item(player)
				return true
			else:
				print("Cannot use that item")
				return false

		elif event.is_action_pressed(item_1_button):
			if item_1_slot :#&& item_1_slot.has_method("use"):
				item_1_slot.use_item(player)
				return true
		elif event.is_action_pressed(item_2_button):
			if item_2_slot :#&& item_2_slot.has_method("use"):
				item_2_slot.use_item(player)
				return true
		elif event.is_action_pressed(item_3_button):
			if item_3_slot :#&& item_3_slot.has_method("use"):
				item_3_slot.use_item(player)
				return true

		#print("Button cannot be Pressed.")
		#print("No Item present in the slot")
		return false
	
	return false


#func _input(_event: InputEvent) -> void:
#
	#print("input entered!")
#
	#if _event.is_action_pressed(sword_button):
		#if sword_slot && sword_slot.has_method("use"):
			#sword_slot.use()
		#else:
			#print("Cannot use that item")
	#
	#elif _event.is_action_pressed(item_1_button):
		#if item_1_slot && item_1_slot.has_method("use"):
			#item_1_slot.use()
	#elif _event.is_action_pressed(item_2_button):
		#if item_2_slot && item_2_slot.has_method("use"):
			#item_2_slot.use()
	#elif _event.is_action_pressed(item_3_button):
		#if item_3_slot && item_3_slot.has_method("use"):
			#item_3_slot.use()
			#
	#print("Button not pressed")
	#pass
