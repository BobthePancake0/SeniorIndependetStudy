class_name InventorySlot
extends Node


@export var item : Item = null
@export var is_slot_stackable : bool = false
@export var quantity : int = 0
@export var is_slot_empty : bool = true


## Need signal functions for
## When an item is added to the slot
##
## When an item is removed to the slot


func add_item(newItem : Item, _amount : int = 0) -> void:
	if _amount > 0 && newItem.is_stackable:
		## If the Item is stackable and requires an amount to be added into inventory
		## Adds to the quantity
		quantity = _amount
		pass 
	else:
		## If the Item is not stackable, the quantity should always be 1
		quantity = 1
		
	item = newItem
	
	is_slot_empty = false
	is_slot_stackable = item.is_stackable
	print(item.item_name + " Add to slot!\nSlot is no longer empty!\nSlot stackable: ", is_slot_stackable)
	pass

func add_item_quantity(amount : int = 0) -> void:
	if (item):
		if (amount > 0):
			quantity += amount
		else:
			quantity += 1
		print("The Slot for " + item.item_name + " now holds ", quantity)
	else:
		print("There is no existing item. Cannot add to quantity")

func remove_item(_amount : int = 0) -> void:
	if _amount > 0 && is_slot_stackable:
		## If there is an amount, remove from the amount
		## Only remove the full item from the inventory once quantity reaches 0 or below 
		pass ## Will work on this part later
	print("Removing " + item.item_name + " from Slot!")
	item = null
	pass
