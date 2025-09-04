extends PlayerMenu

func _ready() -> void:
	close()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		if(is_open):
			close()
		else:
			open()
	
	visible = is_open


func _on_resume_pressed() -> void:
	close()




func _on_controls_pressed() -> void:
	print("Transition to ControlsMenu")




func _on_quit_pressed() -> void:
	get_tree().quit()
