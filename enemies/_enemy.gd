extends CharacterBody2D

const HEART_PICK_UP = preload("res://items/heart_pick_up.tscn")

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
		call_deferred("loot")
		queue_free()

func loot():
	if randi()%4 == 0:
		var drop = HEART_PICK_UP.instantiate()
		drop.position = position
		Global.current_map.add_child(drop)

func recieve_club_attack(attack_coords):
	take_damage(12)

func play_audio(sound):
	audio_stream_player_2d.stream = sound
	audio_stream_player_2d.play()
