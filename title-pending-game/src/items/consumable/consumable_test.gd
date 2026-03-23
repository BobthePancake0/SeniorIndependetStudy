class_name ConsumableTest
extends ItemConsumable

@export var original_item_variable : int


func use() -> void:
	print("using " + item_name)
