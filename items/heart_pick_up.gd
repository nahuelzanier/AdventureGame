extends Area2D

@onready var audio_stream_player_2d = $AudioStreamPlayer2D
var collected = false

func _on_body_entered(body):
	if not collected:
		hide()
		audio_stream_player_2d.play()
		body.pick_up_health()

func _on_audio_stream_player_2d_finished():
	queue_free()
