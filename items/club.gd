extends Area2D

@onready var collision_shape_2d = $CollisionShape2D
@onready var audio_stream_player_2d = $AudioStreamPlayer2D

const CLUB_SWING = preload("res://assets/sound/club_swing.wav")
const CLUB_HIT = preload("res://assets/sound/club_hit.wav")

var player_action_node

var on_swing = false
var on_recoil = false

var max_attack_angle = PI
var attack_angle_progression = 0
var attack_speed = PI/10

func _process(delta):
	if on_swing:
		if attack_angle_progression >= max_attack_angle:
			on_swing = false
			on_recoil = true
			collision_shape_2d.disabled = true
		player_action_node.rotate(attack_speed)
		attack_angle_progression += attack_speed
	elif on_recoil:
		if attack_angle_progression <= 0:
			on_recoil = false
			player_action_node.action_end()
		player_action_node.rotate(-attack_speed*2)
		attack_angle_progression -= attack_speed*2

func activate(direction):
	play_audio(CLUB_SWING)
	player_action_node.action_start()
	on_swing = true
	collision_shape_2d.disabled = false

func _on_body_entered(body):
	if body.is_in_group("ENEMY"):
		play_audio(CLUB_HIT)
		body.recieve_club_attack(player_action_node.global_position)

func play_audio(sound):
	audio_stream_player_2d.stream = sound
	audio_stream_player_2d.play()
