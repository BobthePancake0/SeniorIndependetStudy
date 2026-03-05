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
	
	money = 10
	
	
	test_add_to_inventory()
	



## Checks what type of item it is to determine which inventory to add to
## Checks if the item is stackable or not
## Goes through each inventory slot for the next empty one

### CURRENTLY NEEDS TO:
## Check if the item is stackable
## If it is, then it adds to the first slot with the same item as it
## If there is no slot with the same item, then adds item to the first empty slot
## If there is no available empty slot, exits processing
func add_to_inventory(item : Item, _amount : int = 0) -> void:
	var slot_type = Item.Types.keys()[item.item_type].to_pascal_case()
	print("------------")
	print(slot_type)
	match slot_type:
		"Key":
			_item_to_inventory(item, weapon_inventory, _amount)
		"Weapon":
			_item_to_inventory(item, weapon_inventory, _amount)
		"Consumable":
			_item_to_inventory(item, consumable_inventory, _amount)
		_:
			print("Item is not of an exitsing type.\nExiting Adding to Inventory!")
	pass

## Adds the item to the specified inventory
## inventory parameter is one of the three
## inventory vararibles declared above
func _item_to_inventory(item: Item, inventory, _amount = 0) -> void:
	if (item.is_stackable):
		for slot : InventorySlot in inventory:
			if slot.item == item:
				slot.add_item_quantity(_amount)
				return
		print("There is no slot with " + item.item_name + "yet.\nChecking for next available slot!")
			
	for slot : InventorySlot in inventory:
		if slot.is_slot_empty:
			slot.add_item(item, _amount)
			return
				
	print("Inventory Full.\nExiting Adding to Inventory!")
	return

func test_add_to_inventory() -> void:
	var item = Item.new("Tester")
	add_to_inventory(item)
	var item2 = Item.new("Testing")
	add_to_inventory(item2)
	var item3 = Item.new("Testing", Sprite2D.new(), Item.Types.KEY, true)
	add_to_inventory(item3)
	
	var item4 = item3
	add_to_inventory(item3)
	add_to_inventory(item4, 5)


## Looks at the item type to determine what inventory should be analyzed
## Looks at each inventory for their size amount
## If the item is found, removes it from specified inventory
## If the item is not found, returns false or whatever
func remove_from_inventory(item : Item, _amount : int = 0) -> void:
	pass
	
