extends Control

var is_open = false

func _ready() -> void:
	close()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("inventory"):
		if(is_open):
			close()
		else:
			open()
	
	visible = is_open

func open() -> void:
	is_open = true

func close() -> void:
	is_open = false
