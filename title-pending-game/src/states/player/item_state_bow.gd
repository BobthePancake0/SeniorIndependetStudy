class_name ItemStateBow
extends State


var arrow_item_scene : PackedScene = preload("uid://bqlwsxp4qaoe2")
var arrow_resource : ArrowResource = preload("uid://bwgyrxpo3ujnx")

@export var spawn_position : Marker2D
var arrow_rotation : float = 0.0


## Check for the players arrow count in inventory
func enter() -> void:
	print("Entered the Bow Scene")
	#player.animation_player.play("Bow/use_bow_down")
	## Perform arrow check
	if check_arrows():
	
		player.inventory.remove_from_inventory(arrow_resource, 1)
		match_direction_animation(player.direction, "Bow/use_bow")
	
	else:
		match_direction_animation(player.direction, "Bow/fail_bow")
	
	



func update(_delta : float) -> void:
	await player.animation_player.animation_finished
	
	#if Input.get_vector("move_left", "move_right", "move_up", "move_down"):
	if player.get_movement_direction():
		Transitioned.emit(self, "MoveState")
	else:
		Transitioned.emit(self, "IdleState")
	pass


func check_arrows() -> bool:
	
	if player.inventory.inventory_has_item(arrow_resource):
		print("There are arrows")
		return true
	
	print("There are no arrows")
	return false


func shoot_arrow() -> void:
	var arrow_item : Arrow = arrow_item_scene.instantiate()
	
	## Set the arrows position
	if spawn_position:
		arrow_item.position += spawn_position.global_position
		
		
		arrow_item.rotation_degrees = roundf(spawn_position.global_rotation_degrees)

		get_tree().current_scene.add_child(arrow_item)
	pass
	
	
