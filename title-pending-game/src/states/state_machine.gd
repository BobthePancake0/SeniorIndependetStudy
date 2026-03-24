class_name StateMachine
extends Node

### The State Machine which holds all the states
##  and runs their processes
##
## Connects each states transition signal to a function
## which will swap one state to the next


@export var initial_state : State

var current_state : State
var states : Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
			
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func _input(event: InputEvent) -> void:
	if current_state:
		current_state.handle_input(event)
	
func on_child_transition(state : State, new_state_name):
	## Checks if not already in state
	if state != current_state:
		print("Already in " + state.name)
		return
	
	## Checks if new state existsz
	var new_state  : State = states.get(new_state_name.to_lower())
	if !new_state:
		print(new_state_name + " does not exist!!!")
		return

	if !state.can_transition(new_state_name):
		print("Illegal Transition!")
		print("Cannot transition from " + state.name + " into " + new_state_name)
		return

	## Checks if the entry into state is allowed
	if !new_state.can_enter():
		print("Cannot enter " + new_state_name + "!\nLook at its file to understand why!")
		return
	
	print("Transitioning: " + current_state.name + " --> " + new_state_name)
	
	if current_state:
		current_state.exit()
	
	new_state.enter()
	
	current_state = new_state
	
	
