class_name RollState
extends State


var isRolling = false

func enter() -> void:
	## For Debugging
	$"../../StateDebug".text = name
	player.animation_player.play("roll")
	isRolling = true




func update(_delta : float) -> void:
	pass
