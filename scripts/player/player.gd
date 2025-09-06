extends CharacterBody2D
class_name Player

var item_anchor : Node2D

# Stats
@export var player_name : String
@export var player_speed : float = 100
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
	var animation_dir : String
	# decide left/right flips from direction_str
	if direction_str == "left":
		animationflip = true
	else:
		animationflip = false

	# map to "side"/"up"/"down" groups
	if direction_str == "left" or direction_str == "right":
		animation_dir = "side"
	else:
		animation_dir = direction_str

	# *** PRIORITY: roll -> walk -> idle ***
	if is_rolling:
		sprite.play("dodge_" + animation_dir)
		sprite.flip_h = animationflip
	elif direction_point != Vector2.ZERO:
		sprite.play("walk_" + animation_dir)
		sprite.flip_h = animationflip
	else:
		sprite.play("idle_" + animation_dir)
		sprite.flip_h = animationflip

func _on_frame_changed():
	if sprite.animation.begins_with("dodge"):
		if sprite.frame == 0:
			hurtbox_col.disabled = true
		elif sprite.frame == sprite.sprite_frames.get_frame_count(sprite.animation) - 1:
			hurtbox_col.disabled = false
