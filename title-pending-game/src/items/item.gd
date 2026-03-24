class_name Item
extends Resource

@export_category("Primary Details")
@export var item_name : String = ""
@export var item_sprite : Texture2D = null
@export var price : int = 10
@export var max_quantity : int = 1

@export_category("misc")
@export var is_stackable : bool = false
@export var is_sellable : bool = false




signal item_used(action : String)


func use(_player : Player = null) -> void:
	return
