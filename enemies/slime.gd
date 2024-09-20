extends "res://enemies/_enemy.gd"

const SLIME_WALK = preload("res://assets/sound/slime_walk.wav")
const SLIME_DEATH = preload("res://assets/sound/slime_death.wav")

var target = null
var knockback = 15

func _ready():
	enemy_life = 40
	speed = 20
	super()

func _physics_process(delta):
	if target:
		velocity = speed * position.direction_to(target.position).normalized()
		anim_sprite.flip_h = velocity.x > 0
	else:
		velocity = Vector2.ZERO
	last_collision = move_and_collide(velocity * delta)
	if last_collision and last_collision.get_collider().is_in_group("PLAYER"):
		last_collision.get_collider().take_damage(1, 2*velocity.normalized())

func _on_slime_sense_body_entered(body):
	play_audio(SLIME_WALK)
	target = body

func _on_slime_sense_body_exited(body):
	target = null

func recieve_club_attack(attack_coords):
	super(attack_coords)
	move_and_collide(knockback * attack_coords.direction_to(global_position))
