extends CharacterBody2D

@onready var anim_sprite = $AnimatedSprite2D
@onready var enemy_life_bar = $EnemyLife

var target = null
var speed = 0.6
var knockback = 10
var enemy_life = 40

func _ready():
	enemy_life_bar.value = enemy_life
	add_to_group("ENEMY")

func _physics_process(delta):
	if target:
		velocity = speed * position.direction_to(target.position).normalized()
		anim_sprite.flip_h = velocity.x > 0
	else:
		velocity = Vector2.ZERO
	move_and_collide(speed * velocity)

func _on_slime_sense_body_entered(body):
	if body.is_in_group("PLAYER"):
		target = body

func _on_slime_sense_body_exited(body):
	if body.is_in_group("PLAYER"):
		target = null

func take_damage(amount):
	enemy_life -= amount
	enemy_life_bar.value = enemy_life
	if enemy_life <= 0:
		queue_free()

func recieve_club_attack(attack_angle):
	move_and_collide(knockback * Vector2.from_angle(attack_angle))
	take_damage(12)
