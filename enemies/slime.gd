extends CharacterBody2D

@onready var anim_sprite = $AnimatedSprite2D

var target = null
var speed = 20

func _ready():
	add_to_group("ENEMY")

func _physics_process(delta):
	if target:
		velocity = speed * position.direction_to(target.position).normalized()
		anim_sprite.flip_h = velocity.x > 0
	else:
		velocity = Vector2.ZERO
	move_and_slide()

func _on_slime_sense_body_entered(body):
	if body.is_in_group("PLAYER"):
		target = body

func _on_slime_sense_body_exited(body):
	if body.is_in_group("PLAYER"):
		target = null
