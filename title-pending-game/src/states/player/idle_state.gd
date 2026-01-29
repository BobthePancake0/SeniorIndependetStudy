class_name IdleState
extends State

## This state is entered when the character is stationary with
## no other effects being put on them

## Primarily used as a base state to then go into other states

func enter() -> void:
	## For Debugging
	$"../../StateDebug".text = name



func physics_update(_delta : float) -> void:

	if player.get_movement_direction().length() != 0:
		Transitioned.emit(self, "MoveState")
	
	pass
