extends CanvasLayer

@onready var menu_button: MenuButton = $Base/MenuButton
var popup_menu : PopupMenu

@onready var label: Label = $Base/Label


var inventory


func _ready() -> void:
	popup_menu = menu_button.get_popup()
	
	popup_menu.id_pressed.connect(_on_id_pressed)
	pass
	

func _on_id_pressed(id : int) -> void:
	change_mode(id)



func change_mode(id : int) -> void:
	match id:
		0:
			label.text = popup_menu.get_item_text(id)
		1: 
			label.text = popup_menu.get_item_text(id)
		2: 
			label.text = popup_menu.get_item_text(id)
		_:
			print()
