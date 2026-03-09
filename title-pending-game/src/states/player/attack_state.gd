class_name AttackState
extends State

### ATTACK STATE
##
## The state containing the attack logic for the player. 
## 
## When entered:
##		Plays the correct attack animation depending on the players direction
##
## Cannot EXIT this stats until the animation has finished playing
##
## EXITS into ->
##		Move State on input
## 		Idle on Nothing Else

func enter() -> void:
	
	$"../../StateDebug".text = name		## For Debugging
	player.animation_player.play(matchAttackAngle(player.direction))
	
	

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
			return "horizontal_r_attack"
		Globals.Directions.LEFT:
			return "horizontal_l_attack"
		Globals.Directions.UP:
			return "up_attack"
		Globals.Directions.DOWN:
			return "down_attack"
		Globals.Directions.D_RIGHT:
			return "diagonal_dr_attack"
		Globals.Directions.D_LEFT:
			return "diagonal_dl_attack"
		Globals.Directions.U_LEFT:
			return "diagonal_ul_attack"
		Globals.Directions.U_RIGHT:
			return "diagonal_ur_attack"
		_:
			return "RESET"
