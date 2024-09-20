extends CharacterBody2D

@onready var anim_sprite = $AnimatedSprite2D
@onready var enemy_life_bar = $EnemyLife
@onready var audio_stream_player_2d = $AudioStreamPlayer2D

var enemy_life = null
var speed = null
var last_collision = null

func _ready():
	add_to_group("ENEMY")
	enemy_life_bar.max_value = enemy_life
	enemy_life_bar.value = enemy_life

func take_damage(amount):
	enemy_life -= amount
	enemy_life_bar.value = enemy_life
	if enemy_life <= 0:
		Effects.create_effect_at(Effects.DEATH_BUBBLES, position)
		queue_free()

func recieve_club_attack(attack_coords):
	take_damage(12)

func play_audio(sound):
	audio_stream_player_2d.stream = sound
	audio_stream_player_2d.play()
