class_name ItemStateBomb
extends State


@export var spawn_distance : float = 84
var spawn_vector : Vector2

var bomb_item_scene : PackedScene = preload("uid://cpcmlwigsnta2")



func enter() -> void:
	print("hitting")
	player.animation_player.play("use_bomb_" + match_angle_name(player.direction))
	


func exit() -> void:
	player.animation_player.stop()


func update(_delta : float) -> void:
	await player.animation_player.animation_finished
	
	#if Input.get_vector("move_left", "move_right", "move_up", "move_down"):
	if player.get_movement_direction():
		Transitioned.emit(self, "MoveState")
	else:
		Transitioned.emit(self, "IdleState")
	pass

func spawn_bomb() -> void:
	var bomb_item : Bomb = bomb_item_scene.instantiate()
	
	## Set the bombs position
	bomb_item.position = player.position
	bomb_item.position += spawn_vector

	get_tree().current_scene.add_child(bomb_item)
	pass

	

func match_angle_name(direction : Globals.Directions) -> String:
	match direction:
		Globals.Directions.RIGHT:
			spawn_vector = Vector2(spawn_distance, 0)
			return "right"
		Globals.Directions.LEFT:
			spawn_vector = Vector2(-spawn_distance, 0)
			return "left"
		Globals.Directions.UP:
			spawn_vector = Vector2(0, -spawn_distance)
			return "up"
		Globals.Directions.DOWN:
			spawn_vector = Vector2(0, spawn_distance)
			return "down"
		Globals.Directions.D_RIGHT:
			spawn_vector = Vector2(calculate_diagonal_distance(), calculate_diagonal_distance())
			return "down_right"
		Globals.Directions.D_LEFT:
			spawn_vector = Vector2(-calculate_diagonal_distance(), calculate_diagonal_distance())
			return "down_left"
		Globals.Directions.U_LEFT:
			spawn_vector = Vector2(-calculate_diagonal_distance(), -calculate_diagonal_distance())
			return "up_left"
		Globals.Directions.U_RIGHT:
			spawn_vector = Vector2(calculate_diagonal_distance(), -calculate_diagonal_distance())
			return "up_right"
		_:
			return "RESET"

func calculate_diagonal_distance() -> int:
	var diagonal = sqrt(pow(spawn_distance, 2) + pow(spawn_distance, 2)) / 2
	return diagonal
	
	
	
	
	
	
