class_name AttackState
extends State

## More or less a current testing state to see how this would perform.
##
## When the state is entered, plays the attack animation corresponding to the direction
## the player is facing
##
## When the animation is finished, go back to either idle to move state

func enter() -> void:
	## For Debugging
	$"../../StateDebug".text = name
	player.animation_player.play(player.matchAttackAngle())
	
	


func update(_delta : float) -> void:
	await player.animation_player.animation_finished
	if Input.get_vector("move_left", "move_right", "move_up", "move_down"):
		Transitioned.emit(self, "MoveState")
	else:
		Transitioned.emit(self, "IdleState")
	pass

func physics_update(_delta : float) -> void:


	pass

func handle_input(_event : InputEvent) -> void:
	
	#if (_event.is_action("move_left") || _event.is_action("move_right") || _event.is_action("move_up") || _event.is_action("move_down")) and _event.is_echo():
		#Transitioned.emit(self, "MoveState")
	#else:
		#Transitioned.emit(self, "IdleState")

	pass
