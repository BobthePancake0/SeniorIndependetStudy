class_name State
extends Node

### Base Class for ALL States
##
## Contains mutable functions which each state can 
## edit to their own specifics

signal Transitioned

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
	
	
