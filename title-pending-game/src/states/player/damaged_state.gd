class_name DamagedState
extends State

## Player enters the state whenever they recieve damage.
## They are knocked back and are unable to deliver inputs for a couple of frames. 
## It will then deliever immediately back into the Idle State if no input is given.

@export_category("Hit Stun Delay")
@export var hitstun_time : float = 2.0

@export_category("Knockback")
@export var knockback_force : float = 10.0
var damage_source_pos : Vector2

var is_in_hitstun : bool

func enter() -> void:
	## For Debugging
	$"../../StateDebug".text = name
	
	## Creates the Timer for hitstun
	var timer = Timer.new()
	add_child(timer)
	is_in_hitstun = true
	timer.timeout.connect(_on_timer_timeout.bind(timer))
	timer.start(hitstun_time)
	#apply_knockback(player.collided_with.global_position, knockback_force)
	
	
	

func physics_update(_delta : float) -> void:
	
	if is_in_hitstun:
		#player.velocity = player.velocity.move_toward(Vector2.ZERO, 500 * _delta)
		player.process_knockback(damage_source_pos, knockback_force)
		return
		pass

	elif !is_in_hitstun:
		if player.get_movement_direction().length() != 0:
			Transitioned.emit(self, "MoveState")
			return
		
		#elif player.get_movement_direction().length() == 0:
		else:
			Transitioned.emit(self, "IdleState")
			return
	
	pass

#func apply_knockback(attack_pos : Vector2, force : float):
	#var dir = (player.global_position - attack_pos).normalized()
	#player.velocity = dir * force
	#player.move_and_slide()
	#print(player.velocity)

## When player out of hitstun, remove the timer 
func _on_timer_timeout(timer : Timer) -> void:
	print("Timer Timeouted")
	is_in_hitstun = false
	timer.queue_free()
	pass # Replace with function body.
