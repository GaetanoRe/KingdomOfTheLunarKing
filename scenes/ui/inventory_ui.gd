extends PlayerMenu


class_name InventoryMenu

@onready var inventory : Inventory = preload("res://scripts/items/inventory/player_inventory.tres")
var slots: Array

func _ready() -> void:
	close()
	slots = get_node("InventoryRect/GridContainer").get_children()
	
	

func update_slots() -> void:
	for i in range(min(inventory.items.size(), slots.size())):
		slots[i].update(inventory.items[i])



func _process(delta: float) -> void:
	if Input.is_action_just_pressed("inventory"):
		if(is_open):
			close()
		else:
			open()
			update_slots()
	
	visible = is_open
