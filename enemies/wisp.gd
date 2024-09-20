extends "res://enemies/_enemy.gd"

const WISP_BOUNCE = preload("res://assets/sound/wisp_bounce.wav")

var directions = [Vector2(2, 1), Vector2(2, -1), Vector2(-2, 1), Vector2(-2, -1)]
var last_dir

func _ready():
	enemy_life = 50
	speed = 40
	last_dir = directions[randi()%4]
	velocity = speed * last_dir
	super()

func _physics_process(delta):
	last_collision = move_and_collide(velocity * delta)
	if velocity != Vector2.ZERO:
		anim_sprite.play("rolling")
	else:
		anim_sprite.play("idle")
	anim_sprite.flip_h = velocity.x < 0
	if last_collision:
		if last_collision.get_collider().is_in_group("PLAYER"):
			last_collision.get_collider().take_damage(1, last_dir)
		play_audio(WISP_BOUNCE)
		last_collision = null
		last_dir = directions[randi()%4]
		velocity = speed * last_dir

func recieve_club_attack(attack_coords):
	super(attack_coords)
	last_dir = -last_dir
	velocity = speed * last_dir
