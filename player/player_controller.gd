extends CharacterBody2D

@onready var anim_sprite = $YSort/AnimatedSprite2D
@onready var action = $YSort/PlayerAction

var speed = 0.9
var last_direction = Vector2.ZERO

var using_item = false

func _ready():
	action.position = anim_sprite.position
	add_to_group("PLAYER")

func _input(event):
	if event.is_action_pressed("action"):
		action.use_item(last_direction)

func _physics_process(delta):
	if not using_item:
		var direction = Vector2(2*Input.get_axis("left", "right"), Input.get_axis("up", "down"))
		if direction != Vector2.ZERO:
			last_direction = direction
		handle_animation(direction)
		action.rotation = last_direction.angle()
		velocity = speed * direction.normalized()
		move_and_collide(velocity)

func handle_animation(a_direction):
	if a_direction.y < 0:
		if a_direction.x != 0:
			anim_sprite.play("walking_side_up")
		else:
			anim_sprite.play("walking_up")
	elif a_direction.y > 0:
		if a_direction.x != 0:
			anim_sprite.play("walking_side_down") 
		else:
			anim_sprite.play("walking_down")
	elif a_direction.x != 0:
		anim_sprite.play("walking_side")
	else:
		if last_direction.y < 0:
			if last_direction.x != 0:
				anim_sprite.play("idle_side_up")
			else:
				anim_sprite.play("idle_up")
		elif last_direction.y > 0:
			if last_direction.x != 0:
				anim_sprite.play("idle_side_down")
			else:
				anim_sprite.play("idle_down")
		else:
			anim_sprite.play("idle_side")
	anim_sprite.flip_h = last_direction.x < 0

func _on_player_action_using_item_start():
	using_item = true
	if last_direction.y < 0:
		if last_direction.x != 0:
			anim_sprite.play("attack_side_up")
		else:
			anim_sprite.play("attack_up")
	elif last_direction.y > 0:
		if last_direction.x != 0:
			anim_sprite.play("attack_side_down") 
		else:
			anim_sprite.play("attack_down")
	elif last_direction.x != 0:
		anim_sprite.play("attack_side")
	anim_sprite.flip_h = last_direction.x < 0

func _on_player_action_using_item_end():
	using_item = false


