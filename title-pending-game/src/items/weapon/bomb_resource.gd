class_name BombResource
extends ItemWeapon

func use(_player : Player = null) -> void:
	print("asdasda")
	if _player:
		_player.force_state_transition("ItemStateBomb")
