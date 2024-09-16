extends "res://enemies/_enemy.gd"

var target = null
var knockback = 10

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
	if body.is_in_group("PLAYER"):
		target = body

func _on_slime_sense_body_exited(body):
	if body.is_in_group("PLAYER"):
		target = null

func recieve_club_attack(attack_angle):
	super(attack_angle)
	move_and_collide(knockback * Vector2.from_angle(attack_angle))
