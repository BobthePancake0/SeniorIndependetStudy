class_name Player
extends CharacterBody2D

@export_category('Resources')
@export var stats : Stats
@export var inventory : Inventory
@export var equipment : Equipment

@export_category("details")
@export var movement_speed = 5:
	get:		## Applies a general multiplier so the changed value can remain visible small and distinct
		return movement_speed * 50 
var direction : Globals.Directions = Globals.Directions.RIGHT
var direction_vector : Vector2 = Vector2(1,0)

@export_category("Animations")
@onready var animation_player: AnimationPlayer = $AnimatedSprite2D/AnimationPlayer
@onready var effects_animation_player: AnimationPlayer = $AnimatedSprite2D/Effects

@export var state_machine : StateMachine

@export_category("Can Do")
@export var has_sword : bool = false
@export var can_roll : bool = false

@export_category("Boxes")
@export var hurt_box : Area2D

### Connects any Signals necessary for the player.
func _ready() -> void:
	stats.damaged.connect(_on_damaged)
	stats.health_depleted.connect(_on_health_depleted)
	
	inventory.item_added.connect(_on_item_added)
	inventory.item_removed.connect(_on_item_removed)
	
	

func _process(_delta):
	queue_redraw()	## Debugging

## Used for Debugging
func _draw() -> void:
	draw_line(Vector2.ZERO, velocity,  Color(1.0, 0.0, 0.0, 1.0), 2.0)
	pass



## Returns the inputted direction based on
## the movement vector
##
## move_left -> -x
## move_right -> x
## move_up -> -y
## move_down -> y
func get_movement_direction() -> Vector2:
	return Input.get_vector("move_left", "move_right", "move_up", "move_down")	


## Sets the players stated direction
## Based on their vectored movement
func setDirection(dir : Vector2) -> Globals.Directions:
	if dir == Vector2.RIGHT: #Vector2(1, 0)
		return Globals.Directions.RIGHT
	elif dir.x > 0 && dir.y > 0: 
		return Globals.Directions.D_RIGHT
	elif dir == Vector2.DOWN: # Vector2(0, 1)
		return Globals.Directions.DOWN
	elif dir.x < 0 && dir.y > 0:
		return Globals.Directions.D_LEFT
	elif dir == Vector2.LEFT: # Vector2(-1, 0)
		return Globals.Directions.LEFT
	elif dir.x < 0 && dir.y < 0:
		return Globals.Directions.U_LEFT
	elif dir == Vector2.UP: # Vector2(0, -1)
		return Globals.Directions.UP
	elif dir. x > 0 && dir.y < 0:
		return Globals.Directions.U_RIGHT

	return direction
	

### SIGNAL CONNECTIONS

## Whenever the player is damaged:
## Force a State Transition into the damage state
## Set the position of the source of the damage (attacker / object)
## Play the hit_flash from the effects animation. 
func _on_damaged(damage_source_pos : Vector2) -> void:
	state_machine.current_state.Transitioned.emit(state_machine.current_state, "DamagedState")
	state_machine.current_state.damage_source_pos = damage_source_pos
	effects_animation_player.play("hit_flash")


## Whene the players health reaches 0
## Queue Gameover Sequence
func _on_health_depleted() -> void:
	print("GAMEOVER!")

## Whenever an Item is added to the inventory
## Perform these Checks:
##
## Sword Check:
##		If the player gets a sword added, they should now be able to attack
func _on_item_added() -> void:
	if (!has_sword):
		for slot : InventorySlot in inventory.weapon_inventory:
			if slot.item is WeaponTest:
				has_sword = true
				get_node("HitBoxes/Marker2D/SwordHitBox").attack_power = slot.item.damage
				return
	pass

## Whenever an Item is added to the Inventory
## Perform these Checks:
##
## Sword Check:
##		If a Sword is removed from the inventory, player should not be able to attack. 
func _on_item_removed() -> void:
	if (has_sword):
		for slot : InventorySlot in inventory.weapon_inventory:
			if slot.item is WeaponTest:
				return
		has_sword = false
		return
	pass
