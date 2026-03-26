class_name State
extends Node

### Base Class for ALL States
##
## Contains mutable functions which each state can 
## edit to their own specifics

signal Transitioned

@export var transition_list : Array[State] = []

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
	
func can_transition(new_state : State) -> bool:
	
	for state in transition_list:
		if state == new_state:
			return true
	
	return false
	
	
