class_name State
extends Node

### Base Class for ALL States
##
## Contains mutable functions which each state can 
## edit to their own specifics

signal Transitioned

@export var transition_list : Array[State] = []

@export var player : Player		## Reference to the Player Character

#enum AnimDirection {UP, DOWN, RSIDE, LSIDE}
#var previous_anim_direction : AnimDirection = AnimDirection.DOWN
static var previous_anim_direction : String

func enter() -> void:
	pass

func exit() -> void:
	pass

func update(_delta : float) -> void:
	pass

func physics_update(_delta : float) -> void:
	pass

func handle_input(_event : InputEvent) -> void:
	pass
	
func can_enter() -> bool:
	return true
	
func can_transition(new_state : State) -> bool:
	
	for state in transition_list:
		if state == new_state:
			return true
	
	return false
	

#func match_direction_animation(direction : Vector2, animation_name : String) -> void:
	#var animation_player : AnimationPlayer = player.animation_player
	#print("animation direction: " , direction)
	#match direction:
		#Vector2.RIGHT:
			#player.animated_sprite_2d.flip_h = false
			#if animation_player.has_animation(animation_name + "_side"):
				#animation_player.play(animation_name + "_side")
			#else:
				#print("Animation not found to the RIGHT")
		#Vector2.LEFT:
			#player.animated_sprite_2d.flip_h = true
			#if animation_player.has_animation(animation_name + "_side"):
				#animation_player.play(animation_name + "_side")
			#else:
				#print("Animation not found to the LEFT")
		#Vector2.UP:
			#if animation_player.has_animation(animation_name + "_up"):
				#animation_player.play(animation_name + "_up")
			#else:
				#print("Animation not found to the UP")
		#Vector2.DOWN:
			#if animation_player.has_animation(animation_name + "_down"):
				#animation_player.play(animation_name + "_down")
			#else:
				#print("Animation not found to the DOWN")
		#_:
			#print("Nothing ever Matches!")
func match_direction_animation(direction : Globals.Directions, animation_name : String, _animation_end : String = "") -> void:
	var animation_player : AnimationPlayer = player.animation_player
	#print("animation direction: " , direction)
	
	if _animation_end > "":
		if animation_player.has_animation(animation_name + _animation_end):
				#previous_anim_direction = AnimDirection.RSIDE
				previous_anim_direction = _animation_end
				animation_player.play(animation_name + _animation_end)
		else:
			print("Animation not found to the " + _animation_end)
	
	match direction:
		Globals.Directions.RIGHT:
			player.animated_sprite_2d.flip_h = false
			if animation_player.has_animation(animation_name + "_side"):
				#previous_anim_direction = AnimDirection.RSIDE
				previous_anim_direction = "_side"
				animation_player.play(animation_name + "_side")
			else:
				print("Animation not found to the RIGHT")
		Globals.Directions.LEFT:
			player.animated_sprite_2d.flip_h = true
			if animation_player.has_animation(animation_name + "_side"):
				#previous_anim_direction = AnimDirection.LSIDE
				previous_anim_direction = "_side"
				animation_player.play(animation_name + "_side")
			else:
				print("Animation not found to the LEFT")
		Globals.Directions.UP:
			if animation_player.has_animation(animation_name + "_up"):
				#previous_anim_direction = AnimDirection.UP
				previous_anim_direction = "_up"
				animation_player.play(animation_name + "_up")
			else:
				print("Animation not found to the UP")
		Globals.Directions.DOWN:
			if animation_player.has_animation(animation_name + "_down"):
				#previous_anim_direction = AnimDirection.DOWN
				previous_anim_direction = "_down"
				animation_player.play(animation_name + "_down")
			else:
				print("Animation not found to the DOWN")
		_:	## No Diagonal Animations. Fallback
			print("Nothing ever Matches! Fallback Animation")
			if direction == Globals.Directions.U_RIGHT || direction == Globals.Directions.U_LEFT:
					if animation_player.has_animation(animation_name + "_up"):
						#previous_anim_direction = AnimDirection.DOWN
						#previous_anim_direction = "_down"
						animation_player.play(animation_name + "_up")
					else:
						print("Animation not found to the DOWN")
			elif direction == Globals.Directions.D_RIGHT || direction == Globals.Directions.D_LEFT:
					if animation_player.has_animation(animation_name + "_down"):
						#previous_anim_direction = AnimDirection.DOWN
						#previous_anim_direction = "_down"
						animation_player.play(animation_name + "_down")
					else:
						print("Animation not found to the DOWN")
			#if animation_player.has_animation(animation_name + previous_anim_direction):
				##previous_anim_direction = AnimDirection.RSIDE
				##previous_anim_direction = _animation_end
				#animation_player.play(animation_name + previous_anim_direction)
			#else:
				#print("Animation not found to the " + previous_anim_direction)
			#match previous_anim_direction:
				#AnimDirection.RSIDE:
					#player.animated_sprite_2d.flip_h = false
					#if animation_player.has_animation(animation_name + "_side"):
						#animation_player.play(animation_name + "_side")
					#else:
						#print("Animation not found to the RIGHT")
				#AnimDirection.LSIDE:
					#player.animated_sprite_2d.flip_h = true
					#if animation_player.has_animation(animation_name + "_side"):
						#animation_player.play(animation_name + "_side")
					#else:
						#print("Animation not found to the LEFT")
				#AnimDirection.UP:
					#if animation_player.has_animation(animation_name + "_up"):
						#animation_player.play(animation_name + "_up")
					#else:
						#print("Animation not found to the UP")
				#AnimDirection.DOWN:
					#if animation_player.has_animation(animation_name + "_down"):
						#animation_player.play(animation_name + "_down")
					#else:
						#print("Animation not found to the DOWN")
				#_: 
					#print("No more Fallback. Damn")
