class_name DamagedState
extends State

## Player enters the state whenever they recieve damage.
## They are knocked back and are unable to deliver inputs for a couple of frames. 
## It will then deliever immediately back into the Idle State if no input is given.

@export_category("Hit Stun Delay")
@export var hitstun_time : float = 2.0
@export var timer : Timer 

@export_category("Knockback")
@export var knockback_force : float = 10.0

var is_in_hitstun : bool

func enter() -> void:
	## For Debugging
	$"../../StateDebug".text = name
	is_in_hitstun = true
	apply_knockback(player.collided_with.global_position, knockback_force)
	timer.start(hitstun_time)
	

func physics_update(_delta : float) -> void:
	
	if is_in_hitstun:
		#player.velocity = player.velocity.move_toward(Vector2.ZERO, 500 * _delta)
		pass

	if !is_in_hitstun:
		if player.get_movement_direction().length() != 0:
			Transitioned.emit(self, "MoveState")
			return
		
		if player.get_movement_direction().length() == 0:
			Transitioned.emit(self, "IdleState")
			return

	pass

func apply_knockback(attack_pos : Vector2, force : float):
	var dir = (player.global_position - attack_pos).normalized()
	player.velocity = dir * force
	player.move_and_slide()
	print(player.velocity)

func _on_timer_timeout() -> void:
	is_in_hitstun = false
	pass # Replace with function body.
