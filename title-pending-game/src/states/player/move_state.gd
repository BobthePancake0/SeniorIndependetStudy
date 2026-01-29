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
		
		
func move_player() -> void:
	var input = player.get_movement_direction()
	player.velocity = input * (player.movement_speed * 50)
	player.move_and_slide()
	

func _on_health_manager_is_damaged() -> void:
	Transitioned.emit(self, "DamagedState")
	pass # Replace with function body.
