extends Control

@export var main_scene : PackedScene

@export var main_menu : PackedScene


func _on_play_again_pressed() -> void:
	get_tree().change_scene_to_packed(main_scene)




func _on_quit_to_main_menu_pressed() -> void:
	get_tree().change_scene_to_packed(main_menu)
