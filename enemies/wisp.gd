extends CharacterBody2D

@onready var anim_sprite = $AnimatedSprite2D

var speed = 40
var last_collision = null
var directions = [Vector2(2, 1), Vector2(2, -1), Vector2(-2, 1), Vector2(-2, -1)]

func _ready():
	add_to_group("ENEMY")
	velocity = speed * directions[randi()%4]

func _physics_process(delta):
	last_collision = move_and_collide(velocity * delta)

func _on_move_timer_timeout():
	if velocity != Vector2.ZERO:
		anim_sprite.play("rolling")
	else:
		anim_sprite.play("idle")
	anim_sprite.flip_h = velocity.x < 0
	if last_collision:
		last_collision = null
		velocity = speed * directions[randi()%4]
