extends Node

### A Global Script for Managing the Game
##
## Determines when to pause 
##
##

var _is_paused : bool = false


func _init() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause"):
		_is_paused = !_is_paused
		_on_paused()
		print("Game is Paused: " , _is_paused)

func get_is_paused() -> bool:
	return _is_paused


func _on_paused() -> void:
	if _is_paused:
		get_tree().paused = true
		PauseMenu.show()
	else:
		PauseMenu.hide()
		get_tree().paused = false
		
		print("trying to figure out pausing!")
