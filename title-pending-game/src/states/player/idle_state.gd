class_name IdleState
extends State

### IDLE STATE
##
## Contains the logic for whenever the player is Idle
##
## Simply for when the player is not actively doing anything, contains exit points
## for other states
##
## When entered:
##		ensures the players velocity is 0
##
## EXITS into -> 
##		Move state on vector input
##		Attack state on attack input and ability gained
##		Roll state on roll input and abaility gained


func enter() -> void:
	## For Debugging
	$"../../StateDebug".text = name
	player.velocity = Vector2.ZERO



func handle_input(_event : InputEvent) -> void:
	if (_event.is_action("move_left") || _event.is_action("move_right") || _event.is_action("move_up") || _event.is_action("move_down")) and not _event.is_echo():
		Transitioned.emit(self, "MoveState")
		
	if _event.is_action_pressed("attack") and not _event.is_echo():
		#if player.has_sword:
		Transitioned.emit(self, "AttackState")
	
	if _event.is_action_pressed("roll") and not _event.is_echo():
		Transitioned.emit(self, "RollState")

	pass
