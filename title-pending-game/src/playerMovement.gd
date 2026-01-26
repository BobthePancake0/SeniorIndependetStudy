extends CharacterBody2D


@export var speed = 5;

func _ready() -> void:
	pass

func _physics_process(_delta: float) -> void:
	get_movement_input()
	move_and_slide()

func _input(event: InputEvent) -> void:
	pass
	
func get_movement_input():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * (speed * 50) 
		
