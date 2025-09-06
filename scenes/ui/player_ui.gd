extends Control


class_name PlayerUI

# Bars
var health_bar : TextureProgressBar
var mana_bar : TextureProgressBar

# Labels
var health_label : Label
var mana_label : Label
var money : Label
var name_label : Label

@onready var max_money : int = 100

func _ready() -> void:
	health_bar = get_node("PlayerInfo/HealthBar")
	mana_bar = get_node("PlayerInfo/ManaBar")
	money = get_node("Money/Label")
	health_label = get_node("PlayerInfo/HealthBar/HealthLabel")
	mana_label = get_node("PlayerInfo/ManaBar/ManaLabel")
	name_label = get_node("PlayerInfo/NameLabel")

func _process(delta: float) -> void:
	health_label.text = str(health_bar.value) + "/" + str(health_bar.max_value)
	mana_label.text = str(mana_bar.value) + "/" + str(mana_bar.max_value)
	


func set_max_health(value : float) -> void:
	health_bar.max_value = value

func set_max_mana(value : float) -> void:
	mana_bar.max_value = value

func set_max_money(value : int) -> void:
	max_money = value

func set_health(value : float) -> void:
	health_bar.value = value

func set_mana(value : float) -> void:
	mana_bar.value = value

func set_money(value : int) -> void:
	money.text = str(value) + "/" + str(max_money)

func set_name_label(value : String) -> void:
	name_label.text = value
