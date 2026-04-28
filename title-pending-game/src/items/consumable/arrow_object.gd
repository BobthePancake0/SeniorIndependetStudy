class_name Arrow
extends RigidBody2D

@export var arrow_data : ArrowResource

#@export_category("Variables")


@export_category("Nodes")
@export var timer: Timer 
@export var hitbox: Hitbox

var damage : int = 0
var lifetime : float = 0.0
var speed : float = 0.0

func _ready() -> void:
	if arrow_data:
		get_data()
		
	hitbox.attack_power = damage
	timer.start(lifetime)
	
	fly_arrow()


func get_data() -> void:
	damage = arrow_data.damage
	lifetime = arrow_data.lifetime
	speed = arrow_data.speed


func fly_arrow() -> void:
	var force_vector : Vector2
	print(rotation_degrees)
	match rotation_degrees:
		270.0, -90.0:	# right
			force_vector = Vector2(1.0, 0.0)
		90.0, -270.0:	# left
			force_vector = Vector2(-1.0, 0.0)
		180.0, -180.0:	# up
			force_vector = Vector2(0.0, -1.0)
		0.0, 360.0, -360.0:	# down
			force_vector = Vector2(0.0, 1.0)
		_:	
			force_vector = Vector2(0.0, 0.0)	# dont set a force
	print(force_vector , " ", speed)
	force_vector *= speed
	print(force_vector)
	apply_force(force_vector)
	pass


## On the timergoing out, if the hitbox never hit anything
## Remove the Arrow
func _on_timer_timeout() -> void:
	queue_free()
	pass # Replace with function body.


func _on_hitbox_area_entered(_area: Area2D) -> void:
	print("the other thing!")
	queue_free()
	pass # Replace with function body.
