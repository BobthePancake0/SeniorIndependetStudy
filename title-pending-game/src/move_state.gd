class_name MoveState
extends State

func enter() -> void:
	$"../../StateDebug".text = name

func physics_update(_delta : float) -> void:
	move_player()
	
	## If no movement, swap to idle state
	if player.velocity.length() <= 0:
		Transitioned.emit(self, "IdleState")
		
func move_player() -> void:
	var input = player.get_movement_direction()
	player.velocity = input * (player.speed * 50)
	player.move_and_slide()
