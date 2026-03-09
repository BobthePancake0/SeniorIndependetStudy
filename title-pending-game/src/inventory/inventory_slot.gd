class_name InventorySlot
extends Node


@export var item : Item = null
@export var is_slot_stackable : bool = false
@export var quantity : int = 0
@export var is_slot_empty : bool = true


### ADDS an ITEM to the slot
## Is called if the item does not yet exist
## 
## CONDITIONALS:
## If the item being added is new and stackable
## Add to the quantity of the item that is in the slot
## 		If the amount is not given, simply make the quantity 1
## 
## Ensures that the slot is declared as not empty 
## Ensures the slots stackability aligns with the items stackability
##
## PARAMS:
## newItem -> Item
##		The item being added to the slot
## _amount -> int (optional)
## 		The amount being added to the quantity
##		Defaults to 0 if not passed through
##		Only matters if newItem is stackable
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

### ADDS to the QUANTITY of an existing ITEM
## 
## CONDITIONALS:
## Only goes through if an item already exists in the slot
## If the amount is not given, simply adds 1 to the quantity
##
## PARAMS:
## _amount -> int (optional)
## 		the amount being added to the quantity
##		defaults to 1 if not passed through
func add_item_quantity(_amount : int = 1) -> void:
	if (item):
		if _amount >= 0:
			quantity += _amount
		else:
			print("Cannot add negative numbers to amount!\nExiting Process!")
		print("The Slot for " + item.item_name + " now holds ", quantity)
	else:
		print("There is no existing item. Cannot add to quantity")

### REMOVES from the QUANTITY of an ITEM
### REMOVES an ITEM from the slot
## 
## CONDITIONALS:
## Only goes through if an item already exists in the slot
## 
## If the item in the slot is stackable
## 		removes an amount from the quantity of the slot
## Else it simply sets the quantity to 0
## 
## If the quantity of the slot is less than or equal 0
##		sets the item in slot to null
##		declares the slot as empty
##		ensures the quantity clamps to 0 (no negative numbers)
##
## PARAMS:
## _amount -> int (optional)
## 		the amount being removed from the quantity
##		defaults to 0 if not passed through
func remove_item(_amount : int = 0) -> void:
	if item:
		if is_slot_stackable && _amount > 0:
			## If there is an amount, remove from the amount
			## Only remove the full item from the inventory once quantity reaches 0 or below 
			quantity -= _amount
			print("Removing ", _amount, " " + item.item_name + "!\nThere are ", quantity, " remaining!")
		elif is_slot_stackable:
			quantity -= 1
			print("Removing one " + item.item_name + "!\nThere are ", quantity, " remaining!")
		else:
			quantity = 0
		if (quantity <= 0):
			print("Removing " + item.item_name + " from Slot!")
			quantity = 0
			item = null
			is_slot_empty = true		
	else:
		print("There is no item present in this slot. \n Exiting removal procedure!")
	pass
