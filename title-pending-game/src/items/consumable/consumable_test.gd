class_name ConsumableTest
extends ItemConsumable

@export var original_item_variable : int


func use(_player : Player = null) -> void:
	print(item_name)
