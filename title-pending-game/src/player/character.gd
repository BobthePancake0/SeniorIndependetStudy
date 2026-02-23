class_name Character
extends CharacterBody2D

enum Direction {NULL, RIGHT, D_RIGHT, DOWN, D_LEFT, LEFT, U_LEFT, UP, U_RIGHT}
var direction : Direction = Direction.RIGHT
var direction_vector : Vector2 = Vector2(1,0)

@export var stats : Stats
#@export var hitbox_shape : Shape2D

@export_category("details")
@export var movement_speed = 5;

@onready var animation_player: AnimationPlayer = $AnimatedSprite2D/AnimationPlayer
@onready var effects_animation_player: AnimationPlayer = $AnimatedSprite2D/Effects

@export var state_machine : StateMachine


@export_category("Boxes")
@export var hurt_box : Area2D
var collided_with : Node2D

func _ready() -> void:
	stats.health_depleted.connect(_on_health_depleted)
	stats.damaged.connect(_on_damaged)
	

func get_movement_direction() -> Vector2:
	return Input.get_vector("move_left", "move_right", "move_up", "move_down")	

func _physics_process(_delta: float) -> void:
	#move_and_slide()
	pass
	
func _input(_event: InputEvent) -> void:
	
	pass

func _on_damaged(damage_source_pos : Vector2) -> void:
	state_machine.current_state.Transitioned.emit(state_machine.current_state, "DamagedState")
	state_machine.current_state.damage_source_pos = damage_source_pos
	effects_animation_player.play("hit_flash")

	#process_knockback(damage_source_pos)
	

func _on_health_depleted() -> void:
	print("GAMEOVER!")

func _process(_delta):
	queue_redraw()	## Debugging

## Used for Debugging
func _draw() -> void:
	draw_line(Vector2.ZERO, velocity,  Color(1.0, 0.0, 0.0, 1.0), 2.0)
	pass

func setDirection(dir : Vector2) -> Direction:
	if dir == Vector2.RIGHT: #Vector2(1, 0)
		return Direction.RIGHT
	elif dir.x > 0 && dir.y > 0: 
		return Direction.D_RIGHT
	elif dir == Vector2.DOWN: # Vector2(0, 1)
		return Direction.DOWN
	elif dir.x < 0 && dir.y > 0:
		return Direction.D_LEFT
	elif dir == Vector2.LEFT: # Vector2(-1, 0)
		return Direction.LEFT
	elif dir.x < 0 && dir.y < 0:
		return Direction.U_LEFT
	elif dir == Vector2.UP: # Vector2(0, -1)
		return Direction.UP
	elif dir. x > 0 && dir.y < 0:
		return Direction.U_RIGHT

	return direction
	
func matchAttackAngle() -> String:
	match direction:
		Direction.RIGHT:
			return "horizontal_r_attack"
		Direction.LEFT:
			return "horizontal_l_attack"
		Direction.UP:
			return "up_attack"
		Direction.DOWN:
			return "down_attack"
		Direction.D_RIGHT:
			return "diagonal_dr_attack"
		Direction.D_LEFT:
			return "diagonal_dl_attack"
		Direction.U_LEFT:
			return "diagonal_ul_attack"
		Direction.U_RIGHT:
			return "diagonal_ur_attack"
		_:
			return "RESET"
	
	
func process_knockback(damage_source_pos : Vector2, knockback_strength : float) -> void:
	var knockback_direction = damage_source_pos.direction_to(self.global_position)
	
	var knockback = (knockback_direction * knockback_strength) * 10
	
	velocity = knockback
	move_and_slide()
	
	print("Getting knocked back")
	
	
	pass
