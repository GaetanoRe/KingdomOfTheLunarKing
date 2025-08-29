extends CharacterBody2D
class_name Player

var item_anchor : Node2D
@export var player_speed : float
@export var player_stats : Stats
var direction_point : Vector2
var direction_str : String = "down"



func _ready() -> void:
	item_anchor = get_node("ItemAnchor")



func _physics_process(delta: float) -> void:
	direction_point = Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down")
	if(direction_point != Vector2.ZERO):
		velocity = direction_point * player_speed
	else:
		velocity = Vector2.ZERO
	adjust_player_rotation()
	adjust_item_anchor()
	move_and_slide()
	
	# The below code was to test the rotations of the player
	#test_direction.text = direction_str


func adjust_player_rotation() -> void:
	if(direction_point.x < 0):
		
		direction_str = "left"
	elif(direction_point.x > 0):
		direction_str = "right"
	elif(direction_point.y > 0):
		
		direction_str = "down"
	elif(direction_point.y < 0):
		
		direction_str = "up"
		

func adjust_item_anchor() -> void:
	if(direction_str == "left"):
		item_anchor.global_rotation = deg_to_rad(180)
	elif(direction_str == "right"):
		item_anchor.global_rotation = deg_to_rad(0)
	elif(direction_str == "down"):
		item_anchor.global_rotation = deg_to_rad(90)
	elif(direction_str == "up"):
		item_anchor.global_rotation = deg_to_rad(-90)
