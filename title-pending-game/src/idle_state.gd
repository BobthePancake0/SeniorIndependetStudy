class_name IdleState
extends State

func enter() -> void:
	$"../../StateDebug".text = name

func physics_update(_delta : float) -> void:

	if player.get_movement_direction().length() != 0:
		Transitioned.emit(self, "MoveState")
	
	pass
