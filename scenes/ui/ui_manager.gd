extends Control

class_name UIManager

var player_ui : PlayerUI

var inventory_ui : InventoryMenu

var pause_menu : PauseMenu

@export var player : Player


func _ready() -> void:
	player_ui = get_node("PlayerUI")
	inventory_ui = get_node("InventoryUI")
	pause_menu = get_node("PauseMenu")
	player_ui.set_max_health(player.player_max_health)
	player_ui.set_max_mana(player.player_max_mana)
	player_ui.set_max_money(player.player_max_money)
	player_ui.set_name_label(player.player_name)

func _process(delta: float) -> void:
	player_ui.set_health(player.player_heath)
	player_ui.set_mana(player.player_mana)
	player_ui.set_money(player.player_money)
