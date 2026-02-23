class_name IdleState
extends State

## This state is entered when the character is stationary with
## no other effects being put on them

## Primarily used as a base state to then go into other states

func enter() -> void:
	## For Debugging
	$"../../StateDebug".text = name
	player.velocity = Vector2.ZERO



func handle_input(_event : InputEvent) -> void:
	if (_event.is_action("move_left") || _event.is_action("move_right") || _event.is_action("move_up") || _event.is_action("move_down")) and not _event.is_echo():
		Transitioned.emit(self, "MoveState")
		
	if _event.is_action_pressed("attack") and not _event.is_echo():
		Transitioned.emit(self, "AttackState")
	
	if _event.is_action_pressed("roll") and not _event.is_echo():
		Transitioned.emit(self, "RollState")

	pass
