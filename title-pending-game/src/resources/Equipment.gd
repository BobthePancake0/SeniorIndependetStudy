class_name Equipment
extends Resource

### EQUIPMENT
##
## Holds each of the items the player has assigned into it
##
## Each slot is designated it's own button
## When that button is pressed, if an item is assigned and has a USE function, it is called
##


@export var sword_slot : WeaponTest = null
@export var sword_button : String = "attack"

@export var item_1_slot : Item = null
@export var item_1_button : String = "item_1"

@export var item_2_slot : Item = null
@export var item_2_button : String = "item_2"

@export var item_3_slot : Item = null
@export var item_3_button : String = "item_3"


var player


func do_attack_button(event : InputEvent) -> bool:
	
			
	return false
			
func do_button_input(event : InputEvent) -> bool:
	
	if !event is InputEventMouseMotion and !event.is_echo() and !event.is_released():
		if event.is_action_pressed(sword_button):
			if sword_slot && sword_slot.has_method("use"):
				sword_slot.use(player)
				return true
			else:
				print("Cannot use that item")
				return false

		elif event.is_action_pressed(item_1_button):
			if item_1_slot && item_1_slot.has_method("use"):
				item_1_slot.use(player)
				return true
		elif event.is_action_pressed(item_2_button):
			if item_2_slot && item_2_slot.has_method("use"):
				item_2_slot.use(player)
				return true
		elif event.is_action_pressed(item_3_button):
			if item_3_slot && item_3_slot.has_method("use"):
				item_3_slot.use(player)
				return true

		print("Button cannot be Pressed.")
		print("No Item present in the slot")
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
