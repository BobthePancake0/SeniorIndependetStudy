class_name Bomb
extends Node2D

@export var bomb_data : BombResource 

@export var lifetime : float = 5.0


@onready var animation_player: AnimationPlayer = $AnimatedSprite2D/AnimationPlayer
@onready var timer: Timer = $Timer
@onready var hitbox: Hitbox = $Hitbox


var damage : int = 0


#func _init() -> void:
	#if bomb_data:
		#damage = bomb_data.damage

func _ready() -> void:
	if bomb_data:
		damage = bomb_data.damage
		hitbox.attack_power = damage
	timer.start(lifetime)
	animation_player.play("ticking")
	animation_player.speed_scale /= 2
	

func _process(_delta: float) -> void:
	
	if timer.time_left / lifetime <= 0.25:
		animation_player.speed_scale = 1
	

func destroy_bomb() -> void:
	queue_free()


func _on_timer_timeout() -> void:
	timer.stop()
	print(damage)
	print(bomb_data.item_name)
	animation_player.play("explode")
	pass # Replace with function body.
