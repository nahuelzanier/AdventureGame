extends CharacterBody2D

@onready var audio_stream_player_2d = $AudioStreamPlayer2D
@onready var anim_sprite = $YSort/AnimatedSprite2D
@onready var action = $YSort/PlayerAction
@onready var player_ui = $PlayerUI

var player_max_life = 12
var player_life = 12
var speed = 50
var last_direction = Vector2.ZERO
var knockback = 2

var using_item = false

func _ready():
	Global.player = self
	action.position = anim_sprite.position
	player_ui.update_ui_hearts(player_life)
	add_to_group("PLAYER")

func _input(event):
	if player_life > 0 and not using_item:
		if event.is_action_pressed("action"):
			action.use_item(last_direction)

func _physics_process(delta):
	if player_life > 0 and not using_item:
		var direction = Vector2(2*Input.get_axis("left", "right"), Input.get_axis("up", "down"))
		if direction != Vector2.ZERO:
			last_direction = direction
		handle_walk_animation(direction)
		action.rotation = last_direction.angle()
		velocity = speed * direction.normalized()
		move_and_collide(velocity * delta)

func _on_player_action_using_item_start():
	using_item = true
	handle_attack_animation()

func _on_player_action_using_item_end():
	using_item = false

func take_damage(amount, knock_dir=Vector2.ZERO):
	if player_life > 0:
		audio_stream_player_2d.play()
		player_life -= amount
		player_ui.update_ui_hearts(player_life)
		move_and_collide(knock_dir * knockback)
		if player_life <= 0:
			anim_sprite.play("dead")

func pick_up_health():
	if player_life < player_max_life:
		player_life += 1
		player_ui.update_ui_hearts(player_life)

func _on_animated_sprite_2d_animation_finished():
	if anim_sprite.animation == "dead":
		Global.game_over()

#ANIMATIONS
func handle_walk_animation(a_direction):
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

func handle_attack_animation():
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



