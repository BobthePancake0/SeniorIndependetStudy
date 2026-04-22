class_name Hud
extends Control


@export var current_health_label : Label
@export var max_health_label : Label

var player : Player


func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	print(player.stats)
	
	connect_signals()


func connect_signals() -> void:
	player.stats.health_changed.connect(_on_health_changed)
	pass



func _on_health_changed(new_health : int, max_health : int) -> void:
	if str(new_health) != current_health_label.text:
		current_health_label.text = str(new_health)
	
	if str(max_health) != max_health_label.text:
		max_health_label.text = str(max_health)

	pass
