class_name MoveState
extends State

### MOVE STATE
##
## Contains logic for moving the player character
##
## Moves the player every physics update depnding on their 
## inputted direction
##
## When Entered:
##		
##
## EXIT into -> 
##		Idle state on the players velocity reaching 0.0
##		Attack state on attack input and ability gained
##		Roll state on roll input and abaility gained


func enter() -> void:
	$"../../StateDebug".text = name

func physics_update(_delta : float) -> void:
	move_player()
	
	## If no movement, swap to idle state
	if player.velocity.length() <= 0:
		Transitioned.emit(self, "IdleState")
		
	
func handle_input(_event : InputEvent) -> void:

	if _event.is_action_pressed("attack") and not _event.is_echo():
		#if player.has_sword:
		Transitioned.emit(self, "AttackState")
		
	if _event.is_action_pressed("roll") and not _event.is_echo():
		Transitioned.emit(self, "RollState")
	pass


## Takes vectorized direction as input
## and apllies it to the players velocity
func move_player() -> void:
	var input = player.get_movement_direction()
	if input != Vector2.ZERO:
		player.direction_vector = input

	player.direction = player.setDirection(input)
	player.velocity = input * (player.movement_speed)
	player.move_and_slide()
