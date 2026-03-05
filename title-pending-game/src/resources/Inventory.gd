class_name Inventory
extends Resource

## Each Inventory will need a Max Size Varibale
## All inventories arrays will hold individual inventory slots
## Not type calling the arrays is simply for testing purposes at the moment.
@export_category("Inventories")
@export var key_inventory = []
const MAX_KEY_SIZE = 10

@export var weapon_inventory  = []
const MAX_WEAPON_SIZE = 10

@export var consumable_inventory = []
const MAX_CONS_SIZE = 10

@export var money : int = 0


func _init() -> void:
	default_inventories.call_deferred()
	pass

### SETS the DEFAUTLS for the INVENTORIES on INITIALIZATION
## 
## Rezieses each of the inventories to their max size (10)
## 		These inventory sizes should Never Change
## Places an empty InventorySlot object into each inventory
func default_inventories() -> void:
	print("Hitting Default Inventories!")
	key_inventory.resize(MAX_KEY_SIZE)
	weapon_inventory.resize(MAX_WEAPON_SIZE)
	consumable_inventory.resize(MAX_CONS_SIZE)
	for i in MAX_KEY_SIZE:
		key_inventory[i] = InventorySlot.new()
	for i in MAX_WEAPON_SIZE:
		weapon_inventory[i] = InventorySlot.new()
	for i in MAX_CONS_SIZE:
		consumable_inventory[i] = InventorySlot.new()
	
	test_inventory()
	



### ADDS an ITEM to an INVENTORY
##
## Checks what type the item is
## Matches the item type to a specific inventory type
##
## Declares a refactored function to add item to type matched inventory
##
## PARAMS:
## item -> Item
##		The item being added to an inventory
## _amount -> int (optional)
##		The amount of the item being added to an inventory
## 		Defaults to 0 if not passed through
func add_to_inventory(item : Item, _amount : int = 0) -> void:
	var slot_type = Item.Types.keys()[item.item_type].to_pascal_case()
	print("------------")
	print(slot_type)
	match slot_type:
		"Key":
			_item_to_inventory(item, key_inventory, _amount)
		"Weapon":
			_item_to_inventory(item, weapon_inventory, _amount)
		"Consumable":
			_item_to_inventory(item, consumable_inventory, _amount)
		_:
			print("Item is not of an exitsing type.\nExiting Adding to Inventory!")
	pass

### ADDS an ITEM to a specified INVENTORY
##
## A Refactored function to clean copied code
##
## CONDITIONALS:
## If the item is considered stackable
## 		Goes through each of the slots in an inventory
##		Checks for if an item exists
##			Adds to the quantity of the existing item in slot
##			Exits full function processing
## Else, the item may still be stackable but is not already in the inventory
##		Goes through each of the slots in an inventory
##		If the slot is empty, it does not already contain an item
##			Adds a new item to the slot
##			Exits full function processing
##
## If the function reaches the end, the Inventory is Full
##
## PARAMS:
## item -> Item
##		The item being added to the inventory
## inventory -> / (typeless)
##		The inventory being searched and added to
## _amount -> int (optional)
##		The amount of the item being added to an inventory
## 		Defaults to 0 if not passed through
func _item_to_inventory(item: Item, inventory, _amount = 0) -> void:
	if (item.is_stackable):
		for slot : InventorySlot in inventory:
			if slot.item == item:
				slot.add_item_quantity(_amount)
				return
		print("There is no slot with " + item.item_name + " yet.\nChecking for next available slot!")
			
	for slot : InventorySlot in inventory:
		if slot.is_slot_empty:
			slot.add_item(item, _amount)
			return
				
	print("Inventory Full.\nExiting Adding to Inventory!")
	return


### REMOVES an ITEM from an INVENTORY
## 
## Checks what type the item is
## Matches the item type to a specific inventory type
## Declares a refactored function to add item to type matched inventory
##
## PARAMS:
## item -> Item
##		The item being removed from an inventory
## _amount -> int (optional)
##		The amount of the item being removed from an inventory
##		Defaults to 0 if not passed through
func remove_from_inventory(item : Item, _amount : int = 0) -> void:
	var slot_type = Item.Types.keys()[item.item_type].to_pascal_case()
	print("------------")
	print(slot_type)
	match slot_type:
		"Key":
			item_from_inventory(item, key_inventory, _amount)
		"Weapon":
			item_from_inventory(item, weapon_inventory, _amount)
		"Consumable":
			item_from_inventory(item, consumable_inventory, _amount)
		_:
			print("Item is not of an exitsing type.\nExiting Adding to Inventory!")
	pass

### REMOVES an ITEM from a specified INVENTORY
##
## A Refactored function to clean copied code
##
## CONDITIONALS:
## Goes through each slot of an inventory
##
## If the slot contains an item AND the parameterized item matches the item in a slot
## 		removes an amount from the inventory
##		could remove the item entirely
##
## PARAMS:
## item -> Item
##		The item being removed from the inventory
## inventory -> / (typeless)
##		The inventory being searched and removed from
## amount -> int 
##		The amount of the item being removed from an inventory
## 		will be 0 if not passed through from the parent function
func item_from_inventory(item : Item, inventory, amount : int):
	for slot : InventorySlot in inventory:
		if !slot.is_slot_empty:
			if slot.item == item:
				slot.remove_item(amount)
				return
		
	print(item.item_name + " not within the Inventory!\nExiting Adding to Inventory!")
	return

func test_inventory() -> void:
	var item = Item.new("Tester")
	add_to_inventory(item)
	var item2 = Item.new("Testing")
	add_to_inventory(item2)
	var item3 = Item.new("KeyTesting", Sprite2D.new(), Item.Types.KEY, true)
	add_to_inventory(item3)
	
	var item4 = item3
	add_to_inventory(item3)
	add_to_inventory(item4, 5)
	
	remove_from_inventory(item)
	remove_from_inventory(item)
	remove_from_inventory(item2)
	remove_from_inventory(item3, 5)
	remove_from_inventory(item3, 5)
