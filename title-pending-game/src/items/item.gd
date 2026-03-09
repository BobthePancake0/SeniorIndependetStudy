class_name Item
extends Resource

@export_category("Primary Details")
@export var item_name : String = ""
@export var item_sprite : Texture2D = null
@export var price : int = 0

@export_category("misc")
@export var is_stackable : bool = false
@export var is_sellable : bool = false

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
#func _init(initial_name : String = "", sprite : Texture2D = Texture2D.new(), stackable: bool = false) -> void:
	#item_name = initial_name
	#item_sprite = sprite
	#is_stackable = stackable
