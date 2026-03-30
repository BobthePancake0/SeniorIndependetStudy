class_name AttackState
extends State

### ATTACK STATE
##
## The state containing the attack logic for the player. 
## 
## When Entered:
##		Plays the correct attack animation depending on the players direction
##
## Cannot EXIT this stats until the animation has finished playing
##
## EXITS into ->
##		Move State on input
## 		Idle on Nothing Else


func can_enter() -> bool:
	return player.ability_flags.has_sword

func enter() -> void:
	
	$"../../StateDebug".text = name		## For Debugging
	player.animation_player.play("attack_" + matchAttackAngle(player.direction))


func exit() -> void:
	player.animation_player.stop()
	

## Will not execute until the animation player has finished!
func update(_delta : float) -> void:
	await player.animation_player.animation_finished
	
	#if Input.get_vector("move_left", "move_right", "move_up", "move_down"):
	if player.get_movement_direction():
		Transitioned.emit(self, "MoveState")
	else:
		Transitioned.emit(self, "IdleState")
	pass


## Returns the correct animation name
## based on the players current facing direction
func matchAttackAngle(direction : Globals.Directions) -> String:
	match direction:
		Globals.Directions.RIGHT:
			return "right"
		Globals.Directions.LEFT:
			return "left"
		Globals.Directions.UP:
			return "up"
		Globals.Directions.DOWN:
			return "down"
		Globals.Directions.D_RIGHT:
			return "down_right"
		Globals.Directions.D_LEFT:
			return "down_left"
		Globals.Directions.U_LEFT:
			return "up_left"
		Globals.Directions.U_RIGHT:
			return "up_right"
		_:
			return "RESET"
