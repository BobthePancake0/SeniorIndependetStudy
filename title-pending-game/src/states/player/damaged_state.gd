class_name DamagedState
extends State

### DAMAGED STATE
## 
## This state contains the logic for when the player is damaged. 
## 
##	This State is FORCED and Cancels other States
##	Find this in the PLAYER script
##
## When Entered:
## 		They are knocked back for a set amount of time
##		They cannot move while in this state
##		Only once the timer ends can they exit into other states
##
## EXITS into ->
##		Move State on input
## 		Idle on Nothing Else

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
	
	
	
## While the player remains in hitstun
## Continue to process knockback
## 
## When they exit from hitstun
## Process the exit state transition conditionals
func physics_update(_delta : float) -> void:
	
	if is_in_hitstun:
		#player.velocity = player.velocity.move_toward(Vector2.ZERO, 500 * _delta)
		process_knockback(knockback_force)
		return

	elif !is_in_hitstun:
		if player.get_movement_direction():
			Transitioned.emit(self, "MoveState")
			return
		else:
			Transitioned.emit(self, "IdleState")
			return
	
	pass

## Calculates the direction of the knockback based off of
##		Where the hit took place
##		The location of the player 
##		The direction the player is facing
##
## Sets the player velocity to that knockback
func process_knockback(knockback_strength : float) -> void:
	var knockback_direction = damage_source_pos.direction_to(player.global_position)
	
	var knockback = (knockback_direction * knockback_strength) * 10
	
	player.velocity = knockback
	player.move_and_slide()
	
	print("Getting knocked back")
	
	
	pass


## When player out of hitstun, remove the timer 
func _on_timer_timeout(timer : Timer) -> void:
	print("Timer Timeouted")
	is_in_hitstun = false
	timer.queue_free()
	pass # Replace with function body.
