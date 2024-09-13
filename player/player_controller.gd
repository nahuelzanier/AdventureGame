extends CharacterBody2D

@onready var anim_sprite = $AnimatedSprite2D

var speed = 60
var last_direction = Vector2.ZERO

func _ready():
	add_to_group("PLAYER")

func _physics_process(delta):
	var direction = Vector2(2*Input.get_axis("left", "right"), Input.get_axis("up", "down"))
	if direction != Vector2.ZERO:
		last_direction = direction
	handle_animation(direction)
	velocity = speed * direction.normalized()
	move_and_slide()

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
