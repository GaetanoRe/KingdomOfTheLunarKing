extends Control
@export var start_scene : PackedScene

func _on_play_pressed() -> void:
	get_tree().change_scene_to_packed(start_scene)


func _on_quit_pressed() -> void:
	get_tree().quit()
