extends Area2D

@onready var collision_shape_2d = $CollisionShape2D

var player_action_node

var on_swing = false
var on_recoil = false

var attack_angle = PI
var attack_speed = PI/20

func _process(delta):
	if on_swing:
		if attack_angle <= 0:
			on_swing = false
			on_recoil = true
		player_action_node.rotate(attack_speed)
		attack_angle -= attack_speed
	elif on_recoil:
		if attack_angle >= PI:
			on_recoil = false
			player_action_node.action_end()
			collision_shape_2d.disabled = true
		player_action_node.rotate(-attack_speed)
		attack_angle += attack_speed

func activate(direction):
	player_action_node.action_start()
	on_swing = true
	collision_shape_2d.disabled = false

func _on_body_entered(body):
	if body.is_in_group("ENEMY"):
		body.recieve_club_attack(attack_angle)
