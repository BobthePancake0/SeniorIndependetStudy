class_name RollState
extends State

### ROLL STATE
##
## Logic for when the player is rolling
##
## When Entered:
##		Plays the roll animation
##		Calls the foll function
##
## Cannot EXIT this stats until the animation has finished playing
##
## EXITS into ->
##		Move State on input
## 		Idle on Nothing Else


@export var roll_speed : int = 2


func can_enter() -> bool:
	return player.ability_flags.can_roll


func enter() -> void:
	## For Debugging
	$"../../StateDebug".text = name
	player.animation_player.play("roll")
	perform_roll()
	

func update(_delta : float) -> void:
	await player.animation_player.animation_finished
	if Input.get_vector("move_left", "move_right", "move_up", "move_down"):
		Transitioned.emit(self, "MoveState")
	else:
		Transitioned.emit(self, "IdleState")
	pass

func physics_update(_delta : float) -> void:
	player.move_and_slide()
	pass


## If the player is not standing still,  i.e. velocity is 0
## roll with their current velocity
## If they are standing still
## make their velocity equal to their current vector direction * movement speed * roll
func perform_roll() -> void:
	
	if player.velocity != Vector2.ZERO:
		print("Rolling from Moving")
		player.velocity *= roll_speed
		print(player.velocity)
		
	else:
		print("Rolling from Idle")
		player.velocity = (player.direction_vector * (player.movement_speed)) * roll_speed
		print(player.direction_vector)
		print(player.velocity)

	
