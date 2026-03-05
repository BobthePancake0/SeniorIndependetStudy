class_name Item
extends Node

enum Types {WEAPON, KEY, CONSUMABLE}


@export var item_name : String = ""
@export var item_sprite : Sprite2D = null
@export var item_type : Types = Types.WEAPON
@export var is_stackable : bool = false

### Initializes an item with parameters when calling Item.new()...
##
## PARAMS:
## initial_name -> string
##		sets the name of the item
## sprite -> Sprite2D
##		sets the sprite of the item
## type -> Types (enum)
##		sets the type of the item
## stackable -> bool
##		sets the stackability of the item
func _init(initial_name : String = "", sprite : Sprite2D = Sprite2D.new(), type : Types = Types.WEAPON, stackable: bool = false) -> void:
	item_name = initial_name
	item_sprite = sprite
	item_type = type
	is_stackable = stackable
