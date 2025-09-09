extends CharacterBody2D
class_name Player

var item_anchor : Node2D

# Stats
@export var player_name : String
@export var player_speed : float = 100
@export var hurt_knockback: float = 200
@export var roll_speed : float = 300
@export var roll_duration : float = 0.35

# UI Info
@export var player_heath : float = 100.0
@export var player_mana : float = 50.0
@export var player_money : int = 0

@export var player_inv : Inventory

var player_max_health : float = 100.0
var player_max_mana : float = 50.0
var player_max_money : int = 100

var hurtbox : Area2D
var hurtbox_col : CollisionShape2D
var direction_point : Vector2
var direction_str : String = "down"
var animationflip : bool = false
var current_anim : String = ""

var sprite : AnimatedSprite2D

# Roll state
var is_rolling: bool = false
var roll_dir: Vector2 = Vector2.ZERO
var roll_time: float = 0.0
var last_facing_dir: Vector2 = Vector2.DOWN

func _ready() -> void:
	item_anchor = get_node("ItemAnchor")
	hurtbox = get_node("Hurtbox")
	hurtbox_col = get_node("Hurtbox/DamageCollision")
	sprite = get_node("AnimatedSprite2D")
	sprite.frame_changed.connect(_on_frame_changed)


func _physics_process(delta: float) -> void:
	if(player_heath == 0):
		var game_over = load("res://scenes/game_over.tscn")
		get_tree().change_scene_to_packed(game_over)
	if is_rolling:
		# Apply locked roll velocity
		velocity = roll_dir * roll_speed
		roll_time += delta
		if roll_time >= roll_duration:
			is_rolling = false
	else:
		# Normal movement
		direction_point = Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down")
		if direction_point != Vector2.ZERO:
			velocity = direction_point * player_speed
			last_facing_dir = direction_point.normalized()
		else:
			velocity = Vector2.ZERO

		# Start roll
	if Input.is_action_just_pressed("dodge"):
		# Use current input if available, otherwise fallback to last facing
		if direction_point != Vector2.ZERO:
			roll_dir = direction_point.normalized()
		else:
			roll_dir = last_facing_dir
		is_rolling = true
		roll_time = 0.0


	adjust_player_rotation()
	adjust_animations()
	adjust_item_anchor()
	move_and_slide()

func adjust_player_rotation() -> void:
	if direction_point.x < 0:
		direction_str = "left"
	elif direction_point.x > 0:
		direction_str = "right"
	elif direction_point.y > 0:
		direction_str = "down"
	elif direction_point.y < 0:
		direction_str = "up"

func adjust_item_anchor() -> void:
	if direction_str == "left":
		item_anchor.global_rotation = deg_to_rad(180)
	elif direction_str == "right":
		item_anchor.global_rotation = deg_to_rad(0)
	elif direction_str == "down":
		item_anchor.global_rotation = deg_to_rad(90)
	elif direction_str == "up":
		item_anchor.global_rotation = deg_to_rad(-90)

func adjust_animations() -> void:
	var animation_dir : String = "side" if (direction_str == "left" or direction_str == "right") else direction_str
	animationflip = (direction_str == "left")

	var target_anim := ""
	if is_rolling:
		target_anim = "dodge_" + animation_dir
	elif direction_point != Vector2.ZERO:
		target_anim = "walk_" + animation_dir
	else:
		target_anim = "idle_" + animation_dir

	if sprite.animation != target_anim or !sprite.is_playing():
		sprite.play(target_anim)
	current_anim = target_anim
	sprite.flip_h = animationflip


func _on_frame_changed():
	if sprite.animation.begins_with("dodge") and sprite.frame == 0:
		print("Animation Started")
		hurtbox_col.disabled = true
	elif sprite.animation.begins_with("dodge") and sprite.frame == 6:
		print("Animation ended!!!") 
		hurtbox_col.disabled = false

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if(area.is_in_group("Hazard")):
		player_heath -= 25
		var knockback_direction = direction_point * -1
		velocity = knockback_direction * hurt_knockback
		move_and_slide()
		print("Hazard Entered Hurtbox")
