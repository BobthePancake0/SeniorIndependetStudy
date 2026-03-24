class_name State
extends Node

### Base Class for ALL States
##
## Contains mutable functions which each state can 
## edit to their own specifics

signal Transitioned

@export var transition_list : Array[String] = []

@export var player : Player		## Reference to the Player Character

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
	
func can_transition(state : String) -> bool:
	
	for state_name in transition_list:
		if state_name.to_lower() == state.to_lower():
			return true
	
	return false
	
	
