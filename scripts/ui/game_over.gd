extends Control

@export var main_scene : PackedScene

@export var main_menu : PackedScene

func _ready() -> void:
	var music_player : AudioStreamPlayer = get_node("AudioStreamPlayer")
	music_player.play()


func _on_play_again_pressed() -> void:
	get_tree().change_scene_to_packed(main_scene)




func _on_quit_to_main_menu_pressed() -> void:
	get_tree().change_scene_to_packed(main_menu)
