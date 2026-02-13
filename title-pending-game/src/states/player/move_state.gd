class_name MoveState
extends State

## This state is gotten into when the player presses a
## directional movement

func enter() -> void:
	$"../../StateDebug".text = name

func physics_update(_delta : float) -> void:
	move_player()
	
	## If no movement, swap to idle state
	if player.velocity.length() <= 0:
		Transitioned.emit(self, "IdleState")
		
	
func handle_input(_event : InputEvent) -> void:
	#if (_event.is_action_released("move_down") || _event.is_action_released("move_right") || _event.is_action_released("move_up") || _event.is_action_released("move_down")) && not _event.is_echo():
		#Transitioned.emit(self, "IdleState")
	pass

func move_player() -> void:
	var input = player.get_movement_direction()
	player.direction = player.setDirection(input)
	player.velocity = input * (player.movement_speed * 50)
	player.move_and_slide()


#func _on_health_manager_is_damaged() -> void:
	#Transitioned.emit(self, "DamagedState")
	#pass # Replace with function body.
