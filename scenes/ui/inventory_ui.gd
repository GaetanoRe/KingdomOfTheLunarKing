extends PlayerMenu

func _ready() -> void:
	close()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("inventory"):
		if(is_open):
			close()
		else:
			open()
	
	visible = is_open
