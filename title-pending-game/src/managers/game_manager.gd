extends Node

### A Global Script for Managing the Game
##
## Determines when to pause 
##
##

enum Mode {NONE, PAUSE, DEBUG}
var mode : Mode = Mode.NONE

var _is_paused : bool = false
var _is_debug : bool = false


func _init() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause") and mode != Mode.DEBUG:
		_is_paused = !_is_paused
		_on_paused()
		print("Game is Paused: " , _is_paused)
	if event.is_action_pressed("debug") and mode != Mode.PAUSE:
		_is_debug = !_is_debug
		_on_debug()
		pass

func get_is_paused() -> bool:
	return _is_paused


func _on_paused() -> void:
	if _is_paused:
		mode = Mode.PAUSE
		get_tree().paused = true
		PauseMenu.show()
	else:
		PauseMenu.hide()
		get_tree().paused = false
		mode = Mode.NONE
		
		print("trying to figure out pausing!")
		
func _on_debug() -> void:
	if _is_debug:
		mode = Mode.DEBUG
		get_tree().paused = true
		DebugMenu.show()
	else:
		DebugMenu.hide()
		get_tree().paused = false
		mode = Mode.NONE
		
		
		
		
