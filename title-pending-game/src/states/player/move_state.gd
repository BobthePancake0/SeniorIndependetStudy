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

func exit() -> void:
	player.animation_player.stop()
	pass

func update(_delta : float) -> void:
	pass

func physics_update(_delta : float) -> void:
	move_player()
	
	## If no movement, swap to idle state
	if player.velocity.length() <= 0:
		Transitioned.emit(self, "IdleState")
		
	
func handle_input(_event : InputEvent) -> void:


	#if player.has_sword && player.equipment.do_attack_button(_event) :
		#Transitioned.emit(self, "AttackState")
		
	#if _event.is_action_pressed("attack") and not _event.is_echo():
		##if player.has_sword:
		#Transitioned.emit(self, "AttackState")
		
	if _event.is_action_pressed("roll") and not _event.is_echo():
		Transitioned.emit(self, "RollState")
	
	else:
		player.equipment.do_button_input(_event)
	pass


## Takes vectorized direction as input
## and apllies it to the players velocity
func move_player() -> void:
	var input = player.get_movement_direction()

	player.direction = player.setDirection(input)
	match_direction_animation(player.direction, "Movement/move")
	player.velocity = input * (player.movement_speed)
	player.move_and_slide()


#func match_direction_animation(direction : Vector2) -> void:
	#var animation_player : AnimationPlayer = player.animation_player
	#match direction:
		#Vector2.RIGHT:
			#player.animated_sprite_2d.flip_h = false
			#animation_player.play("Movement/move_side")
		#Vector2.LEFT:
			#player.animated_sprite_2d.flip_h = true
			#animation_player.play("Movement/move_side")
		#Vector2.UP:
			#animation_player.play("Movement/move_up")
		#Vector2.DOWN:
			#animation_player.play("Movement/move_down")
	#if dir == Vector2.RIGHT: #Vector2(1, 0)
		#return Globals.Directions.RIGHT
	#elif dir.x > 0 && dir.y > 0: 
		#return Globals.Directions.D_RIGHT
	#elif dir == Vector2.DOWN: # Vector2(0, 1)
		#return Globals.Directions.DOWN
	#elif dir.x < 0 && dir.y > 0:
		#return Globals.Directions.D_LEFT
	#elif dir == Vector2.LEFT: # Vector2(-1, 0)
		#return Globals.Directions.LEFT
	#elif dir.x < 0 && dir.y < 0:
		#return Globals.Directions.U_LEFT
	#elif dir == Vector2.UP: # Vector2(0, -1)
		#return Globals.Directions.UP
	#elif dir. x > 0 && dir.y < 0:
		#return Globals.Directions.U_RIGHT
	
