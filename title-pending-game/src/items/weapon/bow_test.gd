class_name Bow
extends ItemWeapon

func use(_player : Player = null) -> void:
	if _player:
		## Searches the players inventory for arrows.
		## If there are arrows, allow to transition into the bow state and lower the arrow count by 1
		## If arrows do not exits OR the count is 0, do not transition as no arrows
		## Or play an empty arrow animation, this check could happen in the arrow state instead. 
		_player.force_state_transition("ItemStateBow")
	return
