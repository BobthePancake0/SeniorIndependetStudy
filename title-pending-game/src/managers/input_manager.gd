extends Node


func _input(event: InputEvent) -> void:
	if event.is_pressed():
		if get_tree():
			#get_player_input(event)
			var player : Player = get_tree().get_first_node_in_group("Player")
			player.equipment.get_button_input(event)
		
