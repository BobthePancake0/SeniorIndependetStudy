class_name WeaponTest
extends ItemWeapon



func use(_player : Player = null) -> void:
	print("Using " + item_name)
	if _player:
		print(_player.can_roll)
		#_player.state_machine.current_state.Transitioned.emit(_player.state_machine.current_state, "AttackState")
		_player.force_state_transition("AttackState")
	#var x : Player = GameManager.get_parent().get_child(2).get_child(0)
	#print(x)
